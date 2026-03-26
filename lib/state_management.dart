import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';
import 'package:kumon_assessment_app/question_logic/models.dart';
import 'package:flutter_riverpod/legacy.dart';

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
  final QuestionLevel? selectedFilterLevel;

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
    this.selectedFilterLevel,
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
      final savedFilterStr = prefs.getString('selectedFilterLevel');
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

      QuestionLevel? savedFilter;
      if (savedFilterStr != null) {
        savedFilter = QuestionLevel.values.firstWhere(
          (e) => e.toString() == savedFilterStr,
          orElse: () => QuestionLevel.levelA,
        );
      }

      // ONE-TIME MIGRATION FOR LEGACY SESSIONS
      await _migrateLegacySessionData();

      final newQuestions = _getRandomQuestions(savedFilter);
      await prefs.setStringList(
          'dailyQuestions', newQuestions.map((q) => q.text).toList());
      await prefs.setInt('currentQuestionIndex', 0);

      state = QuestionState(
        dailyQuestions: newQuestions,
        pastSessions: pastSessions,
        isCooldownActive: isCooldownActive,
        cooldownEnd: cooldownEnd,
        selectedFilterLevel: savedFilter,
      );
    } catch (e) {
      print('Error loading state: $e');
      state = QuestionState(
          dailyQuestions: _getRandomQuestions(null), pastSessions: []);
    }
  }

  /// ONE-TIME MIGRATION: Fixes all legacy sessions (only letter like "C")
  Future<void> _migrateLegacySessionData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSessions = prefs.getString('pastSessions') ?? '[]';
    List<Session> sessions = [];

    try {
      final decoded = jsonDecode(savedSessions);
      if (decoded is List) {
        sessions = decoded
            .map((s) => Session.fromJson(Map<String, dynamic>.from(s)))
            .toList();
      }
    } catch (e) {
      print('Migration decode error: $e');
      return;
    }

    bool changed = false;
    final allQuestions =
        levels.expand((level) => level['questions'] as List<Question>).toList();

    for (var session in sessions) {
      for (var result in session.results) {
        String userAns = result['userAnswer']?.toString() ?? '';
        String correctAns = result['correctAnswer']?.toString() ?? '';

        if (!userAns.contains('.') && userAns.length == 1) {
          final matching = allQuestions.where((q) =>
              q.text.trim() == (result['question']?.toString().trim() ?? ''));
          if (matching.isNotEmpty) {
            final q = matching.first;
            result['userAnswer'] = "$userAns. ${q.getOptionText(userAns)}";
            changed = true;
          }
        }

        if (!correctAns.contains('.') && correctAns.length == 1) {
          final matching = allQuestions.where((q) =>
              q.text.trim() == (result['question']?.toString().trim() ?? ''));
          if (matching.isNotEmpty) {
            final q = matching.first;
            result['correctAnswer'] =
                "$correctAns. ${q.getOptionText(correctAns)}";
            changed = true;
          }
        }
      }
    }

    if (changed) {
      await prefs.setString(
          'pastSessions', jsonEncode(sessions.map((s) => s.toJson()).toList()));
      print('✅ Legacy session data successfully migrated to full option text');
    }
  }

  List<Question> _getRandomQuestions(QuestionLevel? filter) {
    final random = Random();
    final selectedQuestions = <Question>[];

    if (filter == null) {
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

      if (mathQuestions.isNotEmpty) {
        selectedQuestions
            .add(mathQuestions[random.nextInt(mathQuestions.length)]);
      }
      if (engQuestions.isNotEmpty) {
        selectedQuestions
            .add(engQuestions[random.nextInt(engQuestions.length)]);
      }
      if (compQuestions.isNotEmpty) {
        selectedQuestions
            .add(compQuestions[random.nextInt(compQuestions.length)]);
      }

      selectedQuestions.sort((a, b) => a.level.index.compareTo(b.level.index));
    } else {
      final levelMap = levels.firstWhere(
        (l) => l['level'] == filter,
        orElse: () => levels.first,
      );

      final levelQuestions = (levelMap['questions'] as List<Question>)
          .where((q) => !q.correctAnswer.contains(','))
          .toList();

      final shuffled = List<Question>.from(levelQuestions)..shuffle(random);
      selectedQuestions.addAll(shuffled.take(3));
    }

    return selectedQuestions;
  }

  Future<void> setFilter(QuestionLevel? filter) async {
    final prefs = await SharedPreferences.getInstance();
    if (filter == null) {
      await prefs.remove('selectedFilterLevel');
    } else {
      await prefs.setString('selectedFilterLevel', filter.toString());
    }

    state = QuestionState(
      dailyQuestions: state.dailyQuestions,
      currentQuestionIndex: state.currentQuestionIndex,
      selectedAnswer: state.selectedAnswer,
      isAnswerCorrect: state.isAnswerCorrect,
      showExplanation: state.showExplanation,
      sessionResults: state.sessionResults,
      pastSessions: state.pastSessions,
      isCooldownActive: state.isCooldownActive,
      cooldownEnd: state.cooldownEnd,
      selectedFilterLevel: filter,
    );
    await _resetQuestions();
  }

  Future<void> _resetQuestions() async {
    try {
      final newQuestions = _getRandomQuestions(state.selectedFilterLevel);
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
        selectedFilterLevel: state.selectedFilterLevel,
      );
    } catch (e) {
      print('Error resetting questions: $e');
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
      selectedFilterLevel: state.selectedFilterLevel,
    );
  }

  void submitAnswer() async {
    try {
      final currentQuestion = state.dailyQuestions[state.currentQuestionIndex];
      final isCorrect = state.selectedAnswer == currentQuestion.correctAnswer;

      final userAnswerFull =
          "${state.selectedAnswer}. ${currentQuestion.getOptionText(state.selectedAnswer!)}";
      final correctAnswerFull =
          "${currentQuestion.correctAnswer}. ${currentQuestion.getOptionText(currentQuestion.correctAnswer)}";

      final result = {
        'question': currentQuestion.text,
        'userAnswer': userAnswerFull,
        'correctAnswer': correctAnswerFull,
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
        selectedFilterLevel: state.selectedFilterLevel,
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
      const totalQuestions = 3;
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
          selectedFilterLevel: state.selectedFilterLevel,
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
      final cooldownDuration = 20 * 60 * 60 * 1000;
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
        selectedFilterLevel: state.selectedFilterLevel,
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
        selectedFilterLevel: state.selectedFilterLevel,
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

      final reindexedSessions = updatedSessions.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final s = entry.value;
        final dateStr = s.name.split(' ')[1];
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
        selectedFilterLevel: state.selectedFilterLevel,
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
        selectedFilterLevel: state.selectedFilterLevel,
      );
    } catch (e) {
      print('Error deleting all sessions: $e');
    }
  }
}
