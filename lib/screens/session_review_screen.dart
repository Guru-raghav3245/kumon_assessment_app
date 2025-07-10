import 'package:flutter/material.dart';
import 'package:kumon_assessment_app/models.dart';

class SessionReviewScreen extends StatelessWidget {
  final Session session;
  final bool isNewSession;

  const SessionReviewScreen({
    super.key,
    required this.session,
    this.isNewSession = false,
  });

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }

  String _getMotivationalMessage(int correctCount, int total) {
    if (correctCount == total) {
      return 'Perfect score! Amazing work!';
    } else if (correctCount >= total * 0.7) {
      return 'Great job! You’re almost there!';
    } else if (correctCount >= total * 0.4) {
      return 'Good effort! Keep practicing to improve!';
    } else {
      return 'Don’t give up! Review and try again!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final allQuestions =
        levels.expand((level) => level['questions'] as List<Question>).toList();
    final correctCount =
        session.results.where((r) => r['userAnswer'] == r['correctAnswer']).length;
    final total = session.results.length;
    final percentage = total > 0 ? (correctCount / total * 100) : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(isNewSession ? 'Session Summary' : session.name),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        isNewSession ? 'Session Complete!' : 'Session Summary',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(
                              value: percentage / 100,
                              strokeWidth: 8,
                              backgroundColor: Colors.grey[200],
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                          Text(
                            '${percentage.toStringAsFixed(1)}%',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(
                            'Correct: $correctCount/$total',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.timer, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            'Time: ${_formatDuration(session.duration)}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _getMotivationalMessage(correctCount, total),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.blue,
                              fontStyle: FontStyle.italic,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      if (isNewSession) ...[
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/');
                          },
                          icon: const Icon(Icons.home),
                          label: const Text('Return to Home'),
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
              const SizedBox(height: 24),
              // Question Details
              Text(
                'Question Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: session.results.length,
                itemBuilder: (context, index) {
                  final result = session.results[index];
                  final question = allQuestions.firstWhere(
                    (q) => q.text == result['question'],
                    orElse: () => Question(
                      text: result['question'] ?? 'Unknown question',
                      options: [],
                      correctAnswer: result['correctAnswer'] ?? 'Unknown',
                      explanation: 'No explanation available',
                      level: levels.first['level'] as QuestionLevel,
                    ),
                  );

                  final levelStr = result['level'] ??
                      levels.first['level'].toString().split('.').last;

                  final userAnswerText = question.options.isNotEmpty
                      ? question.getOptionText(result['userAnswer'] ?? 'Unknown')
                      : result['userAnswer'] ?? 'Unknown';

                  final correctAnswerText = question.options.isNotEmpty
                      ? question.getOptionText(result['correctAnswer'] ?? 'Unknown')
                      : result['correctAnswer'] ?? 'Unknown';

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Question: ${result['question'] ?? 'Unknown'} (Level: ${levelStr.replaceFirst('level', '')})',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your Answer: $userAnswerText',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Correct Answer: $correctAnswerText',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.green,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                result['userAnswer'] == result['correctAnswer']
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: result['userAnswer'] ==
                                        result['correctAnswer']
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                result['userAnswer'] == result['correctAnswer']
                                    ? 'Correct'
                                    : 'Incorrect',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: result['userAnswer'] ==
                                              result['correctAnswer']
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}