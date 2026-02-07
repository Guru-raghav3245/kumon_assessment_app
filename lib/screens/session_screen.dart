import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/screens/session_review_screen.dart';
import 'package:kumon_assessment_app/question_logic/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({super.key});

  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late DateTime _sessionStartTime;
  late List<DateTime> _questionStartTimes;
  late List<int> _questionDurations;

  @override
  void initState() {
    super.initState();
    _sessionStartTime = DateTime.now();
    _questionStartTimes = [DateTime.now()];
    _questionDurations = List.filled(3, 0); // Initialize for 3 questions
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Add the missing _getSubjectFromLevel method
  String _getSubjectFromLevel(QuestionLevel level) {
    final levelStr = level.toString();
    if (levelStr.contains('Comp')) {
      return 'Competency';
    }
    return levelStr.contains('Eng') ? 'English' : 'Math';
  }

  void _animateQuestionChange() {
    _animationController.reset();
    _animationController.forward();
  }

  // Add the missing _resetQuestions method
  Future<void> _resetQuestions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionResults');
    await prefs.setInt('currentQuestionIndex', 0);
  }

  // Modify the submitAnswer method to track question duration
  void submitAnswer() async {
    try {
      final questionState = ref.read(questionProvider);
      final currentQuestionIndex = questionState.currentQuestionIndex;
      
      // Record question duration
      final questionEndTime = DateTime.now();
      final duration = questionEndTime.difference(_questionStartTimes[currentQuestionIndex]).inSeconds;
      _questionDurations[currentQuestionIndex] = duration;
      
      final currentQuestion = questionState.dailyQuestions[questionState.currentQuestionIndex];
      final isCorrect = questionState.selectedAnswer == currentQuestion.correctAnswer;
      final result = {
        'question': currentQuestion.text,
        'userAnswer': questionState.selectedAnswer!,
        'correctAnswer': currentQuestion.correctAnswer,
        'level': currentQuestion.level.toString().split('.').last,
        'duration': duration.toString(),
      };
      final updatedResults = [...questionState.sessionResults, result];

      ref.read(questionProvider.notifier).state = QuestionState(
        dailyQuestions: questionState.dailyQuestions,
        currentQuestionIndex: questionState.currentQuestionIndex,
        selectedAnswer: questionState.selectedAnswer,
        isAnswerCorrect: isCorrect,
        showExplanation: true,
        sessionResults: updatedResults,
        pastSessions: questionState.pastSessions,
        isCooldownActive: questionState.isCooldownActive,
        cooldownEnd: questionState.cooldownEnd,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('sessionResults', jsonEncode(updatedResults));
    } catch (e) {
      print('Error submitting answer: $e');
    }
  }

  // Modify the nextQuestion method to start timing for the next question
  void nextQuestion() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      const totalQuestions = 3;
      
      final questionState = ref.read(questionProvider);
      if (questionState.currentQuestionIndex + 1 < totalQuestions) {
        // Start timing for the next question
        _questionStartTimes.add(DateTime.now());
        
        ref.read(questionProvider.notifier).state = QuestionState(
          dailyQuestions: questionState.dailyQuestions,
          currentQuestionIndex: questionState.currentQuestionIndex + 1,
          selectedAnswer: null,
          isAnswerCorrect: null,
          showExplanation: false,
          sessionResults: questionState.sessionResults,
          pastSessions: questionState.pastSessions,
          isCooldownActive: questionState.isCooldownActive,
          cooldownEnd: questionState.cooldownEnd,
        );
        await prefs.setInt('currentQuestionIndex', questionState.currentQuestionIndex + 1);
      }
    } catch (e) {
      print('Error navigating to next question: $e');
    }
  }

  // Modify the saveSession method to include question durations
  Future<void> saveSession({int duration = 0}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final questionState = ref.read(questionProvider);
      final sessionNumber = questionState.pastSessions.length + 1;
      final today = DateTime.now();
      final dateStr =
          "${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year}";
      final sessionName = "s$sessionNumber $dateStr";

      // Add question durations to results
      final enhancedResults = questionState.sessionResults.asMap().entries.map((entry) {
        final index = entry.key;
        final result = Map<String, dynamic>.from(entry.value);
        if (index < _questionDurations.length) {
          result['duration'] = _questionDurations[index];
        }
        return result;
      }).toList();

      final newSession = Session(
        name: sessionName,
        results: enhancedResults,
        duration: duration,
      );
      final updatedSessions = [...questionState.pastSessions, newSession];
      await prefs.setString('pastSessions',
          jsonEncode(updatedSessions.map((s) => s.toJson()).toList()));

      final now = DateTime.now().millisecondsSinceEpoch;
      final cooldownDuration = 20 * 60 * 60 * 1000;
      final newCooldownEnd = now + cooldownDuration;
      await prefs.setInt('cooldownEnd', newCooldownEnd);

      await _resetQuestions();

      ref.read(questionProvider.notifier).state = QuestionState(
        dailyQuestions: questionState.dailyQuestions,
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

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(questionProvider);
    final questionNotifier = ref.read(questionProvider.notifier);
    const totalQuestions = 3;

    if (questionState.dailyQuestions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion =
        questionState.dailyQuestions[questionState.currentQuestionIndex];
    final subject = _getSubjectFromLevel(currentQuestion.level);
    
    // Updated logic to use formatted name directly
    final rawLevelStr = currentQuestion.level.toString().split('.').last;
    final levelText = formatLevelName(rawLevelStr);

    ref.listen<QuestionState>(questionProvider, (prev, next) {
      if (prev?.currentQuestionIndex != next.currentQuestionIndex ||
          prev?.dailyQuestions != next.dailyQuestions) {
        _animateQuestionChange();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Question ${questionState.currentQuestionIndex + 1}/$totalQuestions'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          levelText,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: subject == 'Competency'
                                        ? Colors.purple
                                        : (subject == 'Math'
                                            ? Colors.blue
                                            : Colors.red),
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentQuestion.text,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ...currentQuestion.options
                            .map((option) => RadioListTile<String>(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  title: Text(option,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  value: option[0],
                                  groupValue: questionState.selectedAnswer,
                                  onChanged: questionState.showExplanation
                                      ? null
                                      : (value) =>
                                          questionNotifier.selectAnswer(value!),
                                  activeColor: Colors.blue,
                                )),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (questionState.showExplanation) ...[
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            questionState.isAnswerCorrect!
                                ? 'Correct!'
                                : 'Incorrect. Correct answer: ${currentQuestion.correctAnswer}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: questionState.isAnswerCorrect!
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Explanation: ${currentQuestion.explanation}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (questionState.currentQuestionIndex + 1 >=
                        totalQuestions) {
                      final duration =
                          DateTime.now().difference(_sessionStartTime).inSeconds;
                      await saveSession(duration: duration);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SessionReviewScreen(
                            session: Session(
                              name:
                                  's${questionState.pastSessions.length + 1} ${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}',
                              results: questionState.sessionResults,
                              duration: duration,
                            ),
                            isNewSession: true,
                          ),
                        ),
                      );
                    } else {
                      nextQuestion();
                    }
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(
                      questionState.currentQuestionIndex + 1 < totalQuestions
                          ? 'Next'
                          : 'Finish'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ] else if (questionState.selectedAnswer != null) ...[
                ElevatedButton.icon(
                  onPressed: submitAnswer,
                  icon: const Icon(Icons.check),
                  label: const Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}