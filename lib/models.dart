enum QuestionLevel { level6a, level5a, level4a, level3a, level2a, levelA}

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
    return option.startsWith('$optionLetter.') ? option.substring(3).trim() : option;
  }
}

class Session {
  final String name;
  final List<Map<String, String>> results;
  final int duration; // Duration in seconds

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
        duration: json['duration'] as int? ?? 0, // Default to 0 if null
      );
}