import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';

class SessionScreen extends ConsumerWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionState = ref.watch(questionProvider);
    final questionNotifier = ref.read(questionProvider.notifier);

    if (questionState.dailyQuestions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion =
        questionState.dailyQuestions[questionState.currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
          title: Text('Question ${questionState.currentQuestionIndex + 1}/5')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(currentQuestion.text, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              ...currentQuestion.options.map((option) => RadioListTile<String>(
                    title: Text(option),
                    value: option[0],
                    groupValue: questionState.selectedAnswer,
                    onChanged: questionState.showExplanation
                        ? null
                        : (value) => questionNotifier.selectAnswer(value!),
                  )),
              const SizedBox(height: 20),
              if (questionState.showExplanation) ...[
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    questionNotifier.nextQuestion();
                    // In session_screen.dart, modify the part where you navigate to the summary screen
                    if (questionState.currentQuestionIndex + 1 >= 5) {
                      Navigator.pushReplacementNamed(
                        context,
                        '/summary',
                        arguments: questionState.sessionResults,
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
