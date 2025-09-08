import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:kumon_assessment_app/professional_analytics_provider.dart';

class DataExportScreen extends ConsumerWidget {
  const DataExportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.watch(professionalAnalyticsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Professional Data'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Export Options',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // PDF Export Card
            _buildExportOptionCard(
              icon: Icons.picture_as_pdf,
              title: 'Professional PDF Report',
              description: 'Comprehensive report with analytics, charts, and recommendations',
              onTap: () => _exportPdfReport(analytics, context),
            ),
            
            const SizedBox(height: 16),
            
            // CSV Export Card
            _buildExportOptionCard(
              icon: Icons.table_chart,
              title: 'CSV Data Export',
              description: 'Raw data for further analysis in spreadsheet applications',
              onTap: () => _exportCsvData(analytics, context),
            ),
            
            const SizedBox(height: 16),
            
            // Summary Card
            _buildExportOptionCard(
              icon: Icons.description,
              title: 'Executive Summary',
              description: 'Brief overview for sharing with supervisors or peers',
              onTap: () => _exportSummary(analytics, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExportOptionCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _exportPdfReport(ProfessionalAnalytics analytics, BuildContext context) async {
    try {
      final pdf = pw.Document();
      
      // Add cover page
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Header(
                  level: 0,
                  child: pw.Text('Professional Assessment Report',
                    style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                ),
                pw.SizedBox(height: 20),
                pw.Text('Generated on: ${DateTime.now().toString().split(' ')[0]}'),
                pw.SizedBox(height: 30),
                pw.Text('Subject Mastery Summary:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                ...analytics.subjectMastery.entries.map((entry) {
                  return pw.Text('${entry.key}: ${entry.value.toStringAsFixed(1)}%');
                }).toList(),
              ],
            );
          },
        ),
      );
      
      // Add competency gaps page
      if (analytics.competencyGaps.isNotEmpty) {
        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return [
                pw.Header(
                  level: 1,
                  child: pw.Text('Competency Gap Analysis',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
                pw.SizedBox(height: 20),
                ...analytics.competencyGaps.map((gap) {
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('${gap.area} - ${gap.level}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Accuracy: ${gap.accuracy.toStringAsFixed(1)}%'),
                      pw.Text('Recommendation: ${gap.recommendation}'),
                      pw.SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              ];
            },
          ),
        );
      }
      
      // Save and share PDF
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/professional_assessment_report.pdf');
      await file.writeAsBytes(await pdf.save());
      
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'My Professional Assessment Report',
        subject: 'Kumon Instructor Assessment Results',
      );
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    }
  }

  Future<void> _exportCsvData(ProfessionalAnalytics analytics, BuildContext context) async {
    try {
      // Create CSV content
      final csvContent = StringBuffer();
      csvContent.writeln('Subject,Mastery%,ResponseTime,Errors');
      
      for (var entry in analytics.subjectMastery.entries) {
        final responseTime = analytics.responseTimeBySubject[entry.key] ?? 0;
        final errors = analytics.errorPatterns.entries
            .where((e) => e.key.startsWith(entry.key))
            .fold(0.0, (sum, e) => sum + e.value);
            
        csvContent.writeln('${entry.key},${entry.value},$responseTime,${errors.toStringAsFixed(1)}');
      }
      
      // Save and share CSV
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/assessment_data.csv');
      await file.writeAsString(csvContent.toString());
      
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Assessment Data CSV',
        subject: 'Kumon Instructor Assessment Data',
      );
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating CSV: $e')),
      );
    }
  }

  Future<void> _exportSummary(ProfessionalAnalytics analytics, BuildContext context) async {
    try {
      final summary = '''
PROFESSIONAL ASSESSMENT SUMMARY
Generated: ${DateTime.now().toString().split(' ')[0]}

OVERALL PERFORMANCE:
- Average Mastery: ${analytics.benchmarkMetrics.personalAverage.toStringAsFixed(1)}%
- Peer Comparison: Top ${analytics.benchmarkMetrics.percentileRank}%
- Institutional Benchmark: ${analytics.benchmarkMetrics.institutionalAverage.toStringAsFixed(1)}%

SUBJECT MASTERY:
${analytics.subjectMastery.entries.map((e) => '- ${e.key}: ${e.value.toStringAsFixed(1)}%').join('\n')}

AREAS FOR DEVELOPMENT:
${analytics.competencyGaps.isEmpty ? '- No significant gaps identified' : analytics.competencyGaps.map((g) => '- ${g.area} (${g.level}): ${g.accuracy.toStringAsFixed(1)}% accuracy').join('\n')}

RECOMMENDATIONS:
${analytics.competencyGaps.isEmpty ? '- Continue current practice routine' : '- Focus on identified competency gaps\n- Implement recommended strategies'}
''';
      
      // Save and share text file
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/assessment_summary.txt');
      await file.writeAsString(summary);
      
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Assessment Summary',
        subject: 'Kumon Instructor Assessment Summary',
      );
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating summary: $e')),
      );
    }
  }
}