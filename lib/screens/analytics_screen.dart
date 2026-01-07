import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/question_logic/models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionState = ref.watch(questionProvider);
    final sessions = questionState.pastSessions;

    if (sessions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Progress Analytics'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text('No session data available yet.'),
        ),
      );
    }

    final analytics = _calculateAnalytics(sessions);
    final streak = _calculateStreak(sessions);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Analytics'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopSection(streak, analytics),
            const SizedBox(height: 16),
            _buildProgressCharts(analytics, context),
            const SizedBox(height: 16),
            _buildSubjectPerformance(analytics),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection(int streak, AnalyticsData analytics) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Current Streak',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('$streak days',
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  const SizedBox(height: 8),
                  const Text('Consecutive days with completed sessions',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSummaryCard(
                  'Total Sessions', '${analytics.totalSessions}', Colors.blue),
              const SizedBox(width: 12),
              _buildSummaryCard(
                  'Avg. Accuracy',
                  '${analytics.averageAccuracy.toStringAsFixed(1)}%',
                  Colors.green),
              const SizedBox(width: 12),
              _buildSummaryCard('Avg. Time',
                  _formatDuration(analytics.averageTime), Colors.orange),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.center),
              const SizedBox(height: 6),
              FittedBox(
                  child: Text(value,
                      style: TextStyle(
                          fontSize: 18,
                          color: color,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center)),
            ],
          ),
        ),
      ),
    );
  }

  // lib/screens/analytics_screen.dart

  Widget _buildProgressCharts(AnalyticsData analytics, BuildContext context) {
    final sessionCount = analytics.weeklyAccuracy.length;
    final double chartWidth =
        math.max(MediaQuery.of(context).size.width - 64, sessionCount * 60.0);

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Session History Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 250,
                width: chartWidth,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 110, // Headroom for tooltips
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchExtraThreshold:
                          const EdgeInsets.symmetric(vertical: 250),
                      handleBuiltInTouches: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          double actualValue =
                              analytics.weeklyAccuracy[groupIndex];
                          return BarTooltipItem(
                            '${actualValue.toStringAsFixed(1)}%',
                            const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            int idx = value.toInt();
                            if (idx < 0 || idx >= sessionCount)
                              return const Text('');
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text('S${idx + 1}',
                                  style: const TextStyle(fontSize: 10)),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: 20,
                          getTitlesWidget: (value, meta) {
                            if (value > 100) return const Text('');
                            return Text('${value.toInt()}%',
                                style: const TextStyle(fontSize: 10));
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                    barGroups: List.generate(sessionCount, (index) {
                      final accuracy = analytics.weeklyAccuracy[index];
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            // toY is the data height.
                            // We use a small visual height for 0% so it's visible.
                            toY: accuracy == 0 ? 3.0 : accuracy,
                            color: accuracy == 0
                                ? Colors.blue.withOpacity(0.3)
                                : Colors.blue,
                            width: 18,
                            borderRadius: BorderRadius.circular(4),
                            // backDrawRodData fills the background of the bar,
                            // making the entire vertical column "hittable"
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: 100,
                              color: Colors
                                  .transparent, // Keeps the column hit-box active but invisible
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
                child: Text('Tap anywhere above a session to see percentage',
                    style: TextStyle(fontSize: 10, color: Colors.grey))),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectPerformance(AnalyticsData analytics) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Subject Performance',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...analytics.subjectPerformance.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(entry.key,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                      flex: 3,
                      child: LinearProgressIndicator(
                        value: entry.value / 100,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          entry.value >= 70
                              ? Colors.green
                              : entry.value >= 50
                                  ? Colors.orange
                                  : Colors.red,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text('${entry.value.toStringAsFixed(1)}%',
                            textAlign: TextAlign.right)),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }

  AnalyticsData _calculateAnalytics(List<Session> sessions) {
    int totalQuestions = 0;
    int correctAnswers = 0;
    int totalTime = 0;
    final subjectStats = <String, List<int>>{};

    // Sort oldest to newest for chronological graph
    final sortedSessions = List<Session>.from(sessions)
      ..sort((a, b) => _parseDateFromSessionName(a.name)
          .compareTo(_parseDateFromSessionName(b.name)));

    final sessionAccuracies = sortedSessions.map((session) {
      int sessionCorrect = 0;
      totalQuestions += session.results.length;
      totalTime += session.duration;

      for (var result in session.results) {
        bool isCorrect = result['userAnswer'] == result['correctAnswer'];
        if (isCorrect) {
          correctAnswers++;
          sessionCorrect++;
        }
        final level = result['level'] ?? '';
        final subject = level.contains('Eng')
            ? 'English'
            : level.contains('Comp')
                ? 'Competency'
                : 'Math';
        subjectStats.putIfAbsent(subject, () => [0, 0]);
        subjectStats[subject]![1]++;
        if (isCorrect) subjectStats[subject]![0]++;
      }
      return session.results.isEmpty
          ? 0.0
          : (sessionCorrect / session.results.length * 100);
    }).toList();

    final subjectAccuracy = subjectStats.map((key, val) =>
        MapEntry(key, val[1] > 0 ? (val[0] / val[1] * 100) : 0.0));

    return AnalyticsData(
      totalSessions: sessions.length,
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      totalTime: totalTime,
      averageAccuracy:
          totalQuestions > 0 ? (correctAnswers / totalQuestions * 100) : 0.0,
      averageTime: sessions.isNotEmpty ? (totalTime ~/ sessions.length) : 0,
      subjectPerformance: subjectAccuracy,
      weeklyAccuracy: sessionAccuracies,
    );
  }

  int _calculateStreak(List<Session> sessions) {
    if (sessions.isEmpty) return 0;
    final sortedDates = sessions
        .map((s) => _parseDateFromSessionName(s.name))
        .toList()
      ..sort((a, b) => b.compareTo(a));
    int streak = 0;
    DateTime checkDate = DateTime.now();
    final today = DateTime(checkDate.year, checkDate.month, checkDate.day);

    for (var date in sortedDates) {
      final sessionDay = DateTime(date.year, date.month, date.day);
      final diff = today.difference(sessionDay).inDays;
      if (diff == streak)
        streak++;
      else if (diff > streak) break;
    }
    return streak;
  }

  DateTime _parseDateFromSessionName(String name) {
    try {
      final parts = name.split(' ');
      if (parts.length >= 2) {
        final d = parts[1].split('-');
        return DateTime(int.parse(d[2]), int.parse(d[1]), int.parse(d[0]));
      }
    } catch (_) {}
    return DateTime.now();
  }
}

class AnalyticsData {
  final int totalSessions;
  final int totalQuestions;
  final int correctAnswers;
  final int totalTime;
  final double averageAccuracy;
  final int averageTime;
  final Map<String, double> subjectPerformance;
  final List<double> weeklyAccuracy;

  AnalyticsData({
    required this.totalSessions,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.totalTime,
    required this.averageAccuracy,
    required this.averageTime,
    required this.subjectPerformance,
    required this.weeklyAccuracy,
  });
}
