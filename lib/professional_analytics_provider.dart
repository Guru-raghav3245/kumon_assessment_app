import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/question_logic/models.dart';

class ProfessionalAnalytics {
  final Map<String, double> subjectMastery;
  final Map<String, int> responseTimeBySubject;
  final Map<String, double> errorPatterns;
  final List<CompetencyGap> competencyGaps;
  final BenchmarkMetrics benchmarkMetrics;

  ProfessionalAnalytics({
    required this.subjectMastery,
    required this.responseTimeBySubject,
    required this.errorPatterns,
    required this.competencyGaps,
    required this.benchmarkMetrics,
  });
}

class CompetencyGap {
  final String area;
  final String level;
  final double accuracy;
  final int frequency;
  final String recommendation;

  CompetencyGap({
    required this.area,
    required this.level,
    required this.accuracy,
    required this.frequency,
    required this.recommendation,
  });
}

class BenchmarkMetrics {
  final double personalAverage;
  final double peerAverage;
  final double institutionalAverage;
  final int percentileRank;

  BenchmarkMetrics({
    required this.personalAverage,
    required this.peerAverage,
    required this.institutionalAverage,
    required this.percentileRank,
  });
}

final professionalAnalyticsProvider = Provider<ProfessionalAnalytics>((ref) {
  final questionState = ref.watch(questionProvider);
  return _calculateProfessionalAnalytics(questionState.pastSessions);
});

ProfessionalAnalytics _calculateProfessionalAnalytics(List<Session> sessions) {
  // Calculate subject mastery
  final subjectMastery = <String, double>{};
  final subjectPerformance = <String, List<int>>{};
  
  // Calculate response times (simulated - you'd need to track this)
  final responseTimeBySubject = <String, int>{
    'Math': 45,
    'English': 38,
    'Competency': 52,
  };
  
  // Calculate error patterns
  final errorPatterns = <String, double>{};
  final errorCounts = <String, int>{};
  
  for (var session in sessions) {
    for (var result in session.results) {
      final level = result['level'] ?? '';
      final subject = level.contains('Eng') ? 'English' : 
                     level.contains('Comp') ? 'Competency' : 'Math';
      
      // Track subject performance
      subjectPerformance.putIfAbsent(subject, () => [0, 0]);
      subjectPerformance[subject]![1]++; // Total questions
      
      if (result['userAnswer'] == result['correctAnswer']) {
        subjectPerformance[subject]![0]++; // Correct answers
      }
      
      // Track error patterns for incorrect answers
      if (result['userAnswer'] != result['correctAnswer']) {
        final errorKey = '${subject}_${result['correctAnswer']}';
        errorCounts[errorKey] = (errorCounts[errorKey] ?? 0) + 1;
      }
    }
  }
  
  // Calculate mastery percentages
  for (var entry in subjectPerformance.entries) {
    final correct = entry.value[0];
    final total = entry.value[1];
    subjectMastery[entry.key] = total > 0 ? (correct / total * 100) : 0.0;
  }
  
  // Calculate error patterns (simplified)
  final totalErrors = errorCounts.values.fold(0, (sum, count) => sum + count);
  for (var entry in errorCounts.entries) {
    errorPatterns[entry.key] = (entry.value / totalErrors) * 100;
  }
  
  // Identify competency gaps
  final competencyGaps = _identifyCompetencyGaps(sessions);
  
  // Benchmark metrics (simulated data)
  final benchmarkMetrics = BenchmarkMetrics(
    personalAverage: subjectMastery.values.reduce((a, b) => a + b) / subjectMastery.length,
    peerAverage: 78.3, // Simulated peer average
    institutionalAverage: 82.1, // Simulated institutional average
    percentileRank: 85, // Simulated percentile
  );
  
  return ProfessionalAnalytics(
    subjectMastery: subjectMastery,
    responseTimeBySubject: responseTimeBySubject,
    errorPatterns: errorPatterns,
    competencyGaps: competencyGaps,
    benchmarkMetrics: benchmarkMetrics,
  );
}

List<CompetencyGap> _identifyCompetencyGaps(List<Session> sessions) {
  // This would be more sophisticated in a real implementation
  final gaps = <CompetencyGap>[];
  
  final subjectPerformance = <String, Map<String, List<int>>>{};
  
  for (var session in sessions) {
    for (var result in session.results) {
      final level = result['level'] ?? '';
      final subject = level.contains('Eng') ? 'English' : 
                     level.contains('Comp') ? 'Competency' : 'Math';
      
      subjectPerformance.putIfAbsent(subject, () => {});
      subjectPerformance[subject]!.putIfAbsent(level, () => [0, 0]);
      subjectPerformance[subject]![level]![1]++; // Total questions
      
      if (result['userAnswer'] == result['correctAnswer']) {
        subjectPerformance[subject]![level]![0]++; // Correct answers
      }
    }
  }
  
  // Identify areas with accuracy below 70%
  for (var subjectEntry in subjectPerformance.entries) {
    for (var levelEntry in subjectEntry.value.entries) {
      final correct = levelEntry.value[0];
      final total = levelEntry.value[1];
      final accuracy = total > 0 ? (correct / total * 100) : 0.0;
      
      if (accuracy < 70 && total >= 3) { // Minimum 3 questions for significance
        gaps.add(CompetencyGap(
          area: subjectEntry.key,
          level: levelEntry.key,
          accuracy: accuracy,
          frequency: total,
          recommendation: _getRecommendation(subjectEntry.key, levelEntry.key),
        ));
      }
    }
  }
  
  return gaps;
}

String _getRecommendation(String subject, String level) {
  final recommendations = {
    'Math': 'Review foundational concepts and practice applied problems',
    'English': 'Focus on reading comprehension and grammar rules',
    'Competency': 'Practice scenario-based questions and teaching methodologies',
  };
  
  return recommendations[subject] ?? 'Targeted practice recommended';
}