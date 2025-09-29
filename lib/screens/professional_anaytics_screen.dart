import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/question_logic/models.dart';
import 'dart:math' as math;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:csv/csv.dart';

// Riverpod provider for user focus area
final focusAreaProvider = StateProvider<String>((ref) => 'None');

class ProfessionalAnalyticsScreen extends ConsumerStatefulWidget {
  const ProfessionalAnalyticsScreen({super.key});

  @override
  ConsumerState<ProfessionalAnalyticsScreen> createState() =>
      _ProfessionalAnalyticsScreenState();
}

class _ProfessionalAnalyticsScreenState
    extends ConsumerState<ProfessionalAnalyticsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  ChartMetric selectedMetric = ChartMetric.accuracy;
  ChartTimeframe selectedTimeframe = ChartTimeframe.allTime;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _calculateAnalytics(List<Session> sessions) {
    if (sessions.isEmpty) {
      return {
        'totalSessions': 0,
        'averageScore': 0.0,
        'totalQuestions': 0,
        'correctAnswers': 0,
        'averageDuration': 0,
        'subjectPerformance': <String, Map<String, dynamic>>{},
        'weeklyProgress': <Map<String, dynamic>>[],
        'streakInfo': {'current': 0, 'best': 0},
        'timeAnalysis': <String, dynamic>{},
        'difficultyAnalysis': <String, dynamic>{},
      };
    }

    int totalQuestions = 0;
    int correctAnswers = 0;
    int totalDuration = 0;
    Map<String, Map<String, int>> subjectStats = {};
    List<Map<String, dynamic>> sessionData = [];

    for (var session in sessions) {
      int sessionCorrect = 0;
      int sessionTotal = session.results.length;
      totalQuestions += sessionTotal;

      for (var result in session.results) {
        if (result['userAnswer'] == result['correctAnswer']) {
          correctAnswers++;
          sessionCorrect++;
        }

        String subject = _getSubjectFromLevel(result['level'] ?? '');
        subjectStats[subject] ??= {'correct': 0, 'total': 0};
        subjectStats[subject]!['total'] = subjectStats[subject]!['total']! + 1;
        if (result['userAnswer'] == result['correctAnswer']) {
          subjectStats[subject]!['correct'] =
              subjectStats[subject]!['correct']! + 1;
        }
      }

      totalDuration += session.duration;
      sessionData.add({
        'name': session.name,
        'score': sessionTotal > 0 ? (sessionCorrect / sessionTotal * 100) : 0,
        'duration': session.duration,
        'totalQuestions': sessionTotal,
        'date': _extractDateFromSessionName(session.name),
      });
    }

    // Calculate streaks based on dates
    Map<String, int> streakInfo = _calculateDateBasedStreaks(sessions);

    // Calculate time analysis
    Map<String, dynamic> timeAnalysis = _analyzeResponseTimes(sessions);

    return {
      'totalSessions': sessions.length,
      'averageScore':
          totalQuestions > 0 ? (correctAnswers / totalQuestions * 100) : 0.0,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'averageDuration':
          sessions.isNotEmpty ? (totalDuration / sessions.length) : 0,
      'subjectPerformance': subjectStats,
      'weeklyProgress': sessionData,
      'streakInfo': streakInfo,
      'timeAnalysis': timeAnalysis,
      'difficultyAnalysis': _analyzeDifficulty(sessions),
    };
  }

  String _getSubjectFromLevel(String level) {
    if (level.toLowerCase().contains('comp')) return 'Competency';
    if (level.toLowerCase().contains('eng')) return 'English';
    if (level.toLowerCase().contains('math') ||
        level.toLowerCase().contains('level')) {
      return 'Math';
    }
    return 'Unknown';
  }

  DateTime _extractDateFromSessionName(String sessionName) {
    try {
      final parts = sessionName.split(' ');
      if (parts.length >= 2) {
        final datePart = parts[1];
        final dateComponents = datePart.split('-');
        if (dateComponents.length == 3) {
          return DateTime(
            int.parse(dateComponents[2]),
            int.parse(dateComponents[1]),
            int.parse(dateComponents[0]),
          );
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid session date format: $sessionName')),
      );
      return DateTime.now();
    } catch (e) {
      print('Error parsing date: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error parsing session date')),
      );
      return DateTime.now();
    }
  }

  Map<String, int> _calculateDateBasedStreaks(List<Session> sessions) {
    if (sessions.isEmpty) return {'current': 0, 'best': 0};

    final sortedSessions = List<Session>.from(sessions)
      ..sort((a, b) => _extractDateFromSessionName(a.name)
          .compareTo(_extractDateFromSessionName(b.name)));

    int currentStreak = 1;
    int bestStreak = 1;
    DateTime? previousDate =
        _extractDateFromSessionName(sortedSessions[0].name);

    for (int i = 1; i < sortedSessions.length; i++) {
      final currentDate = _extractDateFromSessionName(sortedSessions[i].name);
      final difference = currentDate.difference(previousDate!).inDays;

      if (difference == 1) {
        currentStreak++;
        bestStreak = currentStreak > bestStreak ? currentStreak : bestStreak;
      } else if (difference > 1) {
        currentStreak = 1;
      }

      previousDate = currentDate;
    }

    return {'current': currentStreak, 'best': bestStreak};
  }

  Map<String, dynamic> _analyzeResponseTimes(List<Session> sessions) {
    List<int> allTimes = [];
    Map<String, List<int>> subjectTimes = {};

    for (var session in sessions) {
      for (var result in session.results) {
        dynamic durationValue = result['duration'];
        int duration = 0;

        if (durationValue is String) {
          duration = int.tryParse(durationValue) ?? 0;
        } else if (durationValue is int) {
          duration = durationValue;
        } else if (durationValue is double) {
          duration = durationValue.toInt();
        }

        if (duration > 0) {
          allTimes.add(duration);
          String subject = _getSubjectFromLevel(result['level'] ?? '');
          subjectTimes[subject] ??= [];
          subjectTimes[subject]!.add(duration);
        }
      }
    }

    if (allTimes.isEmpty) {
      return {'average': 0, 'fastest': 0, 'slowest': 0, 'subjectAverages': {}};
    }

    allTimes.sort();
    Map<String, int> subjectAverages = {};

    for (var entry in subjectTimes.entries) {
      if (entry.value.isNotEmpty) {
        subjectAverages[entry.key] =
            entry.value.reduce((a, b) => a + b) ~/ entry.value.length;
      }
    }

    return {
      'average': allTimes.reduce((a, b) => a + b) ~/ allTimes.length,
      'fastest': allTimes.first,
      'slowest': allTimes.last,
      'subjectAverages': subjectAverages,
    };
  }

  Map<String, dynamic> _analyzeDifficulty(List<Session> sessions) {
    Map<String, Map<String, int>> levelStats = {};

    for (var session in sessions) {
      for (var result in session.results) {
        String level = result['level']?.toString() ?? 'Unknown';
        levelStats[level] ??= {'correct': 0, 'total': 0};
        levelStats[level]!['total'] = levelStats[level]!['total']! + 1;

        String userAnswer = result['userAnswer']?.toString() ?? '';
        String correctAnswer = result['correctAnswer']?.toString() ?? '';

        if (userAnswer == correctAnswer) {
          levelStats[level]!['correct'] = levelStats[level]!['correct']! + 1;
        }
      }
    }

    String weakestArea = '';
    double lowestAccuracy = 100.0;

    for (var entry in levelStats.entries) {
      double accuracy = entry.value['total']! > 0
          ? (entry.value['correct']! / entry.value['total']!) * 100
          : 0.0;
      if (accuracy < lowestAccuracy) {
        lowestAccuracy = accuracy;
        weakestArea = entry.key;
      }
    }

    List<String> orderedLevels = levelStats.keys.toList();
    orderedLevels.sort((a, b) {
      List<String> priorityOrder = ['Competency', 'Math', 'English'];
      int aIndex = priorityOrder
          .indexWhere((s) => a.toLowerCase().contains(s.toLowerCase()));
      int bIndex = priorityOrder
          .indexWhere((s) => b.toLowerCase().contains(s.toLowerCase()));
      if (aIndex != -1 && bIndex != -1) {
        return aIndex.compareTo(bIndex);
      } else if (aIndex != -1) {
        return -1;
      } else if (bIndex != -1) {
        return 1;
      }
      return a.compareTo(b);
    });

    return {
      'levelStats': levelStats,
      'weakestArea': weakestArea,
      'weakestAccuracy': lowestAccuracy,
      'orderedLevels': orderedLevels,
    };
  }

  Future<void> _generateAnalyticsPdf(List<Session> sessions) async {
    final pdf = pw.Document();
    final analytics = _calculateAnalytics(sessions);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text('Professional Analytics Report',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Summary Statistics',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Total Sessions: ${analytics['totalSessions']}'),
                pw.Text(
                    'Average Score: ${analytics['averageScore'].toStringAsFixed(1)}%'),
                pw.Text('Total Questions: ${analytics['totalQuestions']}'),
                pw.Text('Correct Answers: ${analytics['correctAnswers']}'),
                pw.Text(
                    'Average Duration: ${_formatDuration(analytics['averageDuration'].toInt())}'),
                pw.Text(
                    'Current Streak: ${analytics['streakInfo']['current']} days'),
                pw.Text('Best Streak: ${analytics['streakInfo']['best']} days'),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text('Subject Performance',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            ...analytics['subjectPerformance'].entries.map((entry) {
              final subject = entry.key;
              final stats = entry.value;
              final accuracy = stats['total'] > 0
                  ? (stats['correct'] / stats['total'] * 100)
                  : 0.0;
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                      '$subject: ${accuracy.toStringAsFixed(1)}% (${stats['correct']}/${stats['total']})'),
                ],
              );
            }).toList(),
          ];
        },
      ),
    );

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/professional_analytics.pdf');
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Professional Analytics Report',
      subject: 'Kumon Analytics Results',
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }

  Future<void> _generateAnalyticsCsv(List<Session> sessions) async {
    final analytics = _calculateAnalytics(sessions);
    final csvData = <List<dynamic>>[];

    csvData.add(['Metric', 'Value']);
    csvData.add(['Total Sessions', analytics['totalSessions']]);
    csvData.add(
        ['Average Score (%)', analytics['averageScore'].toStringAsFixed(1)]);
    csvData.add(['Total Questions', analytics['totalQuestions']]);
    csvData.add(['Correct Answers', analytics['correctAnswers']]);
    csvData.add(['Average Duration (s)', analytics['averageDuration']]);
    csvData.add(['Current Streak (days)', analytics['streakInfo']['current']]);
    csvData.add(['Best Streak (days)', analytics['streakInfo']['best']]);
    csvData.add(['']);
    csvData.add(['Subject Performance']);
    for (var entry in analytics['subjectPerformance'].entries) {
      final subject = entry.key;
      final stats = entry.value;
      final accuracy =
          stats['total'] > 0 ? (stats['correct'] / stats['total'] * 100) : 0.0;
      csvData.add(['$subject Accuracy (%)', accuracy.toStringAsFixed(1)]);
      csvData.add(['$subject Correct', stats['correct']]);
      csvData.add(['$subject Total', stats['total']]);
    }

    final csvString = const ListToCsvConverter().convert(csvData);
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/professional_analytics.csv');
    await file.writeAsString(csvString);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Professional Analytics Report',
      subject: 'Kumon Analytics Results',
    );
  }

  Widget _buildOverviewTab(Map<String, dynamic> analytics) {
    String weakestMetric = _getWeakestMetric(analytics);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (weakestMetric.isNotEmpty) ...[
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.red[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        weakestMetric,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[800],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(focusAreaProvider.notifier).state =
                            weakestMetric.contains('Math') ? 'Math' : 
                            weakestMetric.contains('English') ? 'English' : 
                            weakestMetric.contains('Competency') ? 'Competency' : 
                            weakestMetric.contains('time') ? 'Speed' : 'Consistency';
                        // Navigate to practice screen with focus area
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red[800]),
                      child: Text('Practice Now', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          _buildMetricsGrid(analytics),
          const SizedBox(height: 24),
          _buildPerformanceChart(analytics),
          const SizedBox(height: 24),
          _buildSubjectPerformance(analytics),
          const SizedBox(height: 24),
          _buildQuickInsights(analytics),
        ],
      ),
    );
  }

  String _getWeakestMetric(Map<String, dynamic> analytics) {
    double averageScore = analytics['averageScore'] ?? 0.0;
    int avgResponseTime = (analytics['timeAnalysis']['average'] ?? 0).toInt();
    int currentStreak = analytics['streakInfo']['current'] ?? 0;
    Map<String, Map<String, int>> subjectPerf = Map<String, Map<String, int>>.from(analytics['subjectPerformance']);
    String weakestSubject = '';
    double lowestAccuracy = 100.0;

    for (var entry in subjectPerf.entries) {
      double accuracy = entry.value['total']! > 0
          ? (entry.value['correct']! / entry.value['total']!) * 100
          : 0.0;
      if (accuracy < lowestAccuracy) {
        lowestAccuracy = accuracy;
        weakestSubject = entry.key;
      }
    }

    if (averageScore < 60) {
      return 'Your overall accuracy is ${averageScore.toStringAsFixed(1)}%. Focus on improving your correctness.';
    } else if (lowestAccuracy < 70 && weakestSubject.isNotEmpty) {
      return 'Your $weakestSubject accuracy is ${lowestAccuracy.toStringAsFixed(1)}%. Practice more in this area.';
    } else if (avgResponseTime > 60) {
      return 'Your response time is ${_formatDuration(avgResponseTime)}. Work on answering faster.';
    } else if (currentStreak < 3) {
      return 'Your current streak is $currentStreak days. Build consistency with daily practice.';
    }
    return '';
  }

  Widget _buildMetricsGrid(Map<String, dynamic> analytics) {
    List<Map<String, dynamic>> metrics = [
      {'title': 'Sessions', 'value': analytics['totalSessions'].toString(), 'icon': Icons.quiz, 'color': Colors.blue},
      {'title': 'Avg Score', 'value': '${analytics['averageScore'].toStringAsFixed(1)}%', 'icon': Icons.trending_up, 'color': Colors.green},
      {'title': 'Questions', 'value': analytics['totalQuestions'].toString(), 'icon': Icons.help_outline, 'color': Colors.orange},
      {'title': 'Duration', 'value': '${(analytics['averageDuration'] / 60).toStringAsFixed(1)}m', 'icon': Icons.timer, 'color': Colors.purple},
    ];
    metrics.sort((a, b) {
      if (a['title'] == 'Avg Score' && double.parse(a['value'].replaceAll('%', '')) < 70) return -1;
      if (b['title'] == 'Avg Score' && double.parse(b['value'].replaceAll('%', '')) < 70) return 1;
      if (a['title'] == 'Duration' && analytics['averageDuration'] > 3600) return -1;
      if (b['title'] == 'Duration' && analytics['averageDuration'] > 3600) return 1;
      return 0;
    });

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.0,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.all(8),
      children: metrics
          .map((metric) => _buildMetricCard(
                metric['title'],
                metric['value'],
                metric['icon'],
                metric['color'],
              ))
          .toList(),
    );
  }

  Widget _buildMetricCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(4),
      child: Semantics(
        label: '$title: $value',
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 24, semanticLabel: title),
              const SizedBox(height: 6),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPerformanceChart(Map<String, dynamic> analytics) {
    List<Map<String, dynamic>> sessions =
        _filterSessionsByTimeframe(List<Map<String, dynamic>>.from(analytics['weeklyProgress']));

    if (
        sessions.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Icon(Icons.bar_chart, size: 48, color: Colors.grey),
              const SizedBox(height: 16),
              Text('No session data available',
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Trend',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<ChartMetric>(
                  value: selectedMetric,
                  onChanged: (value) => setState(() => selectedMetric = value!),
                  items: ChartMetric.values
                      .map((metric) => DropdownMenuItem(
                            value: metric,
                            child: Text(metric.toString().split('.').last),
                          ))
                      .toList(),
                ),
                DropdownButton<ChartTimeframe>(
                  value: selectedTimeframe,
                  onChanged: (value) => setState(() => selectedTimeframe = value!),
                  items: ChartTimeframe.values
                      .map((timeframe) => DropdownMenuItem(
                            value: timeframe,
                            child: Text(timeframe.toString().split('.').last),
                          ))
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: CustomPaint(
                painter: _LineChartPainter(sessions, metric: selectedMetric),
                size: const Size(double.infinity, 200),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _filterSessionsByTimeframe(List<Map<String, dynamic>> sessions) {
    final now = DateTime.now();
    return sessions.where((session) {
      final sessionDate = _extractDateFromSessionName(session['name']);
      if (selectedTimeframe == ChartTimeframe.last7Days) {
        return sessionDate.isAfter(now.subtract(const Duration(days: 7)));
      } else if (selectedTimeframe == ChartTimeframe.last30Days) {
        return sessionDate.isAfter(now.subtract(const Duration(days: 30)));
      }
      return true; // allTime
    }).toList();
  }

  Widget _buildSubjectPerformance(Map<String, dynamic> analytics) {
    Map<String, Map<String, int>> subjectPerformance =
        Map<String, Map<String, int>>.from(analytics['subjectPerformance']);
    List<Map<String, dynamic>> recentSessions =
        List<Map<String, dynamic>>.from(analytics['weeklyProgress']).reversed.take(5).toList();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subject Performance',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ...subjectPerformance.entries.map((entry) {
              String subject = entry.key;
              int correct = entry.value['correct'] ?? 0;
              int total = entry.value['total'] ?? 0;
              double percentage = total > 0 ? (correct / total) * 100 : 0;
              double trend = _calculateSubjectTrend(subject, recentSessions);
              Color color = subject == 'Math'
                  ? Colors.blue
                  : subject == 'English'
                      ? Colors.red
                      : Colors.purple;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(subject,
                            style: const TextStyle(fontWeight: FontWeight.w600)),
                        Row(
                          children: [
                            Text(
                                '${percentage.toStringAsFixed(1)}% ($correct/$total)',
                                style: TextStyle(
                                    color: color, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Icon(
                              trend > 0
                                  ? Icons.arrow_upward
                                  : (trend < 0 ? Icons.arrow_downward : Icons.remove),
                              color: trend > 0
                                  ? Colors.green
                                  : (trend < 0 ? Colors.red : Colors.grey),
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: percentage / 100,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  double _calculateSubjectTrend(String subject, List<Map<String, dynamic>> sessions) {
    if (sessions.length < 2) return 0.0;
    double recentScore = 0.0;
    double olderScore = 0.0;
    int recentCount = 0;
    int olderCount = 0;

    for (int i = 0; i < sessions.length; i++) {
      if (i < sessions.length ~/ 2) {
        recentScore += sessions[i]['score'] as double;
        recentCount++;
      } else {
        olderScore += sessions[i]['score'] as double;
        olderCount++;
      }
    }

    return (recentCount > 0 && olderCount > 0)
        ? (recentScore / recentCount) - (olderScore / olderCount)
        : 0.0;
  }

  Widget _buildQuickInsights(Map<String, dynamic> analytics) {
    List<Map<String, dynamic>> insights = _generateInsights(analytics);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Insights',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 16),
            ...insights
                .map((insight) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.lightbulb,
                              color: Colors.yellow, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              insight['description'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTab(BuildContext context, Map<String, dynamic> analytics) {
    Map<String, dynamic> difficultyAnalysis = analytics['difficultyAnalysis'];
    List<String> orderedLevels = difficultyAnalysis['orderedLevels'] ?? [];
    Map<String, Map<String, int>> levelStats = difficultyAnalysis['levelStats'];
    bool isStruggling = (analytics['averageScore'] ?? 0.0) < 70;

    List<String> customOrderedLevels = [];
    List<String> competencyLevels = [];
    List<String> mathLevels = [];
    List<String> englishLevels = [];
    List<String> otherLevels = [];

    for (String level in orderedLevels) {
      if (level.toLowerCase().contains('comp')) {
        competencyLevels.add(level);
      } else if (level.toLowerCase().contains('math') ||
          level.toLowerCase().contains('level')) {
        mathLevels.add(level);
      } else if (level.toLowerCase().contains('eng')) {
        englishLevels.add(level);
      } else {
        otherLevels.add(level);
      }
    }

    competencyLevels.sort();
    mathLevels.sort();
    englishLevels.sort();
    otherLevels.sort();

    customOrderedLevels.addAll(competencyLevels);
    customOrderedLevels.addAll(mathLevels);
    customOrderedLevels.addAll(englishLevels);
    customOrderedLevels.addAll(otherLevels);

    List<String> displayedLevels = isStruggling
        ? customOrderedLevels.where((level) {
            final stats = levelStats[level] ?? {'correct': 0, 'total': 0};
            return stats['total']! > 0 &&
                (stats['correct']! / stats['total']!) * 100 < 70;
          }).toList()
        : customOrderedLevels;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Difficulty Analysis',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          if (displayedLevels.isEmpty)
            const Text('No low-performing levels to focus on. Keep it up!'),
          ...displayedLevels.map((level) {
            Map<String, int> stats =
                levelStats[level] ?? {'correct': 0, 'total': 0};
            double percentage = stats['total']! > 0
                ? (stats['correct']! / stats['total']!) * 100
                : 0;
            Color color = percentage >= 70
                ? Colors.green
                : percentage >= 40
                    ? Colors.orange
                    : Colors.red;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        level,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${percentage.toStringAsFixed(1)}% (${stats['correct']}/${stats['total']})',
                        style:
                            TextStyle(color: color, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRecommendationsTab(
      BuildContext context, Map<String, dynamic> analytics) {
    List<Map<String, dynamic>> recommendations =
        _generateRecommendations(analytics);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Areas for Improvement',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          ...recommendations.map((rec) => Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Colors.grey[850],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(rec['icon'], color: rec['color'], size: 32),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              rec['title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        rec['description'],
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      ...rec['tips']
                          .map<Widget>((tip) => Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.arrow_right,
                                        color: Colors.white70, size: 16),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        tip,
                                        style: const TextStyle(
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildGoalsTab(Map<String, dynamic> analytics) {
    List<Map<String, dynamic>> dynamicGoals = _generateDynamicGoals(analytics);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: dynamicGoals
            .map((goal) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildGoalCard(
                    goal['title'],
                    goal['target'],
                    goal['current'],
                    goal['goal'],
                    goal['icon'],
                    goal['color'],
                    isReversed: goal['isReversed'] ?? false,
                  ),
                ))
            .toList(),
      ),
    );
  }

  List<Map<String, dynamic>> _generateDynamicGoals(Map<String, dynamic> analytics) {
    List<Map<String, dynamic>> goals = [];
    double averageScore = analytics['averageScore'] ?? 0.0;
    int currentStreak = analytics['streakInfo']['current'] ?? 0;
    int avgResponseTime = (analytics['timeAnalysis']['average'] ?? 0).toInt();
    Map<String, Map<String, int>> subjectPerf =
        Map<String, Map<String, int>>.from(analytics['subjectPerformance']);

    // Accuracy goal
    double targetAccuracy = averageScore < 60 ? 70.0 : (averageScore < 80 ? 85.0 : 90.0);
    goals.add({
      'title': 'Accuracy Target',
      'target': '$targetAccuracy%',
      'current': averageScore,
      'goal': targetAccuracy,
      'icon': Icons.check_circle,
      'color': Colors.green,
    });

    // Speed goal
    double targetSpeed = avgResponseTime > 60 ? 45.0 : (avgResponseTime > 30 ? 30.0 : 20.0);
    goals.add({
      'title': 'Speed Target',
      'target': '${targetSpeed.toInt()}s avg',
      'current': avgResponseTime.toDouble(),
      'goal': targetSpeed,
      'icon': Icons.speed,
      'color': Colors.blue,
      'isReversed': true,
    });

    // Consistency goal
    double targetStreak = currentStreak < 3 ? 3.0 : (currentStreak < 7 ? 7.0 : 14.0);
    goals.add({
      'title': 'Consistency Goal',
      'target': '${targetStreak.toInt()} day streak',
      'current': currentStreak.toDouble(),
      'goal': targetStreak,
      'icon': Icons.local_fire_department,
      'color': Colors.orange,
    });

    // Weakest subject goal
    String weakestSubject = '';
    double lowestAccuracy = 100.0;
    for (var entry in subjectPerf.entries) {
      double accuracy = entry.value['total']! > 0
          ? (entry.value['correct']! / entry.value['total']!) * 100
          : 0.0;
      if (accuracy < lowestAccuracy) {
        lowestAccuracy = accuracy;
        weakestSubject = entry.key;
      }
    }
    if (weakestSubject.isNotEmpty && lowestAccuracy < 70) {
      double targetSubjectAccuracy = lowestAccuracy < 50 ? 60.0 : 70.0;
      goals.add({
        'title': '$weakestSubject Accuracy',
        'target': '$targetSubjectAccuracy%',
        'current': lowestAccuracy,
        'goal': targetSubjectAccuracy,
        'icon': Icons.school,
        'color': Colors.red,
      });
    }

    return goals;
  }

  Widget _buildGoalCard(String title, String target, double current,
      double goal, IconData icon, Color color,
      {bool isReversed = false}) {
    double progress = isReversed
        ? (current <= goal ? 1.0 : goal / current)
        : math.min(current / goal, 1.0);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Target: $target',
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Text(
                  isReversed
                      ? '${current.toInt()}s'
                      : current.toStringAsFixed(1),
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
            const SizedBox(height: 8),
            Text('${(progress * 100).toInt()}% Complete',
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _generateInsights(Map<String, dynamic> analytics) {
    return _generateRecommendations(analytics);
  }

  List<Map<String, dynamic>> _generateRecommendations(
      Map<String, dynamic> analytics) {
    List<Map<String, dynamic>> recommendations = [];
    List<Map<String, dynamic>> recentSessions =
        List<Map<String, dynamic>>.from(analytics['weeklyProgress']).reversed.take(3).toList();
    bool isAccuracyDeclining = recentSessions.length >= 2 &&
        recentSessions.first['score'] < recentSessions.last['score'];

    double averageScore = analytics['averageScore'] ?? 0.0;
    int currentStreak = analytics['streakInfo']['current'] ?? 0;
    Map<String, Map<String, int>> subjectPerf =
        Map<String, Map<String, int>>.from(analytics['subjectPerformance']);
    Map<String, dynamic> timeAnalysis =
        Map<String, dynamic>.from(analytics['timeAnalysis']);
    Map<String, dynamic> difficultyAnalysis = analytics['difficultyAnalysis'] ?? {};
    int avgResponseTime = timeAnalysis['average'] ?? 0;
    String weakestArea = difficultyAnalysis['weakestArea'] ?? '';
    double weakestAccuracy = difficultyAnalysis['weakestAccuracy'] ?? 100.0;

    if (averageScore < 60 || isAccuracyDeclining) {
      recommendations.add({
        'title': 'Boost Your Accuracy',
        'description':
            'Your overall accuracy is ${averageScore.toStringAsFixed(1)}%${isAccuracyDeclining ? ' and declining' : ''}. Focus on improving your correctness.',
        'icon': Icons.error,
        'color': Colors.red,
        'tips': [
          'Read questions thoroughly before answering.',
          'Review explanations for incorrect answers to understand mistakes.',
          'Practice similar question types to reinforce weak areas.',
          'Take short quizzes on core concepts to build confidence.',
        ],
      });
    } else if (averageScore < 80) {
      recommendations.add({
        'title': 'Aim for Higher Accuracy',
        'description':
            'Your accuracy of ${averageScore.toStringAsFixed(1)}% is solid. Let’s push for 80%+!',
        'icon': Icons.trending_up,
        'color': Colors.orange,
        'tips': [
          'Double-check answers to avoid careless errors.',
          'Focus on one subject at a time to improve consistency.',
          'Use practice sets to target specific question types.',
          'Track common mistakes to identify patterns.',
        ],
      });
    } else {
      recommendations.add({
        'title': 'Maintain Excellent Accuracy',
        'description':
            'Great job! Your ${averageScore.toStringAsFixed(1)}% accuracy shows mastery. Keep it up!',
        'icon': Icons.star,
        'color': Colors.green,
        'tips': [
          'Challenge yourself with advanced questions.',
          'Share your strategies with peers to reinforce learning.',
          'Focus on maintaining speed without sacrificing accuracy.',
          'Review high-level concepts to stay sharp.',
        ],
      });
    }

    if (avgResponseTime > 60) {
      recommendations.add({
        'title': 'Increase Response Efficiency',
        'description':
            'Your average response time is ${_formatDuration(avgResponseTime)}. Let’s work on speed.',
        'icon': Icons.speed,
        'color': Colors.blue,
        'tips': [
          'Practice quick mental calculations for math questions.',
          'Eliminate obviously wrong answers to save time.',
          'Use timed practice sessions to build speed.',
          'Familiarize yourself with question formats.',
        ],
      });
    } else if (avgResponseTime < 20 && averageScore < 80) {
      recommendations.add({
        'title': 'Balance Speed and Accuracy',
        'description':
            'You’re answering quickly (${_formatDuration(avgResponseTime)}), but accuracy could improve.',
        'icon': Icons.balance,
        'color': Colors.purple,
        'tips': [
          'Slow down slightly to ensure correct answers.',
          'Read each question carefully to avoid misinterpretation.',
          'Practice with timed quizzes to find an optimal pace.',
          'Verify answers before submitting.',
        ],
      });
    } else if (avgResponseTime >= 20 && avgResponseTime <= 60) {
      recommendations.add({
        'title': 'Optimize Your Pace',
        'description':
            'Your response time (${_formatDuration(avgResponseTime)}) is balanced. Keep refining!',
        'icon': Icons.timer,
        'color': Colors.teal,
        'tips': [
          'Maintain your current pace but focus on tricky questions.',
          'Practice under timed conditions to stay sharp.',
          'Identify question types that take longer and target them.',
          'Use shortcuts for familiar question patterns.',
        ],
      });
    }

    if (weakestArea.isNotEmpty && weakestAccuracy < 70) {
      Map<String, List<String>> subjectTips = {
        'Math': [
          'Practice daily arithmetic and algebra problems.',
          'Break down word problems into smaller steps.',
          'Use visual aids like graphs or diagrams for clarity.',
          'Review fundamental math concepts regularly.',
        ],
        'English': [
          'Read diverse texts to enhance comprehension.',
          'Practice grammar and punctuation exercises.',
          'Build vocabulary through daily word exercises.',
          'Summarize passages to improve understanding.',
        ],
        'Competency': [
          'Solve logic puzzles to sharpen reasoning skills.',
          'Practice pattern recognition with sample questions.',
          'Work on critical thinking exercises daily.',
          'Analyze complex problems step-by-step.',
        ],
      };

      recommendations.add({
        'title': 'Strengthen $weakestArea',
        'description':
            'Your $weakestArea accuracy is ${weakestAccuracy.toStringAsFixed(1)}%. Targeted practice will help.',
        'icon': Icons.school,
        'color': Colors.redAccent,
        'tips': subjectTips[weakestArea] ?? [
          'Focus on core concepts in this area.',
          'Practice daily with targeted exercises.',
          'Seek additional resources or tutorials.',
          'Track progress to stay motivated.',
        ],
      });
    } else if (subjectPerf.isNotEmpty) {
      String strongestSubject = '';
      double highestAccuracy = 0.0;
      for (var entry in subjectPerf.entries) {
        double accuracy = entry.value['total']! > 0
            ? (entry.value['correct']! / entry.value['total']!) * 100
            : 0.0;
        if (accuracy > highestAccuracy) {
          highestAccuracy = accuracy;
          strongestSubject = entry.key;
        }
      }
      if (strongestSubject.isNotEmpty) {
        recommendations.add({
          'title': 'Leverage $strongestSubject Strengths',
          'description':
              'Great work in $strongestSubject (${highestAccuracy.toStringAsFixed(1)}%)! Build on this.',
          'icon': Icons.celebration,
          'color': Colors.green,
          'tips': [
            'Use your $strongestSubject skills to teach peers.',
            'Tackle advanced $strongestSubject questions.',
            'Apply $strongestSubject strategies to weaker areas.',
            'Maintain regular practice to stay strong.',
          ],
        });
      }
    }

    if (currentStreak == 0) {
      recommendations.add({
        'title': 'Start a Practice Streak',
        'description': 'No current streak. Consistent practice boosts learning!',
        'icon': Icons.local_fire_department,
        'color': Colors.orange,
        'tips': [
          'Complete a session daily to build a streak.',
          'Set a reminder for daily practice.',
          'Start with easier questions to gain momentum.',
          'Celebrate small wins to stay motivated.',
        ],
      });
    } else if (currentStreak < 5) {
      recommendations.add({
        'title': 'Grow Your Streak',
        'description': 'You have a $currentStreak-day streak. Aim for 5+ days!',
        'icon': Icons.local_fire_department,
        'color': Colors.amber,
        'tips': [
          'Practice daily, even for 10 minutes.',
          'Focus on consistency over quantity.',
          'Track your streak to stay motivated.',
          'Pair practice with a daily routine.',
        ],
      });
    } else {
      recommendations.add({
        'title': 'Keep Your Streak Alive',
        'description': 'Amazing $currentStreak-day streak! Don’t break it!',
        'icon': Icons.celebration,
        'color': Colors.green,
        'tips': [
          'Schedule daily practice at a fixed time.',
          'Challenge yourself with new question types.',
          'Share your streak for accountability.',
          'Reward yourself for maintaining consistency.',
        ],
      });
    }

    Map<String, Map<String, int>> levelStats = difficultyAnalysis['levelStats'] ?? {};
    if (levelStats.isNotEmpty) {
      String hardestLevel = '';
      double lowestLevelAccuracy = 100.0;
      for (var entry in levelStats.entries) {
        double accuracy = entry.value['total']! > 0
            ? (entry.value['correct']! / entry.value['total']!) * 100
            : 0.0;
        if (accuracy < lowestLevelAccuracy) {
          lowestLevelAccuracy = accuracy;
          hardestLevel = entry.key;
        }
      }
      if (hardestLevel.isNotEmpty && lowestLevelAccuracy < 70) {
        recommendations.add({
          'title': 'Tackle $hardestLevel Challenges',
          'description':
              'Your accuracy in $hardestLevel is ${lowestLevelAccuracy.toStringAsFixed(1)}%. Focus here.',
          'icon': Icons.warning,
          'color': Colors.deepOrange,
          'tips': [
            'Practice $hardestLevel questions daily.',
            'Review explanations for $hardestLevel mistakes.',
            'Start with simpler $hardestLevel problems.',
            'Seek examples or tutorials for $hardestLevel.',
          ],
        });
      }
    }

    List<String> generalTips = [
      'Review mistakes immediately after sessions.',
      'Create a distraction-free study environment.',
      'Take short breaks to maintain focus.',
      'Track progress weekly to stay motivated.',
    ];
    if (averageScore < 70) {
      generalTips.add('Prioritize understanding over memorization.');
    } else if (avgResponseTime > 60) {
      generalTips.add('Practice timed sessions to improve efficiency.');
    } else if (weakestArea.isNotEmpty) {
      generalTips.add('Allocate extra time to $weakestArea practice.');
    }

    recommendations.add({
      'title': 'Optimize Your Study Strategy',
      'description': 'Enhance your learning with these tailored strategies.',
      'icon': Icons.psychology,
      'color': Colors.indigo,
      'tips': generalTips,
    });
    String hardestLevel = '';
    String strongestSubject = '';
    if (difficultyAnalysis['levelStats'] != null) {
      Map<String, Map<String, int>> levelStats = difficultyAnalysis['levelStats'];
      double lowestLevelAccuracy = 100.0;
      for (var entry in levelStats.entries) {
        double accuracy = entry.value['total']! > 0
            ? (entry.value['correct']! / entry.value['total']!) * 100
            : 0.0;
        if (accuracy < lowestLevelAccuracy) {
          lowestLevelAccuracy = accuracy;
          hardestLevel = entry.key;
        }
      }
    }
    if (subjectPerf.isNotEmpty) {
      double highestAccuracy = 0.0;
      for (var entry in subjectPerf.entries) {
        double accuracy = entry.value['total']! > 0
            ? (entry.value['correct']! / entry.value['total']!) * 100
            : 0.0;
        if (accuracy > highestAccuracy) {
          highestAccuracy = accuracy;
          strongestSubject = entry.key;
        }
      }
    }

    recommendations.sort((a, b) {
      List<String> priorityOrder = [
        'Boost Your Accuracy',
        'Tackle ${hardestLevel.isNotEmpty ? hardestLevel : 'Level'} Challenges',
        'Strengthen $weakestArea',
        'Increase Response Efficiency',
        'Balance Speed and Accuracy',
        'Start a Practice Streak',
        'Grow Your Streak',
        'Aim for Higher Accuracy',
        'Optimize Your Pace',
        'Keep Your Streak Alive',
        'Leverage $strongestSubject Strengths',
        'Maintain Excellent Accuracy',
        'Optimize Your Study Strategy',
      ];
      int aIndex = priorityOrder.indexOf(a['title']);
      int bIndex = priorityOrder.indexOf(b['title']);
      return aIndex.compareTo(bIndex);
    });

    return recommendations.take(4).toList();
  }

  @override
  Widget build(BuildContext context) {
    final sessions = ref.watch(questionProvider).pastSessions;
    final analytics = _calculateAnalytics(sessions);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Professional Analytics'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
        actions: sessions.isNotEmpty
            ? [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Export Analytics'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.picture_as_pdf),
                              title: const Text('Export as PDF'),
                              onTap: () {
                                Navigator.pop(context);
                                _generateAnalyticsPdf(sessions);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.table_chart),
                              title: const Text('Export as CSV'),
                              onTap: () {
                                Navigator.pop(context);
                                _generateAnalyticsCsv(sessions);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  tooltip: 'Export Analytics',
                ),
              ]
            : null,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Overview', icon: Icon(Icons.dashboard, size: 20)),
            Tab(text: 'Progress', icon: Icon(Icons.trending_up, size: 20)),
            Tab(text: 'Tips', icon: Icon(Icons.lightbulb, size: 20)),
            Tab(text: 'Goals', icon: Icon(Icons.flag, size: 20)),
          ],
        ),
      ),
      body: sessions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'No Data Available',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Complete some assessment sessions to view analytics',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(analytics),
                _buildProgressTab(context, analytics),
                _buildRecommendationsTab(context, analytics),
                _buildGoalsTab(analytics),
              ],
            ),
    );
  }
}

enum ChartMetric { accuracy, duration, questionCount }
enum ChartTimeframe { last7Days, last30Days, allTime }

class _LineChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> sessions;
  final ChartMetric metric;

  _LineChartPainter(this.sessions, {required this.metric});

  @override
  void paint(Canvas canvas, Size size) {
    if (sessions.isEmpty) return;

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final pointPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;

    double maxY = metric == ChartMetric.accuracy
        ? 100
        : (metric == ChartMetric.duration
            ? _calculateMaxDuration(sessions)
            : sessions.map((s) => (s['totalQuestions'] ?? 3).toDouble()).reduce((a, b) => a > b ? a : b));
    for (int i = 0; i <= 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    if (sessions.length == 1) {
      final value = metric == ChartMetric.accuracy
          ? sessions[0]['score']
          : (metric == ChartMetric.duration ? sessions[0]['duration'] : sessions[0]['totalQuestions'] ?? 3);
      final point = Offset(size.width / 2, size.height * (1 - value / maxY));
      canvas.drawCircle(point, 6, pointPaint);
      return;
    }

    final path = Path();
    final points = <Offset>[];

    for (int i = 0; i < sessions.length; i++) {
      final x = size.width * i / (sessions.length - 1);
      final value = metric == ChartMetric.accuracy
          ? sessions[i]['score']
          : (metric == ChartMetric.duration ? sessions[i]['duration'] : sessions[i]['totalQuestions'] ?? 3);
      final y = size.height * (1 - value / maxY);
      points.add(Offset(x, y));
      if (i == 0) path.moveTo(x, y);
      else path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
    for (final point in points) canvas.drawCircle(point, 4, pointPaint);
  }

  double _calculateMaxDuration(List<Map<String, dynamic>> sessions) {
    return sessions.map((s) => s['duration'].toDouble()).reduce((a, b) => a > b ? a : b);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
