class Session {
  final String name;
  final List<Map<String, String>> results;

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

enum QuestionLevel { level6a, level5a, level4a }

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
        'level': level.toString().split('.').last, // Stores enum as string: 'level6a', 'level5a', 'level4a'
      };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        text: json['text'],
        options: List<String>.from(json['options']),
        correctAnswer: json['correctAnswer'],
        explanation: json['explanation'],
        level: json['level'] == 'level4a'
            ? QuestionLevel.level4a
            : json['level'] == 'level5a'
                ? QuestionLevel.level5a
                : QuestionLevel.level6a,
      );

  String getOptionText(String letter) {
    return options.firstWhere((option) => option.startsWith(letter));
  }
}

class SessionResult {
  final List<Question> questions;
  final List<String?> selectedAnswers;
  final DateTime date;

  SessionResult({
    required this.questions,
    required this.selectedAnswers,
    required this.date,
  });

  int get correctCount {
    return questions.asMap().entries.fold(0, (sum, entry) {
      int index = entry.key;
      Question question = entry.value;
      String? selected = selectedAnswers[index];
      return sum + (selected == question.correctAnswer ? 1 : 0);
    });
  }

  Map<String, dynamic> toJson() => {
        'questions': questions.map((q) => q.toJson()).toList(),
        'selectedAnswers': selectedAnswers,
        'date': date.toIso8601String(),
      };

  factory SessionResult.fromJson(Map<String, dynamic> json) => SessionResult(
        questions: List<Question>.from(
            json['questions'].map((q) => Question.fromJson(q))),
        selectedAnswers: List<String?>.from(json['selectedAnswers']),
        date: DateTime.parse(json['date']),
      );
}