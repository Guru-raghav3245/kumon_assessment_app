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
      body: analytics.hasSufficientData
          ? _buildAnalyticsContent(analytics)
          : _buildNoDataState(),
    );
  }

  Widget _buildAnalyticsContent(ProfessionalAnalytics analytics) {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildNoDataState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No session data available yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Complete a few sessions to see your analytics',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
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
            
            if (!metrics.benchmarksAvailable)
              const Column(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue, size: 32),
                  SizedBox(height: 8),
                  Text(
                    'Benchmarks unavailable',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Focus on your personal progress',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBenchmarkItem('Your Avg', '${metrics.personalAverage.toStringAsFixed(1)}%', Colors.blue),
                  _buildBenchmarkItem('Peer Avg', '${metrics.peerAverage!.toStringAsFixed(1)}%', Colors.green),
                  _buildBenchmarkItem('Institutional', '${metrics.institutionalAverage!.toStringAsFixed(1)}%', Colors.orange),
                ],
              ),
            
            if (metrics.benchmarksAvailable && metrics.percentileRank != null) ...[
              const SizedBox(height: 16),
              Center(
                child: Chip(
                  label: Text('Top ${metrics.percentileRank}% Percentile'),
                  backgroundColor: Colors.blue,
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ],
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

  Widget _buildResponseTimeCard(Map<String, double> responseTimes) {
    const idealTime = 45; // seconds per question
    
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
                final hasData = entry.value > 0;
                final isSlow = entry.value > idealTime;
                
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
                      if (!hasData)
                        const Text(
                          'N/A',
                          style: TextStyle(color: Colors.grey),
                        )
                      else
                        Row(
                          children: [
                            Text(
                              '${entry.value.toStringAsFixed(1)}s',
                              style: TextStyle(
                                color: isSlow ? Colors.orange : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (isSlow)
                              const Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Icon(Icons.warning, color: Colors.orange, size: 16),
                              ),
                          ],
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ideal: < $idealTime seconds per question',
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