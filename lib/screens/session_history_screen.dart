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

  // Function to generate PDF document
  Future<pw.Document> _generatePdf(List<Session> sessions) async {
    final pdf = pw.Document();
    
    // Add a page to the PDF
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            // Header
            pw.Header(
              level: 0,
              child: pw.Text('Kumon Assessment Session History',
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            ),
            pw.SizedBox(height: 20),
            
            // Summary statistics
            pw.Text('Summary Statistics',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            
            // Calculate overall statistics
            _buildSummaryStatistics(sessions),
            pw.SizedBox(height: 20),
            
            // Session details
            pw.Text('Session Details',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            
            // Session list
            ..._buildSessionDetails(sessions),
          ];
        },
      ),
    );
    
    return pdf;
  }

  // Build summary statistics for PDF
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
    
    final overallAccuracy = totalQuestions > 0 
        ? (correctAnswers / totalQuestions * 100) 
        : 0.0;
    
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

  // Build session details for PDF
  List<pw.Widget> _buildSessionDetails(List<Session> sessions) {
    List<pw.Widget> widgets = [];
    
    for (var session in sessions) {
      final correctCount = session.results
          .where((r) => r['userAnswer'] == r['correctAnswer'])
          .length;
      final total = session.results.length;
      final accuracy = total > 0 ? (correctCount / total * 100) : 0.0;
      
      widgets.addAll([
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 10),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('${session.name} - ${_formatDuration(session.duration)}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text('Accuracy: ${accuracy.toStringAsFixed(1)}%'),
              pw.Text('Correct: $correctCount/$total'),
            ],
          ),
        ),
        pw.Divider(),
      ]);
    }
    
    return widgets;
  }

  // Function to share PDF
  Future<void> _sharePdf(List<Session> sessions) async {
    try {
      // Generate PDF
      final pdf = await _generatePdf(sessions);
      
      // Get temporary directory
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/session_history.pdf');
      
      // Save PDF to file
      await file.writeAsBytes(await pdf.save());
      
      // Share the file
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
      ..sort((a, b) => b.name.compareTo(a.name));

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
                                        if (value % 20 != 0) {
                                          return const SizedBox();
                                        }
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
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
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 48,
                                      interval: 60,
                                      getTitlesWidget: (value, meta) {
                                        if (value % 60 != 0) {
                                          return const SizedBox();
                                        }
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            '${value.toInt()}s',
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
                                        if (index >= graphSessions.length) {
                                          return const SizedBox();
                                        }
                                        final sessionNumber =
                                            graphSessions[index]
                                                .name
                                                .split(' ')[0]
                                                .substring(1);
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'S$sessionNumber',
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
                                      strokeWidth: 1,
                                    ),
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
                                        strokeColor: Colors.white,
                                      ),
                                    ),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: Colors.blue.withOpacity(0.1),
                                    ),
                                  ),
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
                                        strokeColor: Colors.white,
                                      ),
                                    ),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: Colors.orange.withOpacity(0.1),
                                    ),
                                  ),
                                ],
                                lineTouchData: LineTouchData(
                                  enabled: true,
                                  touchTooltipData: LineTouchTooltipData(
                                    getTooltipItems: (touchedSpots) =>
                                        touchedSpots.map((spot) {
                                      final isAccuracy = spot.barIndex == 0;
                                      // Extract session number for tooltip
                                      final sessionNumber =
                                          graphSessions[spot.x.toInt()]
                                              .name
                                              .split(' ')[0]
                                              .substring(1);
                                      return LineTooltipItem(
                                        isAccuracy
                                            ? 'Session $sessionNumber\n${spot.y.toStringAsFixed(1)}%'
                                            : 'Session $sessionNumber\n${spot.y.toInt()}s',
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
                        subtitle: Text(
                          'Time: ${_formatDuration(session.duration)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
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
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteSession(session);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Delete',
                                            style:
                                                TextStyle(color: Colors.red)),
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
                        onTap:
                            () => // When tapping on a session in history, use:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SessionReviewScreen(
                                      session: session,
                                      isNewSession: false,
                                    ),
                                  ),
                                )),
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