import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/professional_analytics_provider.dart';
import 'package:kumon_assessment_app/screens/data_export_screen.dart';

class ProfessionalAnalyticsScreen extends ConsumerWidget {
  const ProfessionalAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.watch(professionalAnalyticsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Professional Analytics'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DataExportScreen()),
              );
            },
            tooltip: 'Export Data',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Benchmark Overview
            _buildBenchmarkCard(analytics.benchmarkMetrics),
            const SizedBox(height: 16),
            
            // Subject Mastery
            _buildSubjectMasteryCard(analytics.subjectMastery),
            const SizedBox(height: 16),
            
            // Response Time Analysis
            _buildResponseTimeCard(analytics.responseTimeBySubject),
            const SizedBox(height: 16),
            
            // Competency Gap Analysis
            _buildCompetencyGapCard(analytics.competencyGaps),
            const SizedBox(height: 16),
            
            // Error Patterns
            _buildErrorPatternsCard(analytics.errorPatterns),
          ],
        ),
      ),
    );
  }

  Widget _buildBenchmarkCard(BenchmarkMetrics metrics) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Performance Benchmarks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBenchmarkItem('Your Avg', '${metrics.personalAverage.toStringAsFixed(1)}%', Colors.blue),
                _buildBenchmarkItem('Peer Avg', '${metrics.peerAverage.toStringAsFixed(1)}%', Colors.green),
                _buildBenchmarkItem('Institutional', '${metrics.institutionalAverage.toStringAsFixed(1)}%', Colors.orange),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Chip(
                label: Text('Top ${metrics.percentileRank}% Percentile'),
                backgroundColor: Colors.blue,
                labelStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenchmarkItem(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  Widget _buildSubjectMasteryCard(Map<String, double> subjectMastery) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Subject Mastery',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              children: subjectMastery.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          entry.key,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: LinearProgressIndicator(
                          value: entry.value / 100,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            entry.value >= 80 ? Colors.green : 
                            entry.value >= 60 ? Colors.orange : Colors.red,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${entry.value.toStringAsFixed(1)}%',
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

  Widget _buildResponseTimeCard(Map<String, int> responseTimes) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Average Response Time by Subject',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              children: responseTimes.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.key,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '${entry.value} seconds',
                        style: TextStyle(
                          color: entry.value > 50 ? Colors.orange : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ideal: < 45 seconds per question',
              style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompetencyGapCard(List<CompetencyGap> gaps) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Competency Gap Analysis',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                if (gaps.isNotEmpty)
                  Chip(
                    label: Text('${gaps.length} areas need attention'),
                    backgroundColor: Colors.orange,
                    labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (gaps.isEmpty)
              const Center(
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 48),
                    SizedBox(height: 8),
                    Text('No significant competency gaps identified!', style: TextStyle(color: Colors.green)),
                  ],
                ),
              )
            else
              Column(
                children: gaps.map((gap) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange[100]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${gap.area} - ${gap.level.replaceAll('QuestionLevel.', '')}',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange[800]),
                        ),
                        const SizedBox(height: 4),
                        Text('Accuracy: ${gap.accuracy.toStringAsFixed(1)}% (Based on ${gap.frequency} questions)'),
                        const SizedBox(height: 4),
                        Text(
                          'Recommendation: ${gap.recommendation}',
                          style: const TextStyle(fontStyle: FontStyle.italic),
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

  Widget _buildErrorPatternsCard(Map<String, double> errorPatterns) {
    final significantErrors = errorPatterns.entries
        .where((entry) => entry.value > 5.0) // Only show patterns > 5%
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Error Pattern Analysis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            if (significantErrors.isEmpty)
              const Center(
                child: Text('No significant error patterns detected', style: TextStyle(color: Colors.grey)),
              )
            else
              Column(
                children: significantErrors.map((error) {
                  final parts = error.key.split('_');
                  final subject = parts[0];
                  final concept = parts.length > 1 ? parts[1] : 'General';
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '$subject: $concept',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '${error.value.toStringAsFixed(1)}% of errors',
                          style: const TextStyle(color: Colors.red),
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
}