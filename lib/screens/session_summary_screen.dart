import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionSummaryScreen extends ConsumerWidget {
   final List<Map<String, String>> results;

  const SessionSummaryScreen({super.key, required this.results});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final correctCount = results
        .where((r) => r['userAnswer'] == r['correctAnswer'])
        .length;
    final total = results.length;
    final percentage = total > 0 ? (correctCount / total * 100).toStringAsFixed(1) : '0.0';

    String getMotivationalMessage() {
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

    return Scaffold(
      appBar: AppBar(title: const Text('Session Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Session Complete!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text('Correct Answers: $correctCount/$total',
                  style: const TextStyle(fontSize: 18)),
              Text('Score: $percentage%',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              Text(
                getMotivationalMessage(),
                style: const TextStyle(fontSize: 18, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
                child: const Text('Return to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}