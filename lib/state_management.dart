import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';
import 'package:kumon_assessment_app/question_logic/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionState {
  final List<Question> dailyQuestions;
  final int currentQuestionIndex;
  final String? selectedAnswer;
  final bool? isAnswerCorrect;
  final bool showExplanation;
  final List<Map<String, String>> sessionResults;
  final List<Session> pastSessions;
  final bool isCooldownActive;
  final int? cooldownEnd;

  QuestionState({
    required this.dailyQuestions,
    this.currentQuestionIndex = 0,
    this.selectedAnswer,
    this.isAnswerCorrect,
    this.showExplanation = false,
    this.sessionResults = const [],
    this.pastSessions = const [],
    this.isCooldownActive = false,
    this.cooldownEnd,
  });
}

final questionProvider =
    StateNotifierProvider<QuestionNotifier, QuestionState>((ref) {
  return QuestionNotifier();
});

class QuestionNotifier extends StateNotifier<QuestionState> {
  QuestionNotifier() : super(QuestionState(dailyQuestions: [])) {
    _loadState();
  }

  Future<void> _loadState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedSessions = prefs.getString('pastSessions') ?? '[]';
      final savedCooldownEnd = prefs.getInt('cooldownEnd');
      final now = DateTime.now().millisecondsSinceEpoch;

      List<Session> pastSessions = [];
      try {
        final decodedSessions = jsonDecode(savedSessions);
        if (decodedSessions is List) {
          pastSessions = decodedSessions
              .map((s) => Session.fromJson(Map<String, dynamic>.from(s)))
              .toList();
        }
      } catch (e) {
        print('Error decoding pastSessions: $e');
      }

      bool isCooldownActive =
          savedCooldownEnd != null && now < savedCooldownEnd;
      int? cooldownEnd = isCooldownActive ? savedCooldownEnd : null;

      final newQuestions = _getRandomQuestions();
      await prefs.setStringList(
          'dailyQuestions', newQuestions.map((q) => q.text).toList());
      await prefs.setInt('currentQuestionIndex', 0);

