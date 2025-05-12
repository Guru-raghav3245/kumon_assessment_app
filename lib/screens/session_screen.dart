import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/screens/session_summary_screen.dart';

class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({super.key});

  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
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

  void _animateQuestionChange() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(questionProvider);
    final questionNotifier = ref.read(questionProvider.notifier);

    if (questionState.dailyQuestions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion =
        questionState.dailyQuestions[questionState.currentQuestionIndex];

    // Trigger animation when question index changes
    ref.listen<QuestionState>(questionProvider, (prev, next) {
      if (prev?.currentQuestionIndex != next.currentQuestionIndex) {
        _animateQuestionChange();
      }
    });

    return Scaffold(
      appBar: AppBar(
          title: Text('Question ${questionState.currentQuestionIndex + 1}/5')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentQuestion.text,
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                    ...currentQuestion.options.map((option) => RadioListTile<String>(
                          title: Text(option),
                          value: option[0],
                          groupValue: questionState.selectedAnswer,
                          onChanged: questionState.showExplanation
                              ? null
                              : (value) =>
                                  questionNotifier.selectAnswer(value!),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (questionState.showExplanation) ...[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: questionState.showExplanation ? 150 : 0,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          questionState.isAnswerCorrect!
                              ? 'Correct!'
                              : 'Incorrect. Correct answer: ${currentQuestion.correctAnswer}',
                          style: TextStyle(
                            color: questionState.isAnswerCorrect!
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text('Explanation: ${currentQuestion.explanation}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    questionNotifier.nextQuestion();
                    if (questionState.currentQuestionIndex + 1 >= 5) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SessionSummaryScreen(
                            results: questionState.sessionResults,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(questionState.currentQuestionIndex + 1 < 5
                      ? 'Next'
                      : 'Finish'),
                ),
              ] else if (questionState.selectedAnswer != null) ...[
                ElevatedButton(
                  onPressed: questionNotifier.submitAnswer,
                  child: const Text('Submit'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}