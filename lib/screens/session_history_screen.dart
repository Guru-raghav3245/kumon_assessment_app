import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/models.dart';
import 'package:kumon_assessment_app/question_bank.dart';
import 'package:fl_chart/fl_chart.dart';

class SessionHistoryScreen extends ConsumerWidget {
  const SessionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionState = ref.watch(questionProvider);
    final sessions = questionState.pastSessions;

    List<FlSpot> getAccuracySpots() {
      final maxSessions = 10; // Show up to 10 sessions
      final recentSessions = sessions.length > maxSessions
          ? sessions.sublist(sessions.length - maxSessions)
          : sessions;
      return recentSessions.asMap().entries.map((entry) {
        final index = entry.key.toDouble();
        final session = entry.value;
        final correctCount = session.results
            .where((r) => r['userAnswer'] == r['correctAnswer'])
            .length;
        final total = session.results.length;
        final accuracy = total > 0 ? (correctCount / total) * 100 : 0.0;
        return FlSpot(index, accuracy);
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Session History')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Performance Trend',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: sessions.isEmpty
                  ? const Center(child: Text('No sessions yet'))
                  : LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) =>
                                  Text('${value.toInt()}%'),
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) =>
                                  Text('S${value.toInt() + 1}'),
                            ),
                          ),
                          topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: true),
                        minX: 0,
                        maxX: (sessions.length > 10 ? 9 : sessions.length - 1)
                            .toDouble(),
                        minY: 0,
                        maxY: 100,
                        lineBarsData: [
                          LineChartBarData(
                            spots: getAccuracySpots(),
                            isCurved: true,
                            color: Colors.blue,
                            dotData: const FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.blue.withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Past Sessions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context, index) {
                  final session = sessions[index];
                  return ListTile(
                    title: Text(session.name),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SessionDetailScreen(session: session)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionDetailScreen extends StatelessWidget {
  final Session session;

  const SessionDetailScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(session.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: session.results.length,
          itemBuilder: (context, index) {
            final result = session.results[index];
            final question =
                questionBank.firstWhere((q) => q.text == result['question']);
            final userAnswerText =
                question.getOptionText(result['userAnswer']!);
            final correctAnswerText =
                question.getOptionText(result['correctAnswer']!);
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Question: ${result['question']}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text('Your Answer: $userAnswerText'),
                    Text('Correct Answer: $correctAnswerText',
                        style: const TextStyle(color: Colors.green)),
                    const SizedBox(height: 5),
                    Text(
                      result['userAnswer'] == result['correctAnswer']
                          ? 'Correct'
                          : 'Incorrect',
                      style: TextStyle(
                        color: result['userAnswer'] == result['correctAnswer']
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}