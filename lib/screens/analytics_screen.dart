import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/question_logic/models.dart';
import 'package:fl_chart/fl_chart.dart';

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

    // Calculate analytics data
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
            // Streak Counter
            _buildStreakCard(streak),
            const SizedBox(height: 16),
            
            // Summary Stats
            _buildSummaryCards(analytics),
            const SizedBox(height: 16),
            
            // Weekly/Monthly Progress Charts
            _buildProgressCharts(analytics),
            const SizedBox(height: 16),
            
            // Subject Performance
            _buildSubjectPerformance(analytics),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCard(int streak) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Current Streak',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '$streak days',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 8),
            const Text(
              'Consecutive days with completed sessions',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards(AnalyticsData analytics) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Text(
                    'Total Sessions',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${analytics.totalSessions}',
                    style: const TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Text(
                    'Avg. Accuracy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${analytics.averageAccuracy.toStringAsFixed(1)}%',
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Text(
                    'Avg. Time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDuration(analytics.averageTime),
                    style: const TextStyle(fontSize: 16, color: Colors.orange),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressCharts(AnalyticsData analytics) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= analytics.weeklyAccuracy.length) {
                            return const Text('');
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('Week ${value.toInt() + 1}'),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}%');
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: analytics.weeklyAccuracy.asMap().entries.map((entry) {
                    final index = entry.key;
                    final accuracy = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: accuracy,
                          color: Colors.blue,
                          width: 16,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
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
            const Text(
              'Subject Performance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              children: analytics.subjectPerformance.entries.map((entry) {
                final subject = entry.key;
                final accuracy = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          subject,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: LinearProgressIndicator(
                          value: accuracy / 100,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            accuracy >= 70 ? Colors.green : 
                            accuracy >= 50 ? Colors.orange : Colors.red,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${accuracy.toStringAsFixed(1)}%',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
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

  // Analytics calculation functions
  AnalyticsData _calculateAnalytics(List<Session> sessions) {
    int totalSessions = sessions.length;
    int totalQuestions = 0;
    int correctAnswers = 0;
    int totalTime = 0;
    
    final subjectPerformance = <String, List<int>>{};
    final weeklyAccuracy = <double>[];
    
    // Group sessions by week
    final now = DateTime.now();
    final currentWeek = _getWeekNumber(now);
    final sessionsByWeek = <int, List<Session>>{};
    
    for (var session in sessions) {
      // Parse date from session name (format: "s1 01-01-2023")
      final dateParts = session.name.split(' ')[1].split('-');
      if (dateParts.length == 3) {
        final day = int.parse(dateParts[0]);
        final month = int.parse(dateParts[1]);
        final year = int.parse(dateParts[2]);
        final sessionDate = DateTime(year, month, day);
        final week = _getWeekNumber(sessionDate);
        
        sessionsByWeek.putIfAbsent(week, () => []);
        sessionsByWeek[week]!.add(session);
      }
      
      // Calculate totals
      totalQuestions += session.results.length;
      totalTime += session.duration;
      
      for (var result in session.results) {
        if (result['userAnswer'] == result['correctAnswer']) {
          correctAnswers++;
        }
        
        // Track subject performance
        final level = result['level'] ?? '';
        final subject = level.contains('Eng') ? 'English' : 
                       level.contains('Comp') ? 'Competency' : 'Math';
        
        subjectPerformance.putIfAbsent(subject, () => [0, 0]);
        subjectPerformance[subject]![1]++; // Total questions
        
        if (result['userAnswer'] == result['correctAnswer']) {
          subjectPerformance[subject]![0]++; // Correct answers
        }
      }
    }
    
    // Calculate weekly accuracy
    for (int i = currentWeek - 4; i <= currentWeek; i++) {
      if (sessionsByWeek.containsKey(i)) {
        final weekSessions = sessionsByWeek[i]!;
        int weekCorrect = 0;
        int weekTotal = 0;
        
        for (var session in weekSessions) {
          weekTotal += session.results.length;
          weekCorrect += session.results.where((r) => 
            r['userAnswer'] == r['correctAnswer']).length;
        }
        
        weeklyAccuracy.add(weekTotal > 0 ? (weekCorrect / weekTotal * 100) : 0.0);
      } else {
        weeklyAccuracy.add(0.0);
      }
    }
    
    // Calculate subject performance percentages
    final subjectAccuracy = <String, double>{};
    for (var entry in subjectPerformance.entries) {
      final correct = entry.value[0];
      final total = entry.value[1];
      subjectAccuracy[entry.key] = total > 0 ? (correct / total * 100) : 0.0;
    }
    
    return AnalyticsData(
      totalSessions: totalSessions,
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      totalTime: totalTime,
      averageAccuracy: totalQuestions > 0 ? (correctAnswers / totalQuestions * 100) : 0.0,
      averageTime: totalSessions > 0 ? (totalTime / totalSessions).round() : 0,
      subjectPerformance: subjectAccuracy,
      weeklyAccuracy: weeklyAccuracy,
    );
  }

  int _calculateStreak(List<Session> sessions) {
    if (sessions.isEmpty) return 0;
    
    // Sort sessions by date (newest first)
    final sortedSessions = List<Session>.from(sessions)
      ..sort((a, b) {
        final aDate = _parseDateFromSessionName(a.name);
        final bDate = _parseDateFromSessionName(b.name);
        return bDate.compareTo(aDate);
      });
    
    int streak = 0;
    DateTime currentDate = DateTime.now();
    final today = DateTime(currentDate.year, currentDate.month, currentDate.day);
    
    for (var session in sortedSessions) {
      final sessionDate = _parseDateFromSessionName(session.name);
      final sessionDay = DateTime(sessionDate.year, sessionDate.month, sessionDate.day);
      
      final difference = today.difference(sessionDay).inDays;
      
      if (difference == streak) {
        streak++;
      } else if (difference > streak) {
        break;
      }
    }
    
    return streak;
  }

  DateTime _parseDateFromSessionName(String name) {
    try {
      final dateParts = name.split(' ')[1].split('-');
      if (dateParts.length == 3) {
        final day = int.parse(dateParts[0]);
        final month = int.parse(dateParts[1]);
        final year = int.parse(dateParts[2]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      print('Error parsing date from session name: $e');
    }
    return DateTime.now();
  }

  int _getWeekNumber(DateTime date) {
    final firstDay = DateTime(date.year, 1, 1);
    final daysDiff = date.difference(firstDay).inDays;
    return (daysDiff / 7).floor() + 1;
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