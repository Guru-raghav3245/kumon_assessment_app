import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/question_logic/models.dart';

class ProfessionalAnalytics {
  final Map<String, double> subjectMastery;
  final Map<String, double> responseTimeBySubject;
  final Map<String, double> errorPatterns;
  final List<CompetencyGap> competencyGaps;
  final BenchmarkMetrics benchmarkMetrics;
  final bool hasSufficientData;

  ProfessionalAnalytics({
    required this.subjectMastery,
    required this.responseTimeBySubject,
    required this.errorPatterns,
    required this.competencyGaps,
    required this.benchmarkMetrics,
    required this.hasSufficientData,
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
  final double? peerAverage;
  final double? institutionalAverage;
  final int? percentileRank;
  final bool benchmarksAvailable;

  BenchmarkMetrics({
    required this.personalAverage,
    this.peerAverage,
    this.institutionalAverage,
    this.percentileRank,
    required this.benchmarksAvailable,
  });
}

final professionalAnalyticsProvider = Provider<ProfessionalAnalytics>((ref) {
  final questionState = ref.watch(questionProvider);
  return _calculateProfessionalAnalytics(questionState.pastSessions);
});

ProfessionalAnalytics _calculateProfessionalAnalytics(List<Session> sessions) {
  final hasSufficientData = sessions.isNotEmpty;
  
  // Calculate subject mastery from actual session data
  final subjectMastery = _calculateSubjectMastery(sessions);
  
  // Calculate response times from actual session data
  final responseTimeBySubject = _calculateResponseTimes(sessions);
  
  // Calculate error patterns
  final errorPatterns = _calculateErrorPatterns(sessions);
  
  // Identify competency gaps
  final competencyGaps = _identifyCompetencyGaps(sessions);
  
  // Benchmark metrics (only personal data available)
  final personalAverage = subjectMastery.values.isNotEmpty 
      ? subjectMastery.values.reduce((a, b) => a + b) / subjectMastery.length 
      : 0.0;
  
  final benchmarkMetrics = BenchmarkMetrics(
    personalAverage: personalAverage,
    benchmarksAvailable: false, // No peer/institutional data available
  );
  
  return ProfessionalAnalytics(
    subjectMastery: subjectMastery,
    responseTimeBySubject: responseTimeBySubject,
    errorPatterns: errorPatterns,
    competencyGaps: competencyGaps,
    benchmarkMetrics: benchmarkMetrics,
    hasSufficientData: hasSufficientData,
  );
}

Map<String, double> _calculateSubjectMastery(List<Session> sessions) {
  final subjectPerformance = <String, List<int>>{};
  
  for (var session in sessions) {
    for (var result in session.results) {
      final level = result['level'] ?? '';
      final subject = _getSubjectFromLevel(level);
      
      subjectPerformance.putIfAbsent(subject, () => [0, 0]);
      subjectPerformance[subject]![1]++; // Total questions
      
      if (result['userAnswer'] == result['correctAnswer']) {
        subjectPerformance[subject]![0]++; // Correct answers
      }
    }
  }
  
  final mastery = <String, double>{};
  for (var entry in subjectPerformance.entries) {
    final correct = entry.value[0];
    final total = entry.value[1];
    mastery[entry.key] = total > 0 ? (correct / total * 100) : 0.0;
  }
  
  // Ensure all subjects are represented
  if (!mastery.containsKey('Math')) mastery['Math'] = 0.0;
  if (!mastery.containsKey('English')) mastery['English'] = 0.0;
  if (!mastery.containsKey('Competency')) mastery['Competency'] = 0.0;
  
  return mastery;
}

Map<String, double> _calculateResponseTimes(List<Session> sessions) {
  final subjectResponseTimes = <String, List<int>>{};
  final subjectQuestionCounts = <String, int>{};
  
  // This is a simplified implementation - in a real app, you'd track per-question timing
  for (var session in sessions) {
    if (session.duration > 0 && session.results.isNotEmpty) {
      final avgTimePerQuestion = session.duration / session.results.length;
      
      for (var result in session.results) {
        final level = result['level'] ?? '';
        final subject = _getSubjectFromLevel(level);
        
        subjectResponseTimes.putIfAbsent(subject, () => []);
        subjectResponseTimes[subject]!.add(avgTimePerQuestion.round());
        
        subjectQuestionCounts[subject] = (subjectQuestionCounts[subject] ?? 0) + 1;
      }
    }
  }
  
  final responseTimes = <String, double>{};
  for (var entry in subjectResponseTimes.entries) {
    final times = entry.value;
    final total = times.fold(0, (sum, time) => sum + time);
    responseTimes[entry.key] = total / times.length;
  }
  
  // Ensure all subjects are represented
  if (!responseTimes.containsKey('Math')) responseTimes['Math'] = 0.0;
  if (!responseTimes.containsKey('English')) responseTimes['English'] = 0.0;
  if (!responseTimes.containsKey('Competency')) responseTimes['Competency'] = 0.0;
  
  return responseTimes;
}

Map<String, double> _calculateErrorPatterns(List<Session> sessions) {
  final errorCounts = <String, int>{};
  int totalErrors = 0;
  
  for (var session in sessions) {
    for (var result in session.results) {
      if (result['userAnswer'] != result['correctAnswer']) {
        final level = result['level'] ?? '';
        final subject = _getSubjectFromLevel(level);
        final concept = _getConceptFromLevel(level);
        
        final errorKey = '${subject}_$concept';
        errorCounts[errorKey] = (errorCounts[errorKey] ?? 0) + 1;
        totalErrors++;
      }
    }
  }
  
  final errorPatterns = <String, double>{};
  for (var entry in errorCounts.entries) {
    errorPatterns[entry.key] = totalErrors > 0 ? (entry.value / totalErrors * 100) : 0.0;
  }
  
  return errorPatterns;
}

String _getSubjectFromLevel(String level) {
  if (level.contains('Eng')) return 'English';
  if (level.contains('Comp')) return 'Competency';
  return 'Math'; // Default to Math for trigonometry and other math topics
}

// Add this utility function
String _getConceptFromLevel(String level) {
  // Extract concept from level string
  if (level.contains('Trig')) return 'Trigonometry';
  if (level.contains('Algebra')) return 'Algebra';
  if (level.contains('Grammar')) return 'Grammar';
  if (level.contains('Reading')) return 'Reading Comprehension';
  if (level.contains('Teaching')) return 'Teaching Methodology';
  return 'General';
}
List<CompetencyGap> _identifyCompetencyGaps(List<Session> sessions) {
  final gaps = <CompetencyGap>[];
  final subjectPerformance = <String, Map<String, List<int>>>{};
  
  for (var session in sessions) {
    for (var result in session.results) {
      final level = result['level'] ?? '';
      final subject = _getSubjectFromLevel(level);
      
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