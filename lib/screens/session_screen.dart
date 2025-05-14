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

    ref.listen<QuestionState>(questionProvider, (prev, next) {
      if (prev?.currentQuestionIndex != next.currentQuestionIndex ||
          prev?.dailyQuestions != next.dailyQuestions) {
        _animateQuestionChange();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${questionState.currentQuestionIndex + 1}/4'), // Changed to 4
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
                          'Level: ${currentQuestion.level == QuestionLevel.level6a ? '6a' : '5a'}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentQuestion.text,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ...currentQuestion.options.map((option) => RadioListTile<String>(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                              title: Text(option, style: Theme.of(context).textTheme.bodyMedium),
                              value: option[0],
                              groupValue: questionState.selectedAnswer,
                              onChanged: questionState.showExplanation
                                  ? null
                                  : (value) => questionNotifier.selectAnswer(value!),
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
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: questionState.isAnswerCorrect! ? Colors.green : Colors.red,
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
                  onPressed: () {
                    questionNotifier.nextQuestion();
                    if (questionState.currentQuestionIndex + 1 >= 4) { // Changed to 4
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
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(questionState.currentQuestionIndex + 1 < 4 ? 'Next' : 'Finish'), // Changed to 4
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ] else if (questionState.selectedAnswer != null) ...[
                ElevatedButton.icon(
                  onPressed: questionNotifier.submitAnswer,
                  icon: const Icon(Icons.check),
                  label: const Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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