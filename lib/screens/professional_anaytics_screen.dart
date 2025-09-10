import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/question_logic/models.dart';
import 'dart:math' as math;

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
          subjectStats[subject]!['correct'] = subjectStats[subject]!['correct']! + 1;
        }
      }

      totalDuration += session.duration;
      sessionData.add({
        'name': session.name,
        'score': sessionTotal > 0 ? (sessionCorrect / sessionTotal * 100) : 0,
        'duration': session.duration,
        'date': _extractDateFromSessionName(session.name),
      });
    }

    // Calculate streaks
    Map<String, int> streakInfo = _calculateStreaks(sessionData);

    // Calculate time analysis
    Map<String, dynamic> timeAnalysis = _analyzeResponseTimes(sessions);

    return {
      'totalSessions': sessions.length,
      'averageScore': totalQuestions > 0 ? (correctAnswers / totalQuestions * 100) : 0.0,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'averageDuration': sessions.isNotEmpty ? (totalDuration / sessions.length) : 0,
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
    if (level.toLowerCase().contains('math') || level.toLowerCase().contains('level')) return 'Math'; // Updated to include 'Math' for levels
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
    } catch (e) {
      print('Error parsing date from session name: $e');
    }
    return DateTime.now();
  }

  Map<String, int> _calculateStreaks(List<Map<String, dynamic>> sessionData) {
    if (sessionData.isEmpty) return {'current': 0, 'best': 0};

    sessionData.sort((a, b) => a['date'].compareTo(b['date']));
    
    int currentStreak = 0;
    int bestStreak = 0;
    int tempStreak = 0;

    for (var session in sessionData) {
      if (session['score'] >= 66.67) { // At least 2/3 correct
        tempStreak++;
        bestStreak = math.max(bestStreak, tempStreak);
      } else {
        tempStreak = 0;
      }
    }

    // Calculate current streak from the end
    for (int i = sessionData.length - 1; i >= 0; i--) {
      if (sessionData[i]['score'] >= 66.67) {
        currentStreak++;
      } else {
        break;
      }
    }

    return {'current': currentStreak, 'best': bestStreak};
  }

  Map<String, dynamic> _analyzeResponseTimes(List<Session> sessions) {
    List<int> allTimes = [];
    Map<String, List<int>> subjectTimes = {};

    for (var session in sessions) {
      for (var result in session.results) {
        // Handle different possible types for duration
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
        
        // Safe type conversion for answer comparison
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

    // Sort levels in the order: Math, English, Competency
    List<String> orderedLevels = levelStats.keys.toList();
    orderedLevels.sort((a, b) {
      List<String> priorityOrder = ['Math', 'English', 'Competency'];
      int aIndex = priorityOrder.indexWhere((s) => a.toLowerCase().contains(s.toLowerCase()));
      int bIndex = priorityOrder.indexWhere((s) => b.toLowerCase().contains(s.toLowerCase()));
      return aIndex.compareTo(bIndex);
    });

    return {
      'levelStats': levelStats,
      'weakestArea': weakestArea,
      'weakestAccuracy': lowestAccuracy,
      'orderedLevels': orderedLevels,
    };
  }

  Widget _buildOverviewTab(Map<String, dynamic> analytics) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Key Metrics Cards
          _buildMetricsGrid(analytics),
          const SizedBox(height: 24),
          
          // Performance Chart
          _buildPerformanceChart(analytics),
          const SizedBox(height: 24),
          
          // Subject Performance
          _buildSubjectPerformance(analytics),
          const SizedBox(height: 24),
          
          // Quick Insights
          _buildQuickInsights(analytics),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(Map<String, dynamic> analytics) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.0,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.all(8),
      children: [
        _buildMetricCard(
          'Sessions',
          analytics['totalSessions'].toString(),
          Icons.quiz,
          Colors.blue,
        ),
        _buildMetricCard(
          'Avg Score',
          '${analytics['averageScore'].toStringAsFixed(1)}%',
          Icons.trending_up,
          Colors.green,
        ),
        _buildMetricCard(
          'Questions',
          analytics['totalQuestions'].toString(),
          Icons.help_outline,
          Colors.orange,
        ),
        _buildMetricCard(
          'Duration',
          '${(analytics['averageDuration'] / 60).toStringAsFixed(1)}m',
          Icons.timer,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
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
    );
  }

  Widget _buildPerformanceChart(Map<String, dynamic> analytics) {
    List<Map<String, dynamic>> sessions = 
        List<Map<String, dynamic>>.from(analytics['weeklyProgress']);
    
    if (sessions.isEmpty) {
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
            Container(
              height: 200,
              child: CustomPaint(
                painter: _LineChartPainter(sessions),
                size: const Size(double.infinity, 200),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectPerformance(Map<String, dynamic> analytics) {
    Map<String, Map<String, int>> subjectPerformance = 
        Map<String, Map<String, int>>.from(analytics['subjectPerformance']);

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
                        Text(subject, style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text('${percentage.toStringAsFixed(1)}% ($correct/$total)',
                             style: TextStyle(color: color, fontWeight: FontWeight.bold)),
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
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInsights(Map<String, dynamic> analytics) {
    List<String> insights = _generateInsights(analytics);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.black87, // Changed to dark background for readability
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
            ...insights.map((insight) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb, color: Colors.yellow, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      insight,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsTab(Map<String, dynamic> analytics) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildGoalCard(
            'Accuracy Target',
            '85%',
            analytics['averageScore'],
            85.0,
            Icons.check_circle,
            Colors.green,
          ),
          const SizedBox(height: 16),
          _buildGoalCard(
            'Speed Target',
            '45s avg',
            (analytics['timeAnalysis']['average'] ?? 60).toDouble(),
            45.0,
            Icons.speed,
            Colors.blue,
            isReversed: true,
          ),
          const SizedBox(height: 16),
          _buildGoalCard(
            'Consistency Goal',
            '7 day streak',
            analytics['streakInfo']['current'].toDouble(),
            7.0,
            Icons.local_fire_department,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(String title, String target, double current, double goal, 
                       IconData icon, Color color, {bool isReversed = false}) {
    double progress = isReversed ? 
        (current <= goal ? 1.0 : goal / current) :
        math.min(current / goal, 1.0);
    
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
                      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Target: $target', style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Text(
                  isReversed ? '${current.toInt()}s' : current.toStringAsFixed(1),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
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

  List<String> _generateInsights(Map<String, dynamic> analytics) {
    List<String> insights = [];
    
    if (analytics['averageScore'] >= 80) {
      insights.add('Excellent performance! You\'re consistently scoring above 80%.');
    } else if (analytics['averageScore'] >= 60) {
      insights.add('Good progress! Aim to reach 80% accuracy for optimal learning.');
    } else {
      insights.add('Focus on accuracy improvement. Review explanations carefully.');
    }

    if (analytics['streakInfo']['current'] >= 3) {
      insights.add('Great streak! Consistency is key to mastering concepts.');
    }

    Map<String, Map<String, int>> subjectPerf = 
        Map<String, Map<String, int>>.from(analytics['subjectPerformance']);
    
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
      insights.add('Your strongest subject is $strongestSubject with ${highestAccuracy.toStringAsFixed(1)}% accuracy.');
    }

    return insights;
  }

  // Remove this function from the class body

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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

class _LineChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> sessions;

  _LineChartPainter(this.sessions);

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

    // Draw grid lines
    for (int i = 0; i <= 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    if (sessions.length == 1) {
      // Single point
      final point = Offset(size.width / 2, size.height * (1 - sessions[0]['score'] / 100));
      canvas.drawCircle(point, 6, pointPaint);
      return;
    }

    final path = Path();
    final points = <Offset>[];

    for (int i = 0; i < sessions.length; i++) {
      final x = size.width * i / (sessions.length - 1);
      final y = size.height * (1 - sessions[i]['score'] / 100);
      final point = Offset(x, y);
      points.add(point);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    // Draw points
    for (final point in points) {
      canvas.drawCircle(point, 4, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

Widget _buildProgressTab(BuildContext context, Map<String, dynamic> analytics) {
  Map<String, dynamic> difficultyAnalysis = analytics['difficultyAnalysis'];
  List<String> orderedLevels = difficultyAnalysis['orderedLevels'] ?? [];
  Map<String, Map<String, int>> levelStats = difficultyAnalysis['levelStats'];

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
        ...orderedLevels.map((level) {
          Map<String, int> stats = levelStats[level] ?? {'correct': 0, 'total': 0};
          double percentage = stats['total']! > 0 ? (stats['correct']! / stats['total']!) * 100 : 0;
          Color color = percentage >= 70 ? Colors.green : percentage >= 40 ? Colors.orange : Colors.red;

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
                      style: TextStyle(color: color, fontWeight: FontWeight.bold),
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
        }).toList(),
      ],
    ),
  );


}

Widget _buildRecommendationsTab(BuildContext context, Map<String, dynamic> analytics) {
  List<Map<String, dynamic>> recommendations = _generateRecommendations(analytics);
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.grey[850], // Dark background for better readability
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
                ...rec['tips'].map<Widget>((tip) => Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.arrow_right, color: Colors.white70, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          tip,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        )).toList(),
      ],
    ),
  );
}

// Move _generateRecommendations to global scope
List<Map<String, dynamic>> _generateRecommendations(Map<String, dynamic> analytics) {
  List<Map<String, dynamic>> recommendations = [];
  
  // Accuracy-based recommendations
  if (analytics['averageScore'] < 70) {
    recommendations.add({
      'title': 'Focus on Accuracy',
      'description': 'Your current accuracy is ${analytics['averageScore'].toStringAsFixed(1)}%. Let\'s work on improving this.',
      'icon': Icons.error,
      'color': Colors.red,
      'tips': [
        'Take more time to read questions carefully',
        'Review explanations after each incorrect answer',
        'Practice similar question types in your weak areas',
        'Consider reviewing fundamental concepts before sessions'
      ],
    });
  } else if (analytics['averageScore'] >= 70 && analytics['averageScore'] < 85) {
    recommendations.add({
      'title': 'Push for Excellence',
      'description': 'Good accuracy! Let\'s aim for 85%+ to demonstrate mastery.',
      'icon': Icons.trending_up,
      'color': Colors.orange,
      'tips': [
        'Focus on eliminating careless errors',
        'Double-check your answers before submitting',
        'Identify patterns in your mistakes',
        'Practice speed without sacrificing accuracy'
      ],
    });
  }

  // Time-based recommendations
  Map<String, dynamic> timeAnalysis = Map<String, dynamic>.from(analytics['timeAnalysis']);
  int avgTime = timeAnalysis['average'] ?? 0;
  
  if (avgTime > 60) {
    recommendations.add({
      'title': 'Improve Response Speed',
      'description': 'Your average response time is ${avgTime}s. Let\'s work on efficiency.',
      'icon': Icons.speed,
      'color': Colors.blue,
      'tips': [
        'Practice mental math for quicker calculations',
        'Learn to eliminate obviously wrong answers quickly',
        'Build confidence through regular practice',
        'Set time limits during practice sessions'
      ],
    });
  } else if (avgTime < 30) {
    recommendations.add({
      'title': 'Balance Speed and Accuracy',
      'description': 'You\'re very fast (${avgTime}s avg). Ensure you\'re not rushing.',
      'icon': Icons.balance,
      'color': Colors.purple,
      'tips': [
        'Take time to fully understand each question',
        'Verify your answers before submitting',
        'Quality over speed - accuracy is more important',
        'Practice mindful problem-solving'
      ],
    });
  }

  // Subject-specific recommendations
  Map<String, Map<String, int>> subjectPerf = 
      Map<String, Map<String, int>>.from(analytics['subjectPerformance']);
  
  String weakestSubject = '';
  double lowestAccuracy = 100.0;
  
  for (var entry in subjectPerf.entries) {
    if (entry.value['total']! > 0) {
      double accuracy = (entry.value['correct']! / entry.value['total']!) * 100;
      if (accuracy < lowestAccuracy) {
        lowestAccuracy = accuracy;
        weakestSubject = entry.key;
      }
    }
  }

  if (weakestSubject.isNotEmpty && lowestAccuracy < 70) {
    Map<String, List<String>> subjectTips = {
      'Math': [
        'Practice arithmetic operations daily',
        'Review basic algebra and geometry concepts',
        'Use visual aids for complex problems',
        'Break down word problems step by step'
      ],
      'English': [
        'Read more diverse texts to improve comprehension',
        'Practice grammar rules regularly',
        'Expand your vocabulary through daily reading',
        'Focus on understanding context clues'
      ],
      'Competency': [
        'Develop logical reasoning skills',
        'Practice pattern recognition exercises',
        'Improve critical thinking through puzzles',
        'Focus on analytical problem-solving methods'
      ],
    };

    recommendations.add({
      'title': 'Strengthen $weakestSubject Skills',
      'description': 'Your $weakestSubject accuracy is ${lowestAccuracy.toStringAsFixed(1)}%. This area needs attention.',
      'icon': Icons.school,
      'color': Colors.red,
      'tips': subjectTips[weakestSubject] ?? ['Focus on fundamentals', 'Practice regularly', 'Seek additional resources'],
    });
  }

  // Streak and consistency recommendations
  int currentStreak = analytics['streakInfo']['current'];
  if (currentStreak == 0) {
    recommendations.add({
      'title': 'Build Consistency',
      'description': 'Start building a performance streak for better learning outcomes.',
      'icon': Icons.local_fire_department,
      'color': Colors.orange,
      'tips': [
        'Aim for at least 2 out of 3 questions correct per session',
        'Practice regularly to maintain momentum',
        'Set realistic daily goals',
        'Celebrate small victories to stay motivated'
      ],
    });
  } else if (currentStreak >= 5) {
    recommendations.add({
      'title': 'Maintain Momentum',
      'description': 'Excellent ${currentStreak}-session streak! Keep it up.',
      'icon': Icons.celebration,
      'color': Colors.green,
      'tips': [
        'Continue your regular practice schedule',
        'Challenge yourself with harder concepts',
        'Share your progress with others for accountability',
        'Reflect on what\'s working well for you'
      ],
    });
  }

  // General study recommendations
  recommendations.add({
    'title': 'Study Strategy Optimization',
    'description': 'Enhance your learning approach for better results.',
    'icon': Icons.psychology,
    'color': Colors.indigo,
    'tips': [
      'Review mistakes immediately after each session',
      'Create a quiet, distraction-free study environment',
      'Take breaks between study sessions to avoid fatigue',
      'Track your progress regularly to stay motivated',
      'Focus on understanding concepts, not just memorizing'
    ],
  });

  return recommendations;
}
