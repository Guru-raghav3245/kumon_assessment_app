import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/question_logic/models.dart';
import 'package:kumon_assessment_app/screens/session_review_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';

class SessionHistoryScreen extends ConsumerWidget {
  const SessionHistoryScreen({super.key});

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }

  // Function to generate PDF document with detailed questions
  Future<pw.Document> _generatePdf(List<Session> sessions) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text('Kumon Assessment Session History',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Summary Statistics',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            _buildSummaryStatistics(sessions),
            pw.SizedBox(height: 20),
            pw.Text('Session Details with Questions',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            ..._buildSessionDetailsWithQuestions(sessions),
          ];
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildSummaryStatistics(List<Session> sessions) {
    int totalQuestions = 0;
    int correctAnswers = 0;
    int totalDuration = 0;

    for (var session in sessions) {
      totalQuestions += session.results.length;
      correctAnswers += session.results
          .where((r) => r['userAnswer'] == r['correctAnswer'])
          .length;
      totalDuration += session.duration;
    }

    final overallAccuracy =
        totalQuestions > 0 ? (correctAnswers / totalQuestions * 100) : 0.0;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Total Sessions: ${sessions.length}'),
        pw.Text('Total Questions: $totalQuestions'),
        pw.Text('Correct Answers: $correctAnswers'),
        pw.Text('Overall Accuracy: ${overallAccuracy.toStringAsFixed(1)}%'),
        pw.Text('Total Time: ${_formatDuration(totalDuration)}'),
      ],
    );
  }

  List<pw.Widget> _buildSessionDetailsWithQuestions(List<Session> sessions) {
    List<pw.Widget> widgets = [];

    for (var session in sessions) {
      final correctCount = session.results
          .where((r) => r['userAnswer'] == r['correctAnswer'])
          .length;
      final total = session.results.length;
      final accuracy = total > 0 ? (correctCount / total * 100) : 0.0;

      widgets.addAll([
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 10, top: 15),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('${session.name}',
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Text('Duration: ${_formatDuration(session.duration)}'),
              pw.Text('Accuracy: ${accuracy.toStringAsFixed(1)}%'),
              pw.Text('Score: $correctCount/$total'),
            ],
          ),
        ),
        ..._buildSessionQuestions(session),
        pw.Divider(thickness: 2),
        pw.SizedBox(height: 10),
      ]);
    }
    return widgets;
  }

  List<pw.Widget> _buildSessionQuestions(Session session) {
    List<pw.Widget> questionWidgets = [];

    for (var i = 0; i < session.results.length; i++) {
      final result = session.results[i];
      final questionNumber = i + 1;
      final isCorrect = result['userAnswer'] == result['correctAnswer'];
      final formattedLevel = formatLevelName(result['level'] ?? 'Unknown');

      questionWidgets.addAll([
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 8, left: 10),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                children: [
                  pw.Text('Q$questionNumber: ',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  isCorrect
                      ? pw.Text('Correct',
                          style: pw.TextStyle(
                              color: PdfColors.green,
                              fontWeight: pw.FontWeight.bold))
                      : pw.Text('Incorrect',
                          style: pw.TextStyle(
                              color: PdfColors.red,
                              fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.Text('Question: ${result['question'] ?? 'Unknown'}',
                  style: pw.TextStyle(fontSize: 12)),
              pw.Text('Level: $formattedLevel',
                  style: pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
              pw.Text('Your Answer: ${result['userAnswer'] ?? 'Not answered'}',
                  style: pw.TextStyle(
                    fontSize: 11,
                    color: isCorrect ? PdfColors.green : PdfColors.red,
                  )),
              if (!isCorrect)
                pw.Text(
                    'Correct Answer: ${result['correctAnswer'] ?? 'Unknown'}',
                    style: pw.TextStyle(fontSize: 11, color: PdfColors.green)),
              pw.SizedBox(height: 4),
              pw.Divider(thickness: 0.5, color: PdfColors.grey300),
            ],
          ),
        ),
      ]);
    }
    return questionWidgets;
  }

  Future<void> _sharePdf(List<Session> sessions) async {
    try {
      final pdf = await _generatePdf(sessions);
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/session_history.pdf');
      await file.writeAsBytes(await pdf.save());

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'My Kumon Assessment Session History',
        subject: 'Kumon Assessment Results',
      );
    } catch (e) {
      print('Error sharing PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionState = ref.watch(questionProvider);

    final sessions = List<Session>.from(questionState.pastSessions)
      ..sort((a, b) {
        final aNum = int.parse(a.name.replaceAll('s', '').split(' ')[0]);
        final bNum = int.parse(b.name.replaceAll('s', '').split(' ')[0]);
        return bNum.compareTo(aNum);
      });

    final graphSessions = sessions.reversed.toList();

    List<FlSpot> getAccuracySpots() {
      final maxSessions = 10;
      final recentSessions = graphSessions.length > maxSessions
          ? graphSessions.sublist(0, maxSessions)
          : graphSessions;
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

    List<FlSpot> getDurationSpots() {
      final maxSessions = 10;
      final recentSessions = graphSessions.length > maxSessions
          ? graphSessions.sublist(0, maxSessions)
          : graphSessions;
      return recentSessions.asMap().entries.map((entry) {
        final index = entry.key.toDouble();
        final session = entry.value;
        return FlSpot(index, session.duration.toDouble());
      }).toList();
    }

    void deleteSession(Session session) {
      ref.read(questionProvider.notifier).deleteSession(session);
    }

    void deleteAllSessions() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Clear All Sessions'),
          content: const Text(
              'Are you sure you want to delete all sessions? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(questionProvider.notifier).deleteAllSessions();
                Navigator.pop(context);
              },
              child:
                  const Text('Delete All', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session History'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
        actions: sessions.isNotEmpty
            ? [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () => _sharePdf(sessions),
                  tooltip: 'Share Session History',
                ),
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: deleteAllSessions,
                  tooltip: 'Clear All Sessions',
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Trends',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),

            // Accuracy Graph
            Text(
              'Accuracy Trend',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
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
                                        if (value % 20 != 0)
                                          return const SizedBox();
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text('${value.toInt()}%',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 12)),
                                        );
                                      },
                                    ),
                                  ),
                                  rightTitles: const AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      interval: 1,
                                      getTitlesWidget: (value, meta) {
                                        final index = value.toInt();
                                        if (index >= graphSessions.length)
                                          return const SizedBox();
                                        final sessionNumber =
                                            graphSessions[index]
                                                .name
                                                .split(' ')[0]
                                                .substring(1);
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text('S$sessionNumber',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 12)),
                                        );
                                      },
                                    ),
                                  ),
                                  topTitles: const AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1),
                                ),
                                minX: 0,
                                maxX: (graphSessions.length > 10
                                        ? 9
                                        : graphSessions.length - 1)
                                    .toDouble(),
                                minY: 0,
                                maxY: 100,
                                extraLinesData: ExtraLinesData(
                                  horizontalLines: [
                                    HorizontalLine(
                                        y: 100,
                                        color: Colors.grey.withOpacity(0.2),
                                        strokeWidth: 1)
                                  ],
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: getAccuracySpots(),
                                    isCurved: false,
                                    color: Colors.blue,
                                    barWidth: 4,
                                    dotData: FlDotData(
                                        show: true,
                                        getDotPainter:
                                            (spot, percent, barData, index) =>
                                                FlDotSquarePainter(
                                                    size: 8,
                                                    color: Colors.blue,
                                                    strokeWidth: 2,
                                                    strokeColor: Colors.white)),
                                    belowBarData: BarAreaData(
                                        show: true,
                                        color: Colors.blue.withOpacity(0.1)),
                                  ),
                                ],
                                lineTouchData: LineTouchData(
                                  enabled: true,
                                  handleBuiltInTouches: true,
                                  touchTooltipData: LineTouchTooltipData(
                                    fitInsideHorizontally: true,
                                    fitInsideVertically: true,
                                    maxContentWidth: 140,
                                    tooltipPadding: const EdgeInsets.all(8),
                                    tooltipMargin: 8,
                                    getTooltipItems: (touchedSpots) =>
                                        touchedSpots.map((spot) {
                                      final sessionNumber =
                                          graphSessions[spot.x.toInt()]
                                              .name
                                              .split(' ')[0]
                                              .substring(1);
                                      return LineTooltipItem(
                                        'Session $sessionNumber\n${spot.y.toStringAsFixed(1)}%',
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

            // Time Graph
            Text(
              'Time Trend',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
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
                                      interval: 60,
                                      getTitlesWidget: (value, meta) {
                                        if (value % 60 != 0)
                                          return const SizedBox();
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text('${value.toInt()}s',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 12)),
                                        );
                                      },
                                    ),
                                  ),
                                  rightTitles: const AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      interval: 1,
                                      getTitlesWidget: (value, meta) {
                                        final index = value.toInt();
                                        if (index >= graphSessions.length)
                                          return const SizedBox();
                                        final sessionNumber =
                                            graphSessions[index]
                                                .name
                                                .split(' ')[0]
                                                .substring(1);
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text('S$sessionNumber',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 12)),
                                        );
                                      },
                                    ),
                                  ),
                                  topTitles: const AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1),
                                ),
                                minX: 0,
                                maxX: (graphSessions.length > 10
                                        ? 9
                                        : graphSessions.length - 1)
                                    .toDouble(),
                                minY: 0,
                                maxY: _calculateMaxYForTime(graphSessions),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: getDurationSpots(),
                                    isCurved: false,
                                    color: Colors.orange,
                                    barWidth: 4,
                                    dotData: FlDotData(
                                        show: true,
                                        getDotPainter:
                                            (spot, percent, barData, index) =>
                                                FlDotCirclePainter(
                                                    radius: 4,
                                                    color: Colors.orange,
                                                    strokeWidth: 2,
                                                    strokeColor: Colors.white)),
                                    belowBarData: BarAreaData(
                                        show: true,
                                        color: Colors.orange.withOpacity(0.1)),
                                  ),
                                ],
                                lineTouchData: LineTouchData(
                                  enabled: true,
                                  handleBuiltInTouches: true,
                                  touchTooltipData: LineTouchTooltipData(
                                    fitInsideHorizontally: true,
                                    fitInsideVertically: true,
                                    maxContentWidth: 140,
                                    tooltipPadding: const EdgeInsets.all(8),
                                    tooltipMargin: 8,
                                    getTooltipItems: (touchedSpots) =>
                                        touchedSpots.map((spot) {
                                      final sessionNumber =
                                          graphSessions[spot.x.toInt()]
                                              .name
                                              .split(' ')[0]
                                              .substring(1);
                                      return LineTooltipItem(
                                        'Session $sessionNumber\n${spot.y.toInt()}s',
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

            Container(
              constraints: BoxConstraints(
                minHeight: 200,
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: sessions.length,
                itemBuilder: (context, index) {
                  final session = sessions[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      leading: const Icon(Icons.book, color: Colors.blue),
                      title: Text(session.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      subtitle: Text(
                          'Time: ${_formatDuration(session.duration)}',
                          style: Theme.of(context).textTheme.bodySmall),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete Session'),
                                  content: Text(
                                      'Are you sure you want to delete ${session.name}?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel')),
                                    TextButton(
                                      onPressed: () {
                                        deleteSession(session);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete',
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                            tooltip: 'Delete Session',
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SessionReviewScreen(
                            session: session,
                            isNewSession: false,
                          ),
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

  double _calculateMaxYForTime(List<Session> sessions) {
    if (sessions.isEmpty) return 100;
    final maxDuration = sessions
        .map((session) => session.duration)
        .reduce((a, b) => a > b ? a : b);
    return (maxDuration / 60).ceil() * 60.0;
  }
}
