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
      final maxSessions = 10;
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
      appBar: AppBar(
        title: const Text('Session History'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Trend',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: sessions.isEmpty
                      ? const Center(child: Text('No sessions yet'))
                      : sessions.length == 1
                          ? const Center(
                              child: Text('Need at least 2 sessions for trend'))
                          : LineChart(
                              LineChartData(
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  getDrawingHorizontalLine: (value) => FlLine(
                                      color: Colors.grey.withOpacity(0.2),
                                      strokeWidth: 1),
                                ),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 48,
                                      interval: 20,
                                      getTitlesWidget: (value, meta) {
                                        if (value % 20 != 0) return const SizedBox();
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            '${value.toInt()}%',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(fontSize: 12),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      interval: 1,
                                      getTitlesWidget: (value, meta) {
                                        final index = value.toInt();
                                        if (index >= sessions.length) return const SizedBox();
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'S${index + 1}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(fontSize: 12),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false)),
                                  rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false)),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3), width: 1),
                                ),
                                minX: 0,
                                maxX: (sessions.length > 10
                                        ? 9
                                        : sessions.length - 1)
                                    .toDouble(),
                                minY: 0,
                                maxY: 100,
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: getAccuracySpots(),
                                    isCurved: false,
                                    color: Colors.blue,
                                    barWidth: 4,
                                    dotData: FlDotData(
                                      show: true,
                                      getDotPainter: (spot, percent, barData, index) =>
                                          FlDotSquarePainter(
                                        size: 8,
                                        color: Colors.blue,
                                        strokeWidth: 2,
                                        strokeColor: Colors.white,
                                      ),
                                    ),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: Colors.blue.withOpacity(0.1),
                                    ),
                                  ),
                                ],
                                lineTouchData: LineTouchData(
                                  enabled: true,
                                  touchTooltipData: LineTouchTooltipData(
                                    getTooltipItems: (touchedSpots) =>
                                        touchedSpots.map((spot) {
                                      return LineTooltipItem(
                                        'Session ${spot.x.toInt() + 1}\n${spot.y.toStringAsFixed(1)}%',
                                        Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.white),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Past Sessions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context, index) {
                  final session = sessions[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      leading: const Icon(Icons.book, color: Colors.blue),
                      title: Text(
                        session.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SessionDetailScreen(session: session),
                        ),
                      ),
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
      appBar: AppBar(
        title: Text(session.name),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: ListView.builder(
          itemCount: session.results.length,
          itemBuilder: (context, index) {
            final result = session.results[index];
            final allQuestions = [...level6aQuestions, ...level5aQuestions, ...level4aQuestions];
            final question = allQuestions.firstWhere(
              (q) => q.text == result['question'],
              orElse: () => Question(
                text: result['question']!,
                options: [],
                correctAnswer: result['correctAnswer']!,
                explanation: 'No explanation available',
                level: result['level'] == 'level4a'
                    ? QuestionLevel.level4a
                    : result['level'] == 'level5a'
                        ? QuestionLevel.level5a
                        : QuestionLevel.level6a,
              ),
            );
            final userAnswerText = question.options.isNotEmpty
                ? question.getOptionText(result['userAnswer']!)
                : result['userAnswer']!;
            final correctAnswerText = question.options.isNotEmpty
                ? question.getOptionText(result['correctAnswer']!)
                : result['correctAnswer']!;
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
                      'Question: ${result['question']} (Level: ${result['level']?.replaceFirst('level', '')})',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                          color: result['userAnswer'] == result['correctAnswer']
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          result['userAnswer'] == result['correctAnswer']
                              ? 'Correct'
                              : 'Incorrect',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: result['userAnswer'] == result['correctAnswer']
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
      ),
    );
  }
}