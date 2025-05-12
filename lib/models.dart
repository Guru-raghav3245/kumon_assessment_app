class Question {
  final String text;
  final List<String> options;
  final String correctAnswer;
  final String explanation;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'options': options,
        'correctAnswer': correctAnswer,
        'explanation': explanation,
      };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        text: json['text'],
        options: List<String>.from(json['options']),
        correctAnswer: json['correctAnswer'],
        explanation: json['explanation'],
      );

  String getOptionText(String letter) {
    return options.firstWhere((option) => option.startsWith(letter));
  }
}

// Session Model
class Session {
  final String name;
  final List<Map<String, String>>
      results; // {question, userAnswer, correctAnswer}

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