      state = QuestionState(
        dailyQuestions: newQuestions,
        pastSessions: pastSessions,
        isCooldownActive: isCooldownActive,
        cooldownEnd: cooldownEnd,
      );
    } catch (e) {
      print('Error loading state: $e');
      state = QuestionState(
        dailyQuestions: _getRandomQuestions(),
        pastSessions: [],
      );
    }
  }

  List<Question> _getRandomQuestions() {
    final random = Random();
    final selectedQuestions = <Question>[];

    // Get one question from each subject
    final mathQuestions = mathLevels
        .expand((level) => (level['questions'] as List<Question>))
        .where((q) => !q.correctAnswer.contains(','))
        .toList();
    final engQuestions = engLevels
        .expand((level) => (level['questions'] as List<Question>))
        .where((q) => !q.correctAnswer.contains(','))
        .toList();
    final compQuestions = compLevels
        .expand((level) => (level['questions'] as List<Question>))
        .where((q) => !q.correctAnswer.contains(','))
        .toList();

    // Select one random question from each subject
    if (mathQuestions.isNotEmpty) {
      selectedQuestions.add(mathQuestions[random.nextInt(mathQuestions.length)]);
    }
    if (engQuestions.isNotEmpty) {
      selectedQuestions.add(engQuestions[random.nextInt(engQuestions.length)]);
    }
    if (compQuestions.isNotEmpty) {
      selectedQuestions.add(compQuestions[random.nextInt(compQuestions.length)]);
    }

    // Sort questions by level index for consistent ordering
    selectedQuestions.sort((a, b) => a.level.index.compareTo(b.level.index));

    return selectedQuestions;
  }

  Future<void> _resetQuestions() async {
    try {
      final newQuestions = _getRandomQuestions();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('lastReset', DateTime.now().millisecondsSinceEpoch);
      await prefs.setStringList(
          'dailyQuestions', newQuestions.map((q) => q.text).toList());
      await prefs.setInt('currentQuestionIndex', 0);
      await prefs.setString('sessionResults', '[]');

      state = QuestionState(
        dailyQuestions: newQuestions,
        pastSessions: state.pastSessions,
        isCooldownActive: state.isCooldownActive,
        cooldownEnd: state.cooldownEnd,
      );
    } catch (e) {
      print('Error resetting questions: $e');
      state = QuestionState(
        dailyQuestions: _getRandomQuestions(),
        pastSessions: state.pastSessions,
      );
    }
  }

  void selectAnswer(String answer) {
    state = QuestionState(
      dailyQuestions: state.dailyQuestions,
      currentQuestionIndex: state.currentQuestionIndex,
      selectedAnswer: answer,
      isAnswerCorrect: null,
      showExplanation: false,
      sessionResults: state.sessionResults,
      pastSessions: state.pastSessions,
      isCooldownActive: state.isCooldownActive,
      cooldownEnd: state.cooldownEnd,
    );
  }

  void submitAnswer() async {
    try {
      final currentQuestion = state.dailyQuestions[state.currentQuestionIndex];
      final isCorrect = state.selectedAnswer == currentQuestion.correctAnswer;
      final result = {
        'question': currentQuestion.text,
        'userAnswer': state.selectedAnswer!,
        'correctAnswer': currentQuestion.correctAnswer,
        'level': currentQuestion.level.toString().split('.').last,
      };
      final updatedResults = [...state.sessionResults, result];

      state = QuestionState(
        dailyQuestions: state.dailyQuestions,
        currentQuestionIndex: state.currentQuestionIndex,
        selectedAnswer: state.selectedAnswer,
        isAnswerCorrect: isCorrect,
        showExplanation: true,
        sessionResults: updatedResults,
        pastSessions: state.pastSessions,
        isCooldownActive: state.isCooldownActive,
        cooldownEnd: state.cooldownEnd,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('sessionResults', jsonEncode(updatedResults));
    } catch (e) {
      print('Error submitting answer: $e');
    }
  }

  void nextQuestion() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      const totalQuestions = 3; // Changed from 2 to 3
      if (state.currentQuestionIndex + 1 < totalQuestions) {
        state = QuestionState(
          dailyQuestions: state.dailyQuestions,
          currentQuestionIndex: state.currentQuestionIndex + 1,
          selectedAnswer: null,
          isAnswerCorrect: null,
          showExplanation: false,
          sessionResults: state.sessionResults,
          pastSessions: state.pastSessions,
          isCooldownActive: state.isCooldownActive,
          cooldownEnd: state.cooldownEnd,
        );
        await prefs.setInt('currentQuestionIndex', state.currentQuestionIndex);
      }
    } catch (e) {
      print('Error navigating to next question: $e');
    }
  }

  Future<void> saveSession({int duration = 0}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionNumber = state.pastSessions.length + 1;
      final today = DateTime.now();
      final dateStr =
          "${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year}";
      final sessionName = "s$sessionNumber $dateStr";

      final newSession = Session(
        name: sessionName,
        results: state.sessionResults,
        duration: duration,
      );
      final updatedSessions = [...state.pastSessions, newSession];
      await prefs.setString('pastSessions',
          jsonEncode(updatedSessions.map((s) => s.toJson()).toList()));

      final now = DateTime.now().millisecondsSinceEpoch;
      final cooldownDuration = 20 * 1000;
      final newCooldownEnd = now + cooldownDuration;
      await prefs.setInt('cooldownEnd', newCooldownEnd);

      await _resetQuestions();

      state = QuestionState(
        dailyQuestions: state.dailyQuestions,
        currentQuestionIndex: 0,
        sessionResults: [],
        pastSessions: updatedSessions,
        isCooldownActive: true,
        cooldownEnd: newCooldownEnd,
      );
    } catch (e) {
      print('Error saving session: $e');
    }
  }

  Future<void> clearCooldown() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('cooldownEnd');
      state = QuestionState(
        dailyQuestions: state.dailyQuestions,
        currentQuestionIndex: state.currentQuestionIndex,
        selectedAnswer: state.selectedAnswer,
        isAnswerCorrect: state.isAnswerCorrect,
        showExplanation: state.showExplanation,
        sessionResults: state.sessionResults,
        pastSessions: state.pastSessions,
        isCooldownActive: false,
        cooldownEnd: null,
      );
    } catch (e) {
      print('Error clearing cooldown: $e');
    }
  }

  Future<void> deleteSession(Session session) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final updatedSessions =
          state.pastSessions.where((s) => s != session).toList();
      await prefs.setString('pastSessions',
          jsonEncode(updatedSessions.map((s) => s.toJson()).toList()));

      // Reassign session numbers to maintain sequential order
      final reindexedSessions = updatedSessions.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final s = entry.value;
        final dateStr = s.name.split(' ')[1]; // Extract date part
        return Session(
          name: 's$index $dateStr',
          results: s.results,
          duration: s.duration,
        );
      }).toList();

      state = QuestionState(
        dailyQuestions: state.dailyQuestions,
        currentQuestionIndex: state.currentQuestionIndex,
        selectedAnswer: state.selectedAnswer,
        isAnswerCorrect: state.isAnswerCorrect,
        showExplanation: state.showExplanation,
        sessionResults: state.sessionResults,
        pastSessions: reindexedSessions,
        isCooldownActive: state.isCooldownActive,
        cooldownEnd: state.cooldownEnd,
      );

      await prefs.setString('pastSessions',
          jsonEncode(reindexedSessions.map((s) => s.toJson()).toList()));
    } catch (e) {
      print('Error deleting session: $e');
    }
  }

  Future<void> deleteAllSessions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('pastSessions', '[]');

      state = QuestionState(
        dailyQuestions: state.dailyQuestions,
        currentQuestionIndex: state.currentQuestionIndex,
        selectedAnswer: state.selectedAnswer,
        isAnswerCorrect: state.isAnswerCorrect,
        showExplanation: state.showExplanation,
        sessionResults: state.sessionResults,
        pastSessions: [],
        isCooldownActive: state.isCooldownActive,
        cooldownEnd: state.cooldownEnd,
      );
    } catch (e) {
      print('Error deleting all sessions: $e');
    }
  }
}