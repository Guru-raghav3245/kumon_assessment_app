import 'package:kumon_assessment_app/state_management.dart';

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

  Map<String, dynamic> toJson() => {
        'text': text,
        'options': options,
        'correctAnswer': correctAnswer,
        'explanation': explanation,
        'level': level == QuestionLevel.level6a ? 'level6a' : 'level5a',
      };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        text: json['text'],
        options: List<String>.from(json['options']),
        correctAnswer: json['correctAnswer'],
        explanation: json['explanation'],
        level: json['level'] == 'level5a' ? QuestionLevel.level5a : QuestionLevel.level6a,
      );

  String getOptionText(String letter) {
    return options.firstWhere((option) => option.startsWith(letter));
  }
}

class Session {
  final String name;
  final List<Map<String, String>> results; // {question, userAnswer, correctAnswer, level}

  Session({required this.name, required this.results});

  Map<String, dynamic> toJson() => {
        'name': name,
        'results': results,
      };

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        name: json['name'],
        results: List<Map<String, String>>.from(
            json['results'].map((x) => Map<String, String>.from(x))),
      );
}