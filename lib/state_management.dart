import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';
import 'package:kumon_assessment_app/models.dart';
import 'package:kumon_assessment_app/question_bank.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionState {
  final List<Question> dailyQuestions;
  final int currentQuestionIndex;
  final bool isCooldownActive;
  final DateTime? cooldownEnd;
  final String? selectedAnswer;
  final bool? isAnswerCorrect;
  final bool showExplanation;
  final List<Map<String, String>> sessionResults;
  final List<Session> pastSessions;

  QuestionState({
    required this.dailyQuestions,
    this.currentQuestionIndex = 0,
    this.isCooldownActive = false,
    this.cooldownEnd,
    this.selectedAnswer,
    this.isAnswerCorrect,
    this.showExplanation = false,
    this.sessionResults = const [],
    this.pastSessions = const [],
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
      final lastReset = prefs.getInt('lastReset') ?? 0;
      final now = DateTime.now().millisecondsSinceEpoch;
      final cooldownEndMillis = prefs.getInt('cooldownEnd') ?? 0;
      final savedSessions = prefs.getString('pastSessions') ?? '[]';
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

      if (now >= cooldownEndMillis && (now - lastReset) > 20 * 1000) {
        await _resetQuestions();
      } else {
        final savedQuestions = prefs.getStringList('dailyQuestions') ?? [];
        final index = prefs.getInt('currentQuestionIndex') ?? 0;
        final results = prefs.getString('sessionResults') ?? '[]';
        List<Map<String, String>> sessionResults = [];
        try {
          final decodedResults = jsonDecode(results);
          if (decodedResults is List) {
            sessionResults = decodedResults
                .map((r) => Map<String, String>.from(r))
                .toList();
          }
        } catch (e) {
          print('Error decoding sessionResults: $e');
        }

        List<Question> questions = [];
        try {
          questions = savedQuestions
              .map((text) => questionBank.firstWhere(
                    (q) => q.text == text,
                    orElse: () => Question(
                      text: '',
                      options: [],
                      correctAnswer: '',
                      explanation: '',
                    ),
                  ))
              .where((q) => q.text.isNotEmpty)
              .toList();
        } catch (e) {
          print('Error mapping questions: $e');
        }

        state = QuestionState(
          dailyQuestions:
              questions.isNotEmpty ? questions : _getRandomQuestions(),
          currentQuestionIndex: index.clamp(0, questions.length - 1),
          isCooldownActive: now < cooldownEndMillis,
          cooldownEnd: cooldownEndMillis > 0
              ? DateTime.fromMillisecondsSinceEpoch(cooldownEndMillis)
              : null,
          sessionResults: sessionResults,
          pastSessions: pastSessions,
        );
      }
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
    final shuffled = List<Question>.from(questionBank)..shuffle(random);
    return shuffled.take(5).toList();
  }

  Future<void> _resetQuestions() async {
    try {
      final newQuestions = _getRandomQuestions();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('lastReset', DateTime.now().millisecondsSinceEpoch);
      await prefs.setStringList(
          'dailyQuestions', newQuestions.map((q) => q.text).toList());
      await prefs.setInt('currentQuestionIndex', 0);
      await prefs.setInt('cooldownEnd', 0);
      await prefs.setString('sessionResults', '[]');

      state = QuestionState(
        dailyQuestions: newQuestions,
        pastSessions: state.pastSessions,
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
      isCooldownActive: state.isCooldownActive,
      cooldownEnd: state.cooldownEnd,
      selectedAnswer: answer,
      isAnswerCorrect: null,
      showExplanation: false,
      sessionResults: state.sessionResults,
      pastSessions: state.pastSessions,
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
      };
      final updatedResults = [...state.sessionResults, result];

      state = QuestionState(
        dailyQuestions: state.dailyQuestions,
        currentQuestionIndex: state.currentQuestionIndex,
        isCooldownActive: state.isCooldownActive,
        cooldownEnd: state.cooldownEnd,
        selectedAnswer: state.selectedAnswer,
        isAnswerCorrect: isCorrect,
        showExplanation: true,
        sessionResults: updatedResults,
        pastSessions: state.pastSessions,
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
      if (state.currentQuestionIndex + 1 < state.dailyQuestions.length) {
        state = QuestionState(
          dailyQuestions: state.dailyQuestions,
          currentQuestionIndex: state.currentQuestionIndex + 1,
          sessionResults: state.sessionResults,
          pastSessions: state.pastSessions,
        );
        await prefs.setInt('currentQuestionIndex', state.currentQuestionIndex);
      } else {
        await _saveSession();
        final cooldownEnd = DateTime.now().add(const Duration(seconds: 20));
        await prefs.setInt('cooldownEnd', cooldownEnd.millisecondsSinceEpoch);
        state = QuestionState(
          dailyQuestions: state.dailyQuestions,
          currentQuestionIndex: state.currentQuestionIndex,
          isCooldownActive: true,
          cooldownEnd: cooldownEnd,
          sessionResults: state.sessionResults,
          pastSessions: state.pastSessions,
        );
      }
    } catch (e) {
      print('Error navigating to next question: $e');
    }
  }

  Future<void> _saveSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final today = DateTime.now();
      final dateStr =
          "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
      final todaySessions =
          state.pastSessions.where((s) => s.name.startsWith(dateStr)).toList();
      final sessionCount = todaySessions.length + 1;
      final sessionName = sessionCount > 1 ? '$dateStr-$sessionCount' : dateStr;

      final newSession =
          Session(name: sessionName, results: state.sessionResults);
      final updatedSessions = [...state.pastSessions, newSession];
      await prefs.setString('pastSessions',
          jsonEncode(updatedSessions.map((s) => s.toJson()).toList()));

      state = QuestionState(
        dailyQuestions: state.dailyQuestions,
        currentQuestionIndex: state.currentQuestionIndex,
        isCooldownActive: state.isCooldownActive,
        cooldownEnd: state.cooldownEnd,
        sessionResults: [],
        pastSessions: updatedSessions,
      );
    } catch (e) {
      print('Error saving session: $e');
    }
  }

  void checkCooldown() async {
    try {
      final now = DateTime.now();
      if (state.isCooldownActive && now.isAfter(state.cooldownEnd!)) {
        await _resetQuestions();
      }
    } catch (e) {
      print('Error checking cooldown: $e');
    }
  }
}