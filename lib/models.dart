import 'package:kumon_assessment_app/question_bank.dart';

enum QuestionLevel {
  level6a,
  level5a,
  level4a,
  level3a,
  level2a,
  levelA,
  levelB,
  levelC,
  levelD,
  levelE,
  levelF,
  levelG,
  EngLevel7a,
  EngLevel6a,
  EngLevel5a,
  EngLevel4a,
  EngLevel3a,
  EngLevel2a,
  EngLevelA1,
  EngLevelA2,
  EngLevelB1,
  EngLevelB2,
  EngLevelC1,
  EngLevelC2,
  EngLevelD1,
  EngLevelD2,
  EngLevelE1,
  Comp1,
  Comp2,
  Comp3,  
  Comp4,
  Comp5,
  Comp6,
  Comp7,
}

final levels = [
  {
    'level': QuestionLevel.Comp1,
    'questions': comp1Questions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.Comp2,
    'questions': comp2Questions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.Comp3,
    'questions': comp3Questions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.Comp4,
    'questions': comp4Questions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.Comp5,
    'questions': comp5Questions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.Comp6,
    'questions': comp6Questions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.Comp7,
    'questions': comp7Questions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.level6a,
    'questions': mathlevel6aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.level5a,
    'questions': mathlevel5aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.level4a,
    'questions': mathlevel4aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.level3a,
    'questions': mathlevel3aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.level2a,
    'questions': mathlevel2aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.levelA,
    'questions': mathlevelAQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.levelB,
    'questions': mathlevelBQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.levelC,
    'questions': mathlevelCQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.levelD,
    'questions': mathlevelDQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.levelE,
    'questions': mathlevelEQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.levelF,
    'questions': mathlevelFQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.EngLevel7a,
    'questions': englevel7aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.EngLevel6a,
    'questions': englevel6aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.EngLevel5a,
    'questions': englevel5aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.EngLevel4a,
    'questions': englevel4aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.EngLevel3a,
    'questions': englevel3aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.EngLevel2a,
    'questions': englevel2aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.EngLevelA1,
    'questions': englevelA1Questions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.EngLevelA2,
    'questions': englevelA2Questions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.EngLevelB1,
    'questions': englevelB1Questions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.EngLevelB2,
    'questions': englevelB2Questions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.EngLevelC1,
    'questions': englevelC1Questions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.EngLevelC2,
    'questions': englevelC2Questions,
    'questionsPerSession': 1,
  },
];
class Question {
  final String text;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final QuestionLevel level;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.level,
  });

  String getOptionText(String optionLetter) {
    final option = options.firstWhere(
      (opt) => opt.startsWith('$optionLetter.'),
      orElse: () => optionLetter,
    );
    return option.startsWith('$optionLetter.')
        ? option.substring(3).trim()
        : option;
  }
}

class Session {
  final String name;
  final List<Map<String, String>> results;
  final int duration;

  Session({required this.name, required this.results, required this.duration});

  Map<String, dynamic> toJson() => {
        'name': name,
        'results': results,
        'duration': duration,
      };

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        name: json['name'] as String,
        results: (json['results'] as List<dynamic>)
            .map((r) => Map<String, String>.from(r as Map))
            .toList(),
        duration: json['duration'] as int? ?? 0,
      );
}