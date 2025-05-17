import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';
import 'package:kumon_assessment_app/models.dart';
import 'package:kumon_assessment_app/question_bank.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionState {
  final List<Question> dailyQuestions;
  final int currentQuestionIndex;
  final String? selectedAnswer;
  final bool? isAnswerCorrect;
  final bool showExplanation;
  final List<Map<String, String>> sessionResults;
  final List<Session> pastSessions;

  QuestionState({
    required this.dailyQuestions,
    this.currentQuestionIndex = 0,
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

      // Always get new questions when loading state
      final newQuestions = _getRandomQuestions();
      await prefs.setStringList(
          'dailyQuestions', newQuestions.map((q) => q.text).toList());
      await prefs.setInt('currentQuestionIndex', 0);

      state = QuestionState(
        dailyQuestions: newQuestions,
        pastSessions: pastSessions,
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

    // Reset the random seed to get different questions each time
    random.nextInt(100); // This helps ensure different sequences

    for (var level in levels) {
      final questions =
          List<Question>.from(level['questions'] as List<Question>)
            ..shuffle(random);
      final questionsPerSession = level['questionsPerSession'] as int;
      selectedQuestions.addAll(questions.take(questionsPerSession));
    }

    // Sort questions by level (6A first, then 5A, etc.)
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
      final totalQuestions = levels.fold(
          0, (sum, level) => sum + (level['questionsPerSession'] as int));
      if (state.currentQuestionIndex + 1 < totalQuestions) {
        state = QuestionState(
          dailyQuestions: state.dailyQuestions,
          currentQuestionIndex: state.currentQuestionIndex + 1,
          selectedAnswer: null,
          isAnswerCorrect: null,
          showExplanation: false,
          sessionResults: state.sessionResults,
          pastSessions: state.pastSessions,
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

      await _resetQuestions(); // Reset questions immediately after saving session

      state = QuestionState(
        dailyQuestions: state.dailyQuestions,
        currentQuestionIndex: 0,
        sessionResults: [],
        pastSessions: updatedSessions,
      );
    } catch (e) {
      print('Error saving session: $e');
    }
  }
}