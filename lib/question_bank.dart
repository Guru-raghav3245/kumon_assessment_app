import 'package:kumon_assessment_app/models.dart';

final List<Question> questionBank = [
  Question(
    text:
        "A student rushes through their worksheet, making many mistakes. What should you do?",
    options: [
      "A. Encourage them to focus on accuracy first, even if it takes longer to complete the worksheet.",
      "B. Encourage them to focus on accuracy but let them know that speed will improve as their accuracy increases.",
      "C. Assign more challenging worksheets to challenge their thinking, but only if they have mastered the current level.",
      "D. Allow them to continue at their own pace, but emphasize that speed without accuracy won’t lead to mastery.",
    ],
    correctAnswer: "B",
    explanation:
        "B is correct because Kumon emphasizes the importance of mastery before progression.",
  ),
  Question(
    text:
        "A student struggles with a new concept but refuses to ask for help. How should you guide them?",
    options: [
      "A. Encourage them to reattempt the problem by reviewing examples and using previous knowledge.",
      "B. Provide the correct answer and explain it so they can move forward more easily.",
      "C. Allow them to skip the worksheet for now and return to it later when they feel ready.",
      "D. Immediately assign additional worksheets to reinforce the concept through repetition.",
    ],
    correctAnswer: "A",
    explanation: "A is correct because Kumon promotes self-learning.",
  ),
  Question(
    text:
        "A student repeatedly asks for help before even attempting problems. How do you respond?",
    options: [
      "A. Reduce the number of questions so they don’t feel overwhelmed.",
      "B. Offer answers when asked to keep them motivated and prevent frustration.",
      "C. Provide guidance by encouraging them to try solving the problem independently before seeking help.",
      "D. Allow them to continue asking for help freely, as it ensures they don’t make mistakes.",
    ],
    correctAnswer: "C",
    explanation:
        "C is correct because Kumon emphasizes independence in learning.",
  ),
  Question(
    text:
        "A student takes too long to complete a worksheet. What should you do?",
    options: [
      "A. Allow them to take as long as needed to ensure they understand the material fully.",
      "B. Encourage them to work at a steady pace and remind them that with practice, speed will improve.",
      "C. Reduce the number of questions to help them feel more successful and finish quickly.",
      "D. Tell them to finish quickly, even if they make mistakes, to improve their speed.",
    ],
    correctAnswer: "B",
    explanation: "B is correct because Kumon focuses on mastery before speed.",
  ),
  Question(
    text:
        "A parent says, 'My child is getting frustrated because the worksheets are too hard.' How should you respond?",
    options: [
      "A. Tell the parent you will review where the child is facing difficulty and get back to them on how to guide the child.",
      "B. Review the student’s progress and suggest reducing the difficulty level of the worksheets to prevent frustration.",
      "C. Explain that Kumon encourages working through challenges and that this frustration is a sign of growth.",
      "D. Both A & C.",
    ],
    correctAnswer: "D",
    explanation:
        "D is correct because both A and C align with Kumon’s philosophy.",
  ),
];