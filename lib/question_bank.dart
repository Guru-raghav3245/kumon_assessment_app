import 'package:kumon_assessment_app/models.dart';

final levels = [
  {
    'level': QuestionLevel.level6a,
    'questions': level6aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.level5a,
    'questions': level5aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.level4a,
    'questions': level4aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.level3a,
    'questions': level3aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.level2a,
    'questions': level2aQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.levelA,
    'questions': levelAQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.levelB,
    'questions': levelBQuestions,
    'questionsPerSession': 1,
  },
  {
    'level': QuestionLevel.levelC,
    'questions': levelCQuestions,
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
];

final List<Question> level6aQuestions = [
  Question(
    text:
        "A student struggles to count objects up to 5, often losing track. What would you do?",
    options: [
      "A. Count aloud with the student, pointing to each object.",
      "B. Observe and let the student retry, offering hints if needed.",
      "C. Guide the student’s finger to each object while counting together.",
      "D. Ask the student to count silently and check their total later.",
    ],
    correctAnswer: "A",
    explanation:
        "A provides direct support with pointing. B delays help, C over-guides, D avoids immediate correction.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "A student mixes up numbers 6 and 9 while reading aloud. How should you respond?",
    options: [
      "A. Repeat the numbers clearly, asking them to echo you.",
      "B. Show the numbers on a board, guiding their reading.",
      "C. Correct each mistake immediately as they read.",
      "D. Let them continue and review mistakes at the end.",
    ],
    correctAnswer: "B",
    explanation:
        "B uses visual aid for clarity. A is verbal-only, C disrupts flow, D delays correction.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "A student finishes counting exercises quickly but skips numbers. What would you do?",
    options: [
      "A. Review the exercise with them, pointing to missed numbers.",
      "B. Assign a new exercise with fewer items to focus on accuracy.",
      "C. Praise their speed and ask them to recount carefully.",
      "D. Observe and let them self-correct on the next attempt.",
    ],
    correctAnswer: "A",
    explanation:
        "A targets errors directly. B reduces challenge, C reinforces speed, D avoids guidance.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "A student refuses to count aloud during a group session. What’s your best action?",
    options: [
      "A. Allow them to count silently and share the total.",
      "B. Pair them with another student to count together.",
      "C. Demonstrate counting aloud, inviting them to join.",
      "D. Move them to a one-on-one session to build confidence.",
    ],
    correctAnswer: "C",
    explanation:
        "C encourages participation gently. A avoids verbal practice, B adds pressure, D over-adjusts.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "A student counts dots up to 10 but reverses the order. How should you proceed?",
    options: [
      "A. Recount with them, pointing in the correct sequence.",
      "B. Show the correct order on a number line, then retry.",
      "C. Ask them to recount without help to self-correct.",
      "D. Provide a new dot exercise with smaller numbers.",
    ],
    correctAnswer: "A",
    explanation:
        "A correction with guidance. B relies on visuals alone, C lacks support, D lowers difficulty.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "A student struggles to recognize numbers 7-10 on a worksheet. What would you do?",
    options: [
      "A. Point to each number and say it aloud with them.",
      "B. Give them a number chart to study before retrying.",
      "C. Read the numbers slowly, asking them to repeat.",
      "D. Let them trace the numbers before reading again.",
    ],
    correctAnswer: "A",
    explanation:
        "A combines pointing and verbal reinforcement. B delays practice, C skips visuals, D avoids reading.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "A student counts objects but stops at 7 consistently. What’s your approach?",
    options: [
      "A. Count to 10 with them, emphasizing 8-10.",
      "B. Encourage them to continue past 7 with your guidance.",
      "C. Show a number line and ask them to count to 10.",
      "D. Assign a new task with objects up to 7 only.",
    ],
    correctAnswer: "B",
    explanation:
        "B builds on their limit with support. A over-directs, C relies on tools, D limits progress.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "Parent Says: 'My child keeps counting the same numbers daily. Is this necessary?'",
    options: [
      "A. Explain that repetition builds counting fluency and accuracy.",
      "B. Note that daily practice ensures strong number recognition.",
      "C. Assure them repetition strengthens counting skills over time.",
      "D. Suggest that consistent counting prepares them for harder levels.",
    ],
    correctAnswer: "A",
    explanation:
        "A ties repetition to fluency. B is vague, C lacks detail, D shifts focus to progression.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "Parent Says: 'My child finds dot counting boring.'",
    options: [
      "A. Highlight that dot counting builds focus and number sense.",
      "B. Explain that repetition with dots improves counting skills.",
      "C. Note that dot exercises develop accuracy and patience.",
      "D. Assure them dot practice strengthens early math skills.",
    ],
    correctAnswer: "A",
    explanation:
        "A addresses focus and sense. B misses engagement, C is partial, D is too broad.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "Parent Says: 'My child knows numbers up to 5. Why go to 10?'",
    options: [
      "A. Clarify that extending to 10 builds a stronger number base.",
      "B. Explain that counting to 10 ensures full early mastery.",
      "C. Note that progressing to 10 develops confidence and skills.",
      "D. Assure them reaching 10 solidifies counting foundations.",
    ],
    correctAnswer: "B",
    explanation:
        "B emphasizes mastery. A is general, C focuses on confidence, D lacks specificity.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "Parent Says: 'My child struggles with number reading.'",
    options: [
      "A. Suggest practicing reading with pointing at home.",
      "B. Recommend using worksheets to improve reading skills.",
      "C. Offer to model reading numbers during sessions.",
      "D. Advise focusing on slow reading with visual aids.",
    ],
    correctAnswer: "C",
    explanation:
        "C provides direct support. A shifts to parents, B is passive, D lacks structure.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "Parent Says: 'Why does my child count aloud so much?'",
    options: [
      "A. Explain that aloud counting builds verbal number skills.",
      "B. Note that speaking numbers enhances memory and fluency.",
      "C. Assure them counting aloud reinforces number recognition.",
      "D. Suggest that verbal counting strengthens counting habits.",
    ],
    correctAnswer: "A",
    explanation:
        "A links to verbal skills. B is secondary, C is vague, D is repetitive.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "Parent Says: 'My child skips numbers when tired.'",
    options: [
      "A. Recommend a break before resuming with guidance.",
      "B. Suggest continuing with fewer numbers to finish.",
      "C. Advise observing and correcting skips later.",
      "D. Propose reducing the session length slightly.",
    ],
    correctAnswer: "A",
    explanation:
        "A addresses fatigue effectively. B lowers expectation, C delays help, D is temporary.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "A student counts inaccurately due to poor pointing. What’s the best first step?",
    options: [
      "A. Guide their finger to each object while counting.",
      "B. Demonstrate proper pointing before they retry.",
      "C. Ask them to point and count without assistance.",
      "D. Provide a new counting exercise with guidance.",
    ],
    correctAnswer: "A",
    explanation:
        "A correct technique directly. B is preparatory, C lacks support, D delays focus.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "A student hesitates reading numbers 8-10. What’s your priority?",
    options: [
      "A. Model reading slowly, asking them to follow.",
      "B. Point to each number while saying it aloud.",
      "C. Encourage them to read with minimal help.",
      "D. Show a number chart for them to study.",
    ],
    correctAnswer: "B",
    explanation:
        "B combines support and practice. A is modeling-only, C lacks aid, D is passive.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "A student skips dots during counting. What should you do first?",
    options: [
      "A. Recount with them, pointing to each dot.",
      "B. Let them retry and check their accuracy.",
      "C. Assign a simpler dot exercise to rebuild.",
      "D. Observe and offer hints if they struggle.",
    ],
    correctAnswer: "A",
    explanation:
        "A ensures immediate correction. B delays help, C reduces challenge, D is indirect.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "A student struggles with number order up to 10. What’s your best action?",
    options: [
      "A. Count in order with them, pointing each number.",
      "B. Show a sequence chart and guide their counting.",
      "C. Ask them to recite numbers without assistance.",
      "D. Provide a new worksheet with number lines.",
    ],
    correctAnswer: "A",
    explanation:
        "A offers direct guidance. B relies on tools, C lacks support, D is preparatory.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "A student counts aloud but loses focus. What’s your priority?",
    options: [
      "A. Redirect with a short counting game and praise.",
      "B. Continue counting with them, keeping focus.",
      "C. Suggest a break before resuming the task.",
      "D. Assign a new task to regain their interest.",
    ],
    correctAnswer: "B",
    explanation:
        "B maintains engagement. A is distracting, C delays, D shifts focus.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "Case Study: A 4-year-old student counts dots up to 5 but stops, looking confused. What’s the best way to help them progress?",
    options: [
      "A. Count to 5 with them, then extend to 10 slowly.",
      "B. Show the dots and ask them to count again alone.",
      "C. Guide their counting to 10 with pointing support.",
      "D. Provide a new dot sheet with numbers written.",
    ],
    correctAnswer: "C",
    explanation:
        "C builds on their skill with guidance. A is gradual, B lacks aid, D adds complexity.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "Case Study: A student reads numbers 1-5 correctly but stumbles at 6-10. How should you support their learning?",
    options: [
      "A. Read 6-10 aloud, asking them to repeat each.",
      "B. Point to 6-10 while saying them together.",
      "C. Show a number line and guide their reading.",
      "D. Let them try again without immediate help.",
    ],
    correctAnswer: "B",
    explanation:
        "B combines visual and verbal aid. A is verbal-only, C relies on tools, D lacks support.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "Case Study: A student counts objects but reverses 7 and 9 often. What’s your first step to correct this?",
    options: [
      "A. Recount with them, clarifying 7 and 9 positions.",
      "B. Show a number chart and ask them to identify 7-9.",
      "C. Point to 7 and 9 while counting together.",
      "D. Assign a new task focusing on 7-9 recognition.",
    ],
    correctAnswer: "C",
    explanation:
        "C corrects with real-time guidance. A is verbal, B is passive, D delays focus.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "Case Study: A student hesitates during dot counting, looking at peers. What should you do to build confidence?",
    options: [
      "A. Count the dots with them, offering praise.",
      "B. Encourage them to watch peers, then try alone.",
      "C. Demonstrate counting, asking them to follow.",
      "D. Suggest they count silently to reduce pressure.",
    ],
    correctAnswer: "A",
    explanation:
        "A boosts confidence with support. B increases comparison, C shifts focus, D avoids practice.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "What is the main goal of counting exercises in Level 6A?",
    options: [
      "A. Build fluency in counting up to 10 accurately.",
      "B. Teach students to recognize numbers quickly.",
      "C. Help students memorize number sequences.",
      "D. Ensure students count without errors daily.",
    ],
    correctAnswer: "A",
    explanation:
        "A focuses on fluency. B is secondary, C is memorization, D is unrealistic.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "Why does Kumon emphasize pointing during counting?",
    options: [
      "A. It guides students to focus on each item.",
      "B. It helps students count faster and better.",
      "C. It reduces the need for verbal instructions.",
      "D. It ensures students memorize number order.",
    ],
    correctAnswer: "A",
    explanation:
        "A enhanced focus. B overstates speed, C minimizes teaching, D is incidental.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "When should a student move from counting to 5 to 10?",
    options: [
      "A. After consistent accuracy up to 5.",
      "B. When they can count to 5 without help.",
      "C. Once they master counting up to 10 fully.",
      "D. After recognizing all numbers to 10.",
    ],
    correctAnswer: "A",
    explanation:
        "A ensures readiness. B lacks progression, C is premature, D skips counting.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "What is the purpose of number reading in early levels?",
    options: [
      "A. Develop verbal recognition of numbers.",
      "B. Teach students to write numbers correctly.",
      "C. Help students count objects quickly.",
      "D. Ensure mastery of number sequences.",
    ],
    correctAnswer: "A",
    explanation:
        "A targets verbal skills. B is writing-focused, C is counting, D is broader.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "How should instructors handle a student skipping numbers?",
    options: [
      "A. Recount with them, pointing to missed items.",
      "B. Let them self-correct on the next attempt.",
      "C. Assign easier exercises to rebuild skills.",
      "D. None of the above.",
    ],
    correctAnswer: "D",
    explanation:
        "D applies; immediate correction is needed, not self-correction or easing.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "What role does repetition play in Level 6A?",
    options: [
      "A. Reinforces counting accuracy and confidence.",
      "B. Helps students finish worksheets faster.",
      "C. Ensures they memorize numbers quickly.",
      "D. Reduces the need for instructor guidance.",
    ],
    correctAnswer: "A",
    explanation:
        "A builds skills. B focuses on speed, C is memorization, D is incorrect.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "According to Level 6A, how should instructors introduce counting to 10?",
    options: [
      "A. Start with 5, then gradually add numbers with pointing.",
      "B. Begin with 10, reducing to 5 if needed.",
      "C. Teach all numbers at once with a chart.",
      "D. Count silently, showing numbers later.",
    ],
    correctAnswer: "A",
    explanation:
        "A follows the manual’s progression. B reverses order, C overwhelms, D skips verbal.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "What does the manual suggest for students struggling with dot counting?",
    options: [
      "A. Point and count together to guide them.",
      "B. Let them observe peers before retrying.",
      "C. Provide a new sheet without assistance.",
      "D. Skip to number reading exercises.",
    ],
    correctAnswer: "A",
    explanation:
        "A aligns with guidance. B delays, C lacks support, D shifts focus.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "How should instructors use the Number of Dots section?",
    options: [
      "A. Guide counting with pointing up to 10.",
      "B. Teach students to guess totals quickly.",
      "C. Focus on writing numbers after counting.",
      "D. Allow self-correction without help.",
    ],
    correctAnswer: "A",
    explanation:
        "A matches the manual. B avoids accuracy, C is premature, D lacks support.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text: "What is the aim of counting up to 5 exercises per the manual?",
    options: [
      "A. Build initial counting skills with support.",
      "B. Ensure students memorize numbers to 5.",
      "C. Teach fast counting without guidance.",
      "D. Prepare for immediate number writing.",
    ],
    correctAnswer: "A",
    explanation:
        "A reflects the goal. B is memorization, C skips support, D is unrelated.",
    level: QuestionLevel.level6a,
  ),
  Question(
    text:
        "According to the manual, when can students say the total without counting?",
    options: [
      "A. After mastering counting up to 10 with accuracy.",
      "B. When they finish all dot exercises quickly.",
      "C. If they recognize numbers without pointing.",
      "D. After observing peers count successfully.",
    ],
    correctAnswer: "A",
    explanation:
        "A ensures mastery. B focuses on speed, C skips counting, D relies on others.",
    level: QuestionLevel.level6a,
  ),
];

final List<Question> level5aQuestions = [
  Question(
    text:
        "A student struggles to read numbers up to 50 aloud. What would you do?",
    options: [
      "A. Point to each number and read it with them.",
      "B. Show a number line and ask them to read slowly.",
      "C. Model reading the numbers, then have them repeat.",
      "D. Let them try again without immediate help.",
    ],
    correctAnswer: "A",
    explanation:
        "A provides direct support with pointing. B relies on tools, C shifts to modeling, D lacks guidance.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text:
        "A student mixes up 30 and 50 while reading numbers. How should you respond?",
    options: [
      "A. Repeat 30 and 50 clearly, asking them to echo.",
      "B. Point to 30 and 50 on a chart, guiding their reading.",
      "C. Correct each mistake as they read without pause.",
      "D. Review the numbers at the end of the session.",
    ],
    correctAnswer: "B",
    explanation:
        "B uses visual aid for clarity. A is verbal-only, C disrupts flow, D delays correction.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "A student reads numbers quickly but skips 45-50. What would you do?",
    options: [
      "A. Recount 45-50 with them, pointing to each number.",
      "B. Praise their speed and ask them to retry slowly.",
      "C. Assign a new exercise focusing on 45-50.",
      "D. Observe and let them self-correct next time.",
    ],
    correctAnswer: "A",
    explanation:
        "A addresses skips directly. B reinforces speed, C is preparatory, D avoids help.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text:
        "A student refuses to read numbers aloud in a group. What’s your best action?",
    options: [
      "A. Allow silent reading and ask for the total later.",
      "B. Pair them with a peer to read together.",
      "C. Model reading aloud, inviting them to join.",
      "D. Move to a one-on-one session for practice.",
    ],
    correctAnswer: "C",
    explanation:
        "C encourages participation gently. A avoids verbal practice, B adds pressure, D over-adjusts.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text:
        "A student struggles with the sequence 20-30, reversing order. What should you do?",
    options: [
      "A. Recite 20-30 with them, pointing in order.",
      "B. Show a number line and guide their recitation.",
      "C. Ask them to retry without assistance.",
      "D. Give a simpler sequence exercise to start.",
    ],
    correctAnswer: "A",
    explanation:
        "A corrects with guidance. B relies on tools, C lacks support, D lowers difficulty.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text:
        "A student hesitates reading numbers 70-100 on a worksheet. What would you do?",
    options: [
      "A. Point to each number and say it with them.",
      "B. Provide a number chart for them to study first.",
      "C. Read 70-100 slowly, asking them to repeat.",
      "D. Let them trace the numbers before reading.",
    ],
    correctAnswer: "A",
    explanation:
        "A combines pointing and verbal aid. B delays practice, C skips visuals, D avoids reading.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "A student stops at 60 while reading to 100. What’s your approach?",
    options: [
      "A. Count to 100 with them, emphasizing 60-100.",
      "B. Encourage them past 60 with your guidance.",
      "C. Show a number line and ask them to continue.",
      "D. Assign a task stopping at 60 to build confidence.",
    ],
    correctAnswer: "B",
    explanation:
        "B builds on their limit with support. A over-directs, C relies on tools, D limits progress.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text:
        "Parent Says: 'My child repeats the same number reading daily. Is this needed?'",
    options: [
      "A. Explain that repetition builds reading fluency and accuracy.",
      "B. Note that daily practice ensures strong number recognition.",
      "C. Assure them repetition strengthens reading skills over time.",
      "D. Suggest that consistent reading prepares them for higher levels.",
    ],
    correctAnswer: "A",
    explanation:
        "A ties repetition to fluency. B is vague, C lacks detail, D shifts focus to progression.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "Parent Says: 'My child finds reading numbers boring.'",
    options: [
      "A. Highlight that number reading builds focus and recognition.",
      "B. Explain that repetition improves reading and confidence.",
      "C. Note that reading exercises develop accuracy and skills.",
      "D. Assure them number practice strengthens early learning.",
    ],
    correctAnswer: "A",
    explanation:
        "A addresses focus and recognition. B misses engagement, C is partial, D is too broad.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "Parent Says: 'My child knows numbers to 50. Why go to 100?'",
    options: [
      "A. Clarify that extending to 100 builds a stronger number base.",
      "B. Explain that reading to 100 ensures full early mastery.",
      "C. Note that progressing to 100 develops confidence and skills.",
      "D. Assure them reaching 100 solidifies number foundations.",
    ],
    correctAnswer: "B",
    explanation:
        "B emphasizes mastery. A is general, C focuses on confidence, D lacks specificity.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "Parent Says: 'My child struggles with number sequences.'",
    options: [
      "A. Suggest practicing sequences with pointing at home.",
      "B. Recommend using worksheets to improve sequence skills.",
      "C. Offer to model sequences during sessions.",
      "D. Advise focusing on slow recitation with aids.",
    ],
    correctAnswer: "C",
    explanation:
        "C provides direct support. A shifts to parents, B is passive, D lacks structure.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "Parent Says: 'Why does my child read numbers aloud so much?'",
    options: [
      "A. Explain that aloud reading builds verbal number skills.",
      "B. Note that speaking numbers enhances memory and fluency.",
      "C. Assure them reading aloud reinforces number recognition.",
      "D. Suggest that verbal reading strengthens sequence habits.",
    ],
    correctAnswer: "A",
    explanation:
        "A links to verbal skills. B is secondary, C is vague, D is repetitive.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "Parent Says: 'My child skips numbers when tired.'",
    options: [
      "A. Recommend a break before resuming with guidance.",
      "B. Suggest continuing with fewer numbers to finish.",
      "C. Advise observing and correcting skips later.",
      "D. Propose reducing the session length slightly.",
    ],
    correctAnswer: "A",
    explanation:
        "A addresses fatigue effectively. B lowers expectation, C delays help, D is temporary.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text:
        "A student reads inaccurately due to poor number recognition. What’s the best first step?",
    options: [
      "A. Point to each number and read with them.",
      "B. Demonstrate reading before they retry.",
      "C. Ask them to read without assistance.",
      "D. Provide a new reading exercise with help.",
    ],
    correctAnswer: "A",
    explanation:
        "A corrects recognition directly. B is preparatory, C lacks support, D delays focus.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "A student hesitates reading 80-90. What’s your priority?",
    options: [
      "A. Model reading slowly, asking them to follow.",
      "B. Point to each number while saying it aloud.",
      "C. Encourage them to read with minimal help.",
      "D. Show a number chart for them to study.",
    ],
    correctAnswer: "B",
    explanation:
        "B combines support and practice. A is modeling-only, C lacks aid, D is passive.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text:
        "A student skips numbers 45-50 during reading. What should you do first?",
    options: [
      "A. Recite 45-50 with them, pointing to each.",
      "B. Let them retry and check their accuracy.",
      "C. Assign a simpler sequence to rebuild.",
      "D. Observe and offer hints if they struggle.",
    ],
    correctAnswer: "A",
    explanation:
        "A ensures immediate correction. B delays help, C reduces challenge, D is indirect.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "A student struggles with sequence 30-40. What’s your best action?",
    options: [
      "A. Read 30-40 with them, pointing each number.",
      "B. Show a sequence chart and guide their reading.",
      "C. Ask them to recite without assistance.",
      "D. Provide a new worksheet with number lines.",
    ],
    correctAnswer: "A",
    explanation:
        "A offers direct guidance. B relies on tools, C lacks support, D is preparatory.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "A student loses focus reading to 100. What’s your priority?",
    options: [
      "A. Redirect with a short reading game and praise.",
      "B. Continue reading with them, keeping focus.",
      "C. Suggest a break before resuming the task.",
      "D. Assign a new task to regain their interest.",
    ],
    correctAnswer: "B",
    explanation:
        "B maintains engagement. A is distracting, C delays, D shifts focus.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text:
        "Case Study: A 5-year-old student reads numbers up to 30 but stops, looking confused. What’s the best way to help them progress?",
    options: [
      "A. Read to 50 with them, pointing to each number.",
      "B. Show the numbers and ask them to read alone.",
      "C. Guide their reading to 50 with pointing support.",
      "D. Provide a new sheet with numbers written.",
    ],
    correctAnswer: "C",
    explanation:
        "C builds on their skill with guidance. A is gradual, B lacks aid, D adds complexity.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text:
        "Case Study: A student reads 1-50 correctly but stumbles at 51-100. How should you support their learning?",
    options: [
      "A. Read 51-100 aloud, asking them to repeat each.",
      "B. Point to 51-100 while saying them together.",
      "C. Show a number line and guide their reading.",
      "D. Let them try again without immediate help.",
    ],
    correctAnswer: "B",
    explanation:
        "B combines visual and verbal aid. A is verbal-only, C relies on tools, D lacks support.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text:
        "Case Study: A student reverses 70 and 90 often while reading. What’s your first step to correct this?",
    options: [
      "A. Recite 70-90 with them, clarifying positions.",
      "B. Show a number chart and ask them to identify 70-90.",
      "C. Point to 70 and 90 while reading together.",
      "D. Assign a new task focusing on 70-90 recognition.",
    ],
    correctAnswer: "C",
    explanation:
        "C corrects with real-time guidance. A is verbal, B is passive, D delays focus.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text:
        "Case Study: A student hesitates during sequence reading, looking at peers. What should you do to build confidence?",
    options: [
      "A. Read the sequence with them, offering praise.",
      "B. Encourage them to watch peers, then try alone.",
      "C. Demonstrate reading, asking them to follow.",
      "D. Suggest they read silently to reduce pressure.",
    ],
    correctAnswer: "A",
    explanation:
        "A boosts confidence with support. B increases comparison, C shifts focus, D avoids practice.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "What is the main goal of number reading in Level 5A?",
    options: [
      "A. Build fluency in reading numbers up to 100.",
      "B. Teach students to recognize numbers quickly.",
      "C. Help students memorize number sequences.",
      "D. Ensure students read without errors daily.",
    ],
    correctAnswer: "A",
    explanation:
        "A focuses on fluency. B is secondary, C is memorization, D is unrealistic.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "Why does Kumon emphasize pointing during reading?",
    options: [
      "A. It guides students to focus on each number.",
      "B. It helps students read faster and better.",
      "C. It reduces the need for verbal instructions.",
      "D. It ensures students memorize number order.",
    ],
    correctAnswer: "A",
    explanation:
        "A enhances focus. B overstates speed, C minimizes teaching, D is incidental.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "When should a student move from reading to 50 to 100?",
    options: [
      "A. After consistent accuracy up to 50.",
      "B. When they can read to 50 without help.",
      "C. Once they master reading up to 100 fully.",
      "D. After recognizing all numbers to 100.",
    ],
    correctAnswer: "A",
    explanation:
        "A ensures readiness. B lacks progression, C is premature, D skips reading.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "What is the purpose of sequence reading in early levels?",
    options: [
      "A. Develop verbal recognition of number order.",
      "B. Teach students to write sequences correctly.",
      "C. Help students count objects quickly.",
      "D. Ensure mastery of number tables.",
    ],
    correctAnswer: "A",
    explanation:
        "A targets verbal order. B is writing-focused, C is counting, D is broader.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "How should instructors handle a student skipping numbers?",
    options: [
      "A. Recite with them, pointing to missed numbers.",
      "B. Let them self-correct on the next attempt.",
      "C. Assign easier sequences to rebuild skills.",
      "D. None of the above.",
    ],
    correctAnswer: "D",
    explanation:
        "D applies; immediate correction is needed, not self-correction or easing.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "What role does repetition play in Level 5A?",
    options: [
      "A. Reinforces reading accuracy and confidence.",
      "B. Helps students finish worksheets faster.",
      "C. Ensures they memorize numbers quickly.",
      "D. Reduces the need for instructor guidance.",
    ],
    correctAnswer: "A",
    explanation:
        "A builds skills. B focuses on speed, C is memorization, D is incorrect.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text:
        "According to Level 5A, how should instructors introduce reading to 50?",
    options: [
      "A. Start with 1-30, then add 31-50 with pointing.",
      "B. Begin with 50, reducing to 30 if needed.",
      "C. Teach all numbers at once with a chart.",
      "D. Read silently, showing numbers later.",
    ],
    correctAnswer: "A",
    explanation:
        "A follows the manual’s progression. B reverses order, C overwhelms, D skips verbal.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text:
        "What does the manual suggest for students struggling with sequence reading?",
    options: [
      "A. Point and read together to guide them.",
      "B. Let them observe peers before retrying.",
      "C. Provide a new sheet without assistance.",
      "D. Skip to number writing exercises.",
    ],
    correctAnswer: "A",
    explanation:
        "A aligns with guidance. B delays, C lacks support, D shifts focus.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "How should instructors use the Reading Numbers section?",
    options: [
      "A. Guide reading with pointing up to 100.",
      "B. Teach students to guess numbers quickly.",
      "C. Focus on writing numbers after reading.",
      "D. Allow self-correction without help.",
    ],
    correctAnswer: "A",
    explanation:
        "A matches the manual. B avoids accuracy, C is premature, D lacks support.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "What is the aim of the sequence up to 50 exercises per the manual?",
    options: [
      "A. Build initial sequence skills with support.",
      "B. Ensure students memorize numbers to 50.",
      "C. Teach fast reading without guidance.",
      "D. Prepare for immediate number writing.",
    ],
    correctAnswer: "A",
    explanation:
        "A reflects the goal. B is memorization, C skips support, D is unrelated.",
    level: QuestionLevel.level5a,
  ),
  Question(
    text: "According to the manual, when can students connect missing numbers?",
    options: [
      "A. After mastering reading up to 100 with accuracy.",
      "B. When they finish all the sequence exercises quickly.",
      "C. If they recognize numbers without pointing.",
      "D. After observing peers connect numbers.",
    ],
    correctAnswer: "A",
    explanation:
        "A ensures mastery. B focuses on speed, C skips practice, D relies on others.",
    level: QuestionLevel.level5a,
  ),
];

final List<Question> level4aQuestions = [
  Question(
    text:
        "A student struggles to trace numbers up to 50 accurately. What would you do?",
    options: [
      "A. Guide their hand while tracing each number.",
      "B. Show the tracing pattern, then let them try.",
      "C. Demonstrate tracing slowly, asking them to follow.",
      "D. Ask them to trace again without assistance.",
    ],
    correctAnswer: "A",
    explanation:
        "A provides direct support. B is passive, C shifts to modeling, D lacks guidance.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "A student writes 30 as 03 while tracing. How should you respond?",
    options: [
      "A. Trace 30 correctly, asking them to repeat.",
      "B. Point out the error and guide their tracing.",
      "C. Correct the mistake after they finish.",
      "D. Let them continue and review later.",
    ],
    correctAnswer: "A",
    explanation:
        "A corrects with immediate guidance. B is verbal-only, C delays, D avoids correction.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "A student finishes tracing quickly but with sloppy numbers. What would you do?",
    options: [
      "A. Review their tracing, guiding proper form.",
      "B. Praise their speed and ask for neater work.",
      "C. Assign a new tracing exercise with focus.",
      "D. Observe and let them self-correct next time.",
    ],
    correctAnswer: "A",
    explanation:
        "A addresses form directly. B reinforces speed, C is preparatory, D lacks support.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "A student refuses to trace numbers in a group. What’s your best action?",
    options: [
      "A. Allow silent tracing and check their work.",
      "B. Pair them with a peer to trace together.",
      "C. Demonstrate tracing, inviting them to join.",
      "D. Move to a one-on-one session for practice.",
    ],
    correctAnswer: "C",
    explanation:
        "C encourages participation gently. A avoids group practice, B adds pressure, D over-adjusts.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "A student struggles with writing numbers 80-100, reversing digits. What should you do?",
    options: [
      "A. Write 80-100 with them, correcting reversals.",
      "B. Show a number chart and guide their writing.",
      "C. Ask them to rewrite without assistance.",
      "D. Give a simpler range to build confidence.",
    ],
    correctAnswer: "A",
    explanation:
        "A corrects with guidance. B relies on tools, C lacks support, D lowers difficulty.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "A student hesitates tracing numbers 40-50 on a worksheet. What would you do?",
    options: [
      "A. Guide their hand while tracing 40-50.",
      "B. Provide a number line for them to trace.",
      "C. Demonstrate tracing, asking them to copy.",
      "D. Let them trace again without help.",
    ],
    correctAnswer: "A",
    explanation:
        "A offers direct support. B delays practice, C shifts to modeling, D lacks aid.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "A student stops at 60 while writing to 100. What’s your approach?",
    options: [
      "A. Write to 100 with them, emphasizing 60-100.",
      "B. Encourage them past 60 with your guidance.",
      "C. Show a number line and ask them to continue.",
      "D. Assign a task stopping at 60 to build skill.",
    ],
    correctAnswer: "B",
    explanation:
        "B builds on their limit with support. A over-directs, C relies on tools, D limits progress.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "Parent Says: 'My child repeats tracing numbers daily. Is this necessary?'",
    options: [
      "A. Explain that repetition builds tracing accuracy and skill.",
      "B. Note that daily practice ensures neat number formation.",
      "C. Assure them repetition strengthens writing habits over time.",
      "D. Suggest that consistent tracing prepares them for writing.",
    ],
    correctAnswer: "A",
    explanation:
        "A ties repetition to accuracy. B is vague, C lacks detail, D shifts focus to writing.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "Parent Says: 'My child finds tracing numbers boring.'",
    options: [
      "A. Highlight that tracing builds focus and number shape.",
      "B. Explain that repetition improves tracing and confidence.",
      "C. Note that tracing exercises develop accuracy and skills.",
      "D. Assure them tracing practice strengthens early writing.",
    ],
    correctAnswer: "A",
    explanation:
        "A addresses focus and shape. B misses engagement, C is partial, D is too broad.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "Parent Says: 'My child knows writing to 50. Why go to 100?'",
    options: [
      "A. Clarify that extending to 100 builds a stronger writing base.",
      "B. Explain that writing to 100 ensures full early mastery.",
      "C. Note that progressing to 100 develops confidence and skills.",
      "D. Assure them reaching 100 solidifies number foundations.",
    ],
    correctAnswer: "B",
    explanation:
        "B emphasizes mastery. A is general, C focuses on confidence, D lacks specificity.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "Parent Says: 'My child struggles with number writing.'",
    options: [
      "A. Suggest practicing writing with guidance at home.",
      "B. Recommend using worksheets to improve writing skills.",
      "C. Offer to model writing during sessions.",
      "D. Advise focusing on slow writing with support.",
    ],
    correctAnswer: "C",
    explanation:
        "C provides direct support. A shifts to parents, B is passive, D lacks structure.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "Parent Says: 'Why does my child trace numbers aloud so much?'",
    options: [
      "A. Explain that tracing aloud builds verbal number skills.",
      "B. Note that speaking during tracing enhances memory.",
      "C. Assure them tracing aloud reinforces number recognition.",
      "D. Suggest that verbal tracing strengthens writing habits.",
    ],
    correctAnswer: "A",
    explanation:
        "A links to verbal skills. B is secondary, C is vague, D is repetitive.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "Parent Says: 'My child writes sloppily when tired.'",
    options: [
      "A. Recommend a break before resuming with guidance.",
      "B. Suggest continuing with fewer numbers to finish.",
      "C. Advise observing and correcting later.",
      "D. Propose reducing the session length slightly.",
    ],
    correctAnswer: "A",
    explanation:
        "A addresses fatigue effectively. B lowers expectation, C delays help, D is temporary.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "A student traces inaccurately due to poor hand control. What’s the best first step?",
    options: [
      "A. Guide their hand while tracing each number.",
      "B. Demonstrate proper tracing before they retry.",
      "C. Ask them to trace without assistance.",
      "D. Provide a new tracing exercise with help.",
    ],
    correctAnswer: "A",
    explanation:
        "A corrects control directly. B is preparatory, C lacks support, D delays focus.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "A student hesitates writing 70-80. What’s your priority?",
    options: [
      "A. Model writing slowly, asking them to follow.",
      "B. Guide their hand while writing 70-80.",
      "C. Encourage them to write with minimal help.",
      "D. Show a number chart for them to copy.",
    ],
    correctAnswer: "B",
    explanation:
        "B combines support and practice. A is modeling-only, C lacks aid, D is passive.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "A student skips numbers 45-50 while writing. What should you do first?",
    options: [
      "A. Write 45-50 with them, guiding their hand.",
      "B. Let them retry and check their accuracy.",
      "C. Assign a simpler range to rebuild.",
      "D. Observe and offer hints if they struggle.",
    ],
    correctAnswer: "A",
    explanation:
        "A ensures immediate correction. B delays help, C reduces challenge, D is indirect.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "A student struggles with writing sequence 30-40. What’s your best action?",
    options: [
      "A. Write 30-40 with them, guiding each number.",
      "B. Show a sequence chart and guide their writing.",
      "C. Ask them to write without assistance.",
      "D. Provide a new worksheet with number lines.",
    ],
    correctAnswer: "A",
    explanation:
        "A offers direct guidance. B relies on tools, C lacks support, D is preparatory.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "A student loses focus writing to 100. What’s your priority?",
    options: [
      "A. Redirect with a short writing game and praise.",
      "B. Continue writing with them, keeping focus.",
      "C. Suggest a break before resuming the task.",
      "D. Assign a new task to regain their interest.",
    ],
    correctAnswer: "B",
    explanation:
        "B maintains engagement. A is distracting, C delays, D shifts focus.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "Case Study: A 4-year-old student traces numbers up to 30 but stops, looking confused. What’s the best way to help them progress?",
    options: [
      "A. Trace to 50 with them, guiding their hand.",
      "B. Show the numbers and ask them to trace alone.",
      "C. Guide their tracing to 50 with support.",
      "D. Provide a new sheet with numbers printed.",
    ],
    correctAnswer: "C",
    explanation:
        "C builds on their skill with guidance. A is gradual, B lacks aid, D adds complexity.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "Case Study: A student writes 1-50 correctly but stumbles at 51-100. How should you support their learning?",
    options: [
      "A. Write 51-100 with them, guiding their hand.",
      "B. Point to 51-100 while they write alone.",
      "C. Show a number line and guide their writing.",
      "D. Let them try again without immediate help.",
    ],
    correctAnswer: "A",
    explanation:
        "A combines visual and physical aid. B lacks guidance, C relies on tools, D lacks support.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "Case Study: A student reverses 70 and 90 often while writing. What’s your first step to correct this?",
    options: [
      "A. Write 70-90 with them, correcting reversals.",
      "B. Show a number chart and ask them to rewrite.",
      "C. Guide their hand for 70 and 90 correctly.",
      "D. Assign a new task focusing on 70-90.",
    ],
    correctAnswer: "C",
    explanation:
        "C corrects with real-time guidance. A is verbal, B is passive, D delays focus.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "Case Study: A student hesitates during number writing, looking at peers. What should you do to build confidence?",
    options: [
      "A. Write with them, offering praise.",
      "B. Encourage them to watch peers, then try.",
      "C. Demonstrate writing, asking them to follow.",
      "D. Suggest they write silently to reduce pressure.",
    ],
    correctAnswer: "A",
    explanation:
        "A boosts confidence with support. B increases comparison, C shifts focus, D avoids practice.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "What is the main goal of number tracing in Level 4A?",
    options: [
      "A. Build accuracy in tracing numbers up to 100.",
      "B. Teach students to recognize numbers quickly.",
      "C. Help students memorize number shapes.",
      "D. Ensure students trace without errors daily.",
    ],
    correctAnswer: "A",
    explanation:
        "A focuses on accuracy. B is secondary, C is memorization, D is unrealistic.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "Why does Kumon emphasize hand guidance during tracing?",
    options: [
      "A. It guides students to form numbers correctly.",
      "B. It helps students write faster and better.",
      "C. It reduces the need for verbal instructions.",
      "D. It ensures students memorize number order.",
    ],
    correctAnswer: "A",
    explanation:
        "A enhances form. B overstates speed, C minimizes teaching, D is incidental.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "When should a student move from tracing to 50 to 100?",
    options: [
      "A. After consistent accuracy up to 50.",
      "B. When they can trace to 50 without help.",
      "C. Once they master tracing up to 100 fully.",
      "D. After recognizing all numbers to 100.",
    ],
    correctAnswer: "A",
    explanation:
        "A ensures readiness. B lacks progression, C is premature, D skips tracing.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "What is the purpose of number writing in early levels?",
    options: [
      "A. Develop proper formation of numbers.",
      "B. Teach students to read numbers correctly.",
      "C. Help students count objects quickly.",
      "D. Ensure mastery of number sequences.",
    ],
    correctAnswer: "A",
    explanation:
        "A targets formation. B is reading-focused, C is counting, D is broader.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "How should instructors handle a student writing sloppily?",
    options: [
      "A. Guide their hand to improve form.",
      "B. Let them self-correct on the next attempt.",
      "C. Assign easier exercises to rebuild skills.",
      "D. None of the above.",
    ],
    correctAnswer: "D",
    explanation:
        "D applies; immediate guidance is needed, not self-correction or easing.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "What role does repetition play in Level 4A?",
    options: [
      "A. Reinforces tracing accuracy and confidence.",
      "B. Helps students finish worksheets faster.",
      "C. Ensures they memorize numbers quickly.",
      "D. Reduces the need for instructor guidance.",
    ],
    correctAnswer: "A",
    explanation:
        "A builds skills. B focuses on speed, C is memorization, D is incorrect.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "According to Level 4A, how should instructors introduce tracing to 50?",
    options: [
      "A. Start with 1-30, then add 31-50 with guidance.",
      "B. Begin with 50, reducing to 30 if needed.",
      "C. Teach all numbers at once with a chart.",
      "D. Trace silently, showing numbers later.",
    ],
    correctAnswer: "A",
    explanation:
        "A follows the manual’s progression. B reverses order, C overwhelms, D skips verbal.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text:
        "What does the manual suggest for students struggling with number writing?",
    options: [
      "A. Guide their hand while writing to assist.",
      "B. Let them observe peers before retrying.",
      "C. Provide a new sheet without assistance.",
      "D. Skip to number reading exercises.",
    ],
    correctAnswer: "A",
    explanation:
        "A aligns with guidance. B delays, C lacks support, D shifts focus.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "How should instructors use the Number Writing section?",
    options: [
      "A. Guide writing with hand support up to 100.",
      "B. Teach students to guess numbers quickly.",
      "C. Focus on tracing numbers after writing.",
      "D. Allow self-correction without help.",
    ],
    correctAnswer: "A",
    explanation:
        "A matches the manual. B avoids accuracy, C is premature, D lacks support.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "What is the aim of the tracing up to 50 exercise per the manual?",
    options: [
      "A. Build initial tracing skills with support.",
      "B. Ensure students memorize numbers to 50.",
      "C. Teach fast writing without guidance.",
      "D. Prepare for immediate number reading.",
    ],
    correctAnswer: "A",
    explanation:
        "A reflects the goal. B is memorization, C skips support, D is unrelated.",
    level: QuestionLevel.level4a,
  ),
  Question(
    text: "According to the manual, when can students write independently?",
    options: [
      "A. After mastering tracing up to 100 with accuracy.",
      "B. When they finish all writing exercises quickly.",
      "C. If they recognize numbers without tracing.",
      "D. After observing peers write successfully.",
    ],
    correctAnswer: "A",
    explanation:
        "A ensures mastery. B focuses on speed, C skips tracing, D relies on others.",
    level: QuestionLevel.level4a,
  ),
];

final List<Question> level3aQuestions = [
  Question(
    text:
        'A student struggles to add 1 to numbers up to 120. What would you do?',
    options: [
      'A. Add 1 with them, pointing to each step.',
      'B. Show an example and ask them to try.',
      'C. Demonstrate adding 1, then have them follow.',
      'D. Let them attempt again without help.',
    ],
    correctAnswer: 'A',
    explanation:
        'A provides direct support with pointing. B is passive, C shifts to modeling, D lacks guidance.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text:
        'A student hesitates when adding 2 to numbers 60-80. What’s your next step?',
    options: [
      'A. Add 2 with them, guiding each number.',
      'B. Model adding 2, then ask them to copy.',
      'C. Point to the numbers while they add.',
      'D. Provide a new sheet for independent practice.',
    ],
    correctAnswer:
        'A', // Note: Original says A & B; choosing A as primary based on guided support emphasis.
    explanation:
        'A and B offer guided and modeled support. C lacks addition focus, D avoids help.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text:
        'A student adds 1 but skips numbers in the sequence. How should you respond?',
    options: [
      'A. Add 1 with them, correcting the sequence.',
      'B. Point out skips and guide their addition.',
      'C. Review mistakes after they finish.',
      'D. Let them continue and check later.',
    ],
    correctAnswer: 'A',
    explanation:
        'A corrects with immediate guidance. B is verbal-only, C delays, D avoids correction.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text:
        'A student finishes adding 1 quickly but makes errors. What would you do?',
    options: [
      'A. Review their work, guiding correct addition.',
      'B. Praise their speed and ask for accuracy.',
      'C. Assign a new addition exercise with focus.',
      'D. Observe and let them self-correct next time.',
    ],
    correctAnswer: 'A',
    explanation:
        'A addresses errors directly. B reinforces speed, C is preparatory, D lacks support.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'A student refuses to add aloud in a group. What’s your best action?',
    options: [
      'A. Allow silent addition and check their answer.',
      'B. Pair them with a peer to add together.',
      'C. Demonstrate adding aloud, inviting them to join.',
      'D. Move to a one-on-one session for practice.',
    ],
    correctAnswer: 'C',
    explanation:
        'C encourages participation gently. A avoids verbal practice, B adds pressure, D over-adjusts.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text:
        'A student struggles with adding 2 to 90-100, mixing results. What should you do?',
    options: [
      'A. Add 2 with them, clarifying each step.',
      'B. Show a number line and guide their addition.',
      'C. Ask them to retry without assistance.',
      'D. Give a simpler range to build confidence.',
    ],
    correctAnswer: 'A',
    explanation:
        'A corrects with guidance. B relies on tools, C lacks support, D lowers difficulty.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text:
        'A student hesitates adding 1 to numbers 50-70 on a worksheet. What would you do?',
    options: [
      'A. Add 1 with them, guiding each number.',
      'B. Provide a number chart for them to use.',
      'C. Demonstrate adding 1, asking them to copy.',
      'D. Let them add again without help.',
    ],
    correctAnswer: 'A',
    explanation:
        'A offers direct support. B delays practice, C shifts to modeling, D lacks aid.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'A student stops at 80 while adding to 120. What’s your approach?',
    options: [
      'A. Add to 120 with them, emphasizing 80-120.',
      'B. Encourage them past 80 with your guidance.',
      'C. Show a number line and ask them to continue.',
      'D. Assign a task stopping at 80 to build skill.',
    ],
    correctAnswer: 'B',
    explanation:
        'B builds on their limit with support. A over-directs, C relies on tools, D limits progress.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'Parent Says: “My child repeats adding 1 daily. Is this necessary?”',
    options: [
      'A. Explain that repetition builds addition accuracy and skill.',
      'B. Note that daily practice ensures strong number addition.',
      'C. Assure them repetition strengthens adding habits over time.',
      'D. Suggest that consistent addition prepares them for more.',
    ],
    correctAnswer: 'A',
    explanation:
        'A ties repetition to accuracy. B is vague, C lacks detail, D shifts focus to progression.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'Parent Says: “My child finds adding 2 boring.”',
    options: [
      'A. Highlight that adding 2 builds focus and number sense.',
      'B. Explain that repetition improves addition and confidence.',
      'C. Note that adding exercises develop accuracy and skills.',
      'D. Assure them addition practice strengthens early math.',
    ],
    correctAnswer: 'A',
    explanation:
        'A addresses focus and sense. B misses engagement, C is partial, D is too broad.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'Parent Says: “My child knows adding 1 to 50. Why go to 120?”',
    options: [
      'A. Clarify that extending to 120 builds a stronger addition base.',
      'B. Explain that adding to 120 ensures full early mastery.',
      'C. Note that progressing to 120 develops confidence and skills.',
      'D. Assure them reaching 120 solidifies number foundations.',
    ],
    correctAnswer: 'B',
    explanation:
        'B emphasizes mastery. A is general, C focuses on confidence, D lacks specificity.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'Parent Says: “My child struggles with adding 2.”',
    options: [
      'A. Suggest practicing addition with guidance at home.',
      'B. Recommend using worksheets to improve addition skills.',
      'C. Offer to model adding during sessions.',
      'D. Advise focusing on slow addition with support.',
    ],
    correctAnswer: 'C',
    explanation:
        'C provides direct support. A shifts to parents, B is passive, D lacks structure.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'Parent Says: “Why does my child add aloud so much?”',
    options: [
      'A. Explain that adding aloud builds verbal math skills.',
      'B. Note that speaking during addition enhances memory.',
      'C. Assure them adding aloud reinforces number sense.',
      'D. Suggest that verbal addition strengthens math habits.',
    ],
    correctAnswer: 'A',
    explanation:
        'A links to verbal skills. B is secondary, C is vague, D is repetitive.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'Parent Says: “My child makes errors when tired.”',
    options: [
      'A. Recommend a break before resuming with guidance.',
      'B. Suggest continuing with fewer problems to finish.',
      'C. Advise observing and correcting later.',
      'D. Propose reducing the session length slightly.',
    ],
    correctAnswer: 'A',
    explanation:
        'A addresses fatigue effectively. B lowers expectation, C delays help, D is temporary.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text:
        'A student adds 1 inaccurately due to sequence confusion. What’s the best first step?',
    options: [
      'A. Add 1 with them, pointing to each number.',
      'B. Demonstrate adding 1 before they retry.',
      'C. Ask them to add without assistance.',
      'D. Provide a new addition exercise with help.',
    ],
    correctAnswer: 'A',
    explanation:
        'A corrects confusion directly. B is preparatory, C lacks support, D delays focus.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'A student hesitates adding 2 to 90-100. What’s your priority?',
    options: [
      'A. Model adding 2 slowly, asking them to follow.',
      'B. Add 2 with them, guiding each step.',
      'C. Encourage them to add with minimal help.',
      'D. Show a number chart for them to use.',
    ],
    correctAnswer: 'B',
    explanation:
        'B combines support and practice. A is modeling-only, C lacks aid, D is passive.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'A student skips numbers while adding 1. What should you do first?',
    options: [
      'A. Add 1 with them, pointing to missed numbers.',
      'B. Let them retry and check their accuracy.',
      'C. Assign a simpler range to rebuild.',
      'D. Observe and offer hints if they struggle.',
    ],
    correctAnswer: 'A',
    explanation:
        'A ensures immediate correction. B delays help, C reduces challenge, D is indirect.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text:
        'A student struggles with adding 2 to 50-70. What’s your best action?',
    options: [
      'A. Add 2 with them, guiding each number.',
      'B. Show a sequence chart and guide their addition.',
      'C. Ask them to add without assistance.',
      'D. Provide a new worksheet with number lines.',
    ],
    correctAnswer: 'A',
    explanation:
        'A offers direct guidance. B relies on tools, C lacks support, D is preparatory.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'A student loses focus adding to 120. What’s your priority?',
    options: [
      'A. Redirect with a short addition game and praise.',
      'B. Continue adding with them, keeping focus.',
      'C. Suggest a break before resuming the task.',
      'D. Assign a new task to regain their interest.',
    ],
    correctAnswer: 'B',
    explanation:
        'B maintains engagement. A is distracting, C delays, D shifts focus.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text:
        'Case Study: A 5-year-old student adds 1 up to 60 but stops, looking confused. What’s the best way to help them progress?',
    options: [
      'A. Add 1 to 120 with them, guiding each step.',
      'B. Show the numbers and ask them to add alone.',
      'C. Guide their adding to 120 with support.',
      'D. Provide a new sheet with addition written.',
    ],
    correctAnswer: 'C',
    explanation:
        'C builds on their skill with guidance. A is gradual, B lacks aid, D adds complexity.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text:
        'Case Study: A student adds 1 to 1-50 correctly but stumbles at 51-120. How should you support their learning?',
    options: [
      'A. Add 1 to 51-120 with them, guiding each step.',
      'B. Point to 51-120 while they add alone.',
      'C. Show a number line and guide their addition.',
      'D. Let them try again without immediate help.',
    ],
    correctAnswer: 'A',
    explanation:
        'A combines visual and physical aid. B lacks guidance, C relies on tools, D lacks support.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text:
        'Case Study: A student adds 2 but reverses 90 and 100 often. What’s your first step to correct this?',
    options: [
      'A. Add 2 with them, clarifying 90-100 positions.',
      'B. Show a number chart and ask them to add.',
      'C. Guide their hand for 90 and 100 correctly.',
      'D. Assign a new task focusing on 90-100.',
    ],
    correctAnswer: 'A',
    explanation:
        'A corrects with real-time guidance. B is passive, C is for tracing, D delays focus.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text:
        'Case Study: A student hesitates during adding 2, looking at peers. What should you do to build confidence?',
    options: [
      'A. Add 2 with them, offering praise.',
      'B. Encourage them to watch peers, then try.',
      'C. Demonstrate adding, asking them to follow.',
      'D. Suggest they add silently to reduce pressure.',
    ],
    correctAnswer: 'A',
    explanation:
        'A boosts confidence with support. B increases comparison, C shifts focus, D avoids practice.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text:
        'Case Study: A student struggles with adding 1 up to 120. What additional steps would you take?',
    options: [
      'A. Practice adding 1 with guidance daily.',
      'B. Use number cards for extra addition drills.',
      'C. Model adding, then guide their practice.',
      'D. Assign more worksheets with addition lists.',
    ],
    correctAnswer:
        'A', // Note: Original says A & C; choosing A as primary for daily guidance emphasis.
    explanation:
        'A and C reinforce adding with guidance. B is tool-dependent, D is repetitive.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'What is the main goal of adding 1 in Level 3A?',
    options: [
      'A. Build fluency in adding 1 up to 120.',
      'B. Teach students to recognize number sums.',
      'C. Help students memorize addition facts.',
      'D. Ensure students add without errors daily.',
    ],
    correctAnswer: 'A',
    explanation:
        'A focuses on fluency. B is secondary, C is memorization, D is unrealistic.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'Why does Kumon emphasize guidance during adding?',
    options: [
      'A. It helps students understand each step.',
      'B. It speeds up addition practice.',
      'C. It reduces the need for verbal instructions.',
      'D. It ensures students memorize sums.',
    ],
    correctAnswer: 'A',
    explanation:
        'A enhances understanding. B overstates speed, C minimizes teaching, D is incidental.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'When should a student move from adding 1 to adding 2?',
    options: [
      'A. After consistent accuracy with adding 1.',
      'B. When they can add 1 without help.',
      'C. Once they master adding 2 fully.',
      'D. After recognizing all sums to 120.',
    ],
    correctAnswer: 'A',
    explanation:
        'A ensures readiness. B lacks progression, C is premature, D skips adding.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'What is the purpose of number sequence in early levels?',
    options: [
      'A. Develop understanding of number order.',
      'B. Teach students to write numbers correctly.',
      'C. Help students count objects quickly.',
      'D. Ensure mastery of addition tables.',
    ],
    correctAnswer: 'A',
    explanation:
        'A targets order. B is writing-focused, C is counting, D is broader.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'How should instructors handle a student skipping numbers?',
    options: [
      'A. Add with them, pointing to missed numbers.',
      'B. Let them self-correct on the next attempt.',
      'C. Assign easier problems to rebuild skills.',
      'D. None of the above.',
    ],
    correctAnswer: 'D',
    explanation:
        'D applies; immediate correction is needed, not self-correction or easing.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'What role does repetition play in Level 3A?',
    options: [
      'A. Reinforces addition accuracy and confidence.',
      'B. Helps students finish worksheets faster.',
      'C. Ensures they memorize sums quickly.',
      'D. Reduces the need for instructor guidance.',
    ],
    correctAnswer: 'A',
    explanation:
        'A builds skills. B focuses on speed, C is memorization, D is incorrect.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'According to Level 3A, how should instructors introduce adding 1?',
    options: [
      'A. Start with 1-60, then add 61-120 with guidance.',
      'B. Begin with 120, reducing to 60 if needed.',
      'C. Teach all additions at once with a chart.',
      'D. Add silently, showing sums later.',
    ],
    correctAnswer: 'A',
    explanation:
        'A follows the manual’s progression. B reverses order, C overwhelms, D skips verbal.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'What does the manual suggest for students struggling with adding 2?',
    options: [
      'A. Add 2 with them to guide the process.',
      'B. Let them observe peers before retrying.',
      'C. Provide a new sheet without assistance.',
      'D. Skip to adding 3 exercises.',
    ],
    correctAnswer: 'A',
    explanation:
        'A aligns with guidance. B delays, C lacks support, D shifts focus.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'How should instructors use the Adding 1 section?',
    options: [
      'A. Guide adding 1 with support up to 120.',
      'B. Teach students to guess sums quickly.',
      'C. Focus on writing numbers after adding.',
      'D. Allow self-correction without help.',
    ],
    correctAnswer: 'A',
    explanation:
        'A matches the manual. B avoids accuracy, C is premature, D lacks support.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'What is the aim of the numbers up to 120 exercise per the manual?',
    options: [
      'A. Build initial sequence skills with support.',
      'B. Ensure students memorize numbers to 120.',
      'C. Teach fast adding without guidance.',
      'D. Prepare for immediate number writing.',
    ],
    correctAnswer: 'A',
    explanation:
        'A reflects the goal. B is memorization, C skips support, D is unrelated.',
    level: QuestionLevel.level3a,
  ),
  Question(
    text: 'According to the manual, when can students solve addition smoothly?',
    options: [
      'A. After mastering adding 1 and 2 up to 120.',
      'B. When they finish all addition exercises quickly.',
      'C. If they recognize sums without guidance.',
      'D. After observing peers solve additions.',
    ],
    correctAnswer: 'A',
    explanation:
        'A ensures mastery. B focuses on speed, C skips practice, D relies on others.',
    level: QuestionLevel.level3a,
  ),
];

final List<Question> level2aQuestions = [
  Question(
    text: 'A student struggles to solve addition facts up to 10 (e.g., 7 + 2). What would you do?',
    options: [
      'A. Solve the problem with them, guiding each step.',
      'B. Show the problem and ask them to try again.',
      'C. Demonstrate solving, then have them follow.',
      'D. Let them attempt without assistance.',
    ],
    correctAnswer: 'A',
    explanation: 'A provides direct support. B is passive, C shifts to modeling, D lacks guidance.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'A student hesitates when counting numbers in sequence (e.g., 6, 7, __). What’s your next step?',
    options: [
      'A. Count the sequence with them, guiding each number.',
      'B. Model the sequence, then ask them to repeat.',
      'C. Point to the numbers while they count.',
      'D. Provide a new sequence for independent practice.',
    ],
    correctAnswer: 'A', // Choosing A as primary based on guided support emphasis
    explanation: 'A and B offer guided and modeled support, but A is prioritized for direct guidance. C lacks counting focus, D avoids help.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'A student makes errors while adding numbers (e.g., 5 + 3 = 9). How should you respond?',
    options: [
      'A. Solve the problem correctly, asking them to follow.',
      'B. Point out errors and guide their calculation.',
      'C. Correct mistakes after they finish.',
      'D. Let them continue and review later.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects with immediate guidance. B is verbal-only, C delays, D avoids correction.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'A student finishes addition problems quickly but with mistakes. What would you do?',
    options: [
      'A. Review their work, guiding correct solutions.',
      'B. Praise their speed and ask for accuracy.',
      'C. Assign a new addition exercise with focus.',
      'D. Observe and let them self-correct next time.',
    ],
    correctAnswer: 'A',
    explanation: 'A addresses errors directly. B reinforces speed, C is preparatory, D lacks support.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'A student refuses to count aloud in a group setting. What’s your best action?',
    options: [
      'A. Allow silent counting and check their work.',
      'B. Pair them with a peer to count together.',
      'C. Model counting aloud, inviting them to join.',
      'D. Move to a one-on-one session for practice.',
    ],
    correctAnswer: 'C',
    explanation: 'C encourages participation gently. A avoids group practice, B adds pressure, D over-adjusts.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'A student struggles with writing numbers in a sequence, mixing order. What should you do?',
    options: [
      'A. Write the sequence with them, correcting order.',
      'B. Show a number chart and guide their writing.',
      'C. Ask them to retry without assistance.',
      'D. Give simpler sequences to build confidence.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects with guidance. B relies on tools, C lacks support, D lowers difficulty.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'A student hesitates solving addition on a worksheet. What would you do?',
    options: [
      'A. Solve the problems with them, guiding each step.',
      'B. Provide a sample problem for them to study first.',
      'C. Demonstrate solving, asking them to copy.',
      'D. Let them solve again without help.',
    ],
    correctAnswer: 'A',
    explanation: 'A offers direct support. B delays practice, C shifts to modeling, D lacks aid.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'A student stops at problem 5 while solving 10 addition problems. What’s your approach?',
    options: [
      'A. Solve all 10 with them, emphasizing 5-10.',
      'B. Encourage them past 5 with your guidance.',
      'C. Show a problem list and ask them to continue.',
      'D. Assign a task stopping at 5 to build skill.',
    ],
    correctAnswer: 'B',
    explanation: 'B builds on their limit with support. A over-directs, C relies on tools, D limits progress.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'Parent Says: “My child solves the same addition problems daily. Is this necessary?”',
    options: [
      'A. Explain that repetition builds addition accuracy and skill.',
      'B. Note that daily practice ensures quick number recognition.',
      'C. Assure them repetition strengthens math habits over time.',
      'D. Suggest that consistent solving prepares them for subtraction.',
    ],
    correctAnswer: 'A',
    explanation: 'A ties repetition to accuracy. B is vague, C lacks detail, D shifts focus to subtraction.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'Parent Says: “My child finds counting sequences boring.”',
    options: [
      'A. Highlight that counting builds focus and number recognition.',
      'B. Explain that repetition improves counting and confidence.',
      'C. Note that sequence practice develops accuracy and skills.',
      'D. Assure them counting practice strengthens early math.',
    ],
    correctAnswer: 'A',
    explanation: 'A addresses focus and recognition. B misses engagement, C is partial, D is too broad.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'Parent Says: “My child knows numbers. Why practice addition?”',
    options: [
      'A. Clarify that addition builds a stronger math base.',
      'B. Explain that addition practice ensures full early mastery.',
      'C. Note that progressing to addition develops confidence.',
      'D. Assure them addition solidifies number foundations.',
    ],
    correctAnswer: 'B',
    explanation: 'B emphasizes mastery. A is general, C focuses on confidence, D lacks specificity.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'Parent Says: “My child struggles with addition facts.”',
    options: [
      'A. Suggest practicing addition with guidance at home.',
      'B. Recommend using worksheets to improve addition skills.',
      'C. Offer to model solving during sessions.',
      'D. Advise focusing on slow solving with support.',
    ],
    correctAnswer: 'C',
    explanation: 'C provides direct support. A shifts to parents, B is passive, D lacks structure.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'Parent Says: “Why does my child count aloud so much?”',
    options: [
      'A. Explain that counting aloud builds verbal math skills.',
      'B. Note that speaking enhances memory and accuracy.',
      'C. Assure them counting aloud reinforces number recall.',
      'D. Suggest that verbal counting strengthens habits.',
    ],
    correctAnswer: 'A',
    explanation: 'A links to verbal skills. B is secondary, C is vague, D is repetitive.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'Parent Says: “My child makes mistakes when tired.”',
    options: [
      'A. Recommend a break before resuming with guidance.',
      'B. Suggest continuing with fewer problems to finish.',
      'C. Advise observing and correcting later.',
      'D. Propose reducing the session length slightly.',
    ],
    correctAnswer: 'A',
    explanation: 'A addresses fatigue effectively. B lowers expectation, C delays help, D is temporary.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'A student adds numbers inaccurately due to counting issues. What’s the best first step?',
    options: [
      'A. Solve the problem with them, guiding counting.',
      'B. Demonstrate correct addition before they retry.',
      'C. Ask them to add without assistance.',
      'D. Provide a new addition list with help.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects counting directly. B is preparatory, C lacks support, D delays focus.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'A student hesitates writing number sequences. What’s your priority?',
    options: [
      'A. Model writing slowly, asking them to follow.',
      'B. Write with them, guiding each number.',
      'C. Encourage them to write with minimal help.',
      'D. Show a number chart for them to study.',
    ],
    correctAnswer: 'B',
    explanation: 'B combines support and practice. A is modeling-only, C lacks aid, D is passive.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'A student skips numbers while counting sequences. What should you do first?',
    options: [
      'A. Count the sequence with them, pointing to missed numbers.',
      'B. Let them retry and check their accuracy.',
      'C. Assign simpler sequences to rebuild.',
      'D. Observe and offer hints if they struggle.',
    ],
    correctAnswer: 'A',
    explanation: 'A ensures immediate correction. B delays help, C reduces challenge, D is indirect.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'A student struggles with addition facts up to 10. What’s your best action?',
    options: [
      'A. Solve the problems with them, guiding each step.',
      'B. Show an addition chart and guide their solving.',
      'C. Ask them to solve without assistance.',
      'D. Provide a new worksheet with addition problems.',
    ],
    correctAnswer: 'A',
    explanation: 'A offers direct guidance. B relies on tools, C lacks support, D is preparatory.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'A student loses focus solving a 10-sheet set. What’s your priority?',
    options: [
      'A. Redirect with a short counting game and praise.',
      'B. Continue solving with them, keeping focus.',
      'C. Suggest a break before resuming the task.',
      'D. Assign a new task to regain their interest.',
    ],
    correctAnswer: 'B',
    explanation: 'B maintains engagement. A is distracting, C delays, D shifts focus.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'Case Study: A 5-year-old student counts numbers but stops, looking confused. What’s the best way to help them progress?',
    options: [
      'A. Count to 10 with them, guiding each number.',
      'B. Show the numbers and ask them to count alone.',
      'C. Guide their counting to 10 with support.',
      'D. Provide a new sheet with numbers printed.',
    ],
    correctAnswer: 'C',
    explanation: 'C builds on their skill with guidance. A is gradual, B lacks aid, D adds complexity.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'Case Study: A student solves 1-5 addition problems correctly but stumbles at 6-10. How should you support their learning?',
    options: [
      'A. Solve 6-10 with them, guiding each problem.',
      'B. Point to 6-10 while they solve alone.',
      'C. Show a problem list and guide their solving.',
      'D. Let them try again without immediate help.',
    ],
    correctAnswer: 'A',
    explanation: 'A combines verbal and physical aid. B lacks guidance, C relies on tools, D lacks support.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'Case Study: A student makes errors in addition facts often. What’s your first step to correct this?',
    options: [
      'A. Solve the problems with them, correcting errors.',
      'B. Show an addition chart and ask them to resolve.',
      'C. Guide their calculation for each problem.',
      'D. Assign a new task focusing on addition facts.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects with real-time guidance. B is passive, C is general, D delays focus.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'Case Study: A student hesitates during number sequence writing, looking at peers. What should you do to build confidence?',
    options: [
      'A. Write with them, offering praise.',
      'B. Encourage them to watch peers, then try.',
      'C. Demonstrate writing, asking them to follow.',
      'D. Suggest they write silently to reduce pressure.',
    ],
    correctAnswer: 'A',
    explanation: 'A boosts confidence with support. B increases comparison, C shifts focus, D avoids practice.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'Case Study: A student struggles with solving a 10-sheet set. What additional steps would you take?',
    options: [
      'A. Practice solving with guidance daily.',
      'B. Use number cards for extra counting drills.',
      'C. Model solving, then guide their practice.',
      'D. Assign more worksheets with problem lists.',
    ],
    correctAnswer: 'A', // Choosing A as primary for daily guidance emphasis
    explanation: 'A and C reinforce solving with guidance, but A is prioritized for consistent practice. B is tool-dependent, D is repetitive.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'What is the main goal of addition in Level 2A?',
    options: [
      'A. Build fluency in addition facts up to 10.',
      'B. Teach students to recognize numbers quickly.',
      'C. Help students memorize number sequences.',
      'D. Ensure students add without errors daily.',
    ],
    correctAnswer: 'A',
    explanation: 'A focuses on fluency. B is secondary, C is memorization, D is unrealistic.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'Why does Kumon emphasize guidance during addition?',
    options: [
      'A. It helps students understand correct calculation.',
      'B. It speeds up addition practice.',
      'C. It reduces the need for verbal instructions.',
      'D. It ensures students memorize number facts.',
    ],
    correctAnswer: 'A',
    explanation: 'A enhances calculation. B overstates speed, C minimizes teaching, D is incidental.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'When should a student move from counting to addition?',
    options: [
      'A. After consistent accuracy with counting sequences.',
      'B. When they can count without help.',
      'C. Once they master addition fully.',
      'D. After recognizing all numbers.',
    ],
    correctAnswer: 'A',
    explanation: 'A ensures readiness. B lacks progression, C is premature, D skips addition.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'What is the purpose of the 10-sheet structure in early levels?',
    options: [
      'A. Develop skills for addition and counting.',
      'B. Teach students to write numbers correctly.',
      'C. Help students count numbers quickly.',
      'D. Ensure mastery of number lists.',
    ],
    correctAnswer: 'A',
    explanation: 'A targets addition and counting. B is writing-focused, C is unrelated, D is broader.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'How should instructors handle a student skipping numbers?',
    options: [
      'A. Count with them, pointing to missed numbers.',
      'B. Let them self-correct on the next attempt.',
      'C. Assign easier sequences to rebuild skills.',
      'D. None of the above.',
    ],
    correctAnswer: 'D',
    explanation: 'D applies; immediate correction is needed, not self-correction or easing.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'What role does repetition play in Level 2A?',
    options: [
      'A. Reinforces addition accuracy and confidence.',
      'B. Helps students finish worksheets faster.',
      'C. Ensures they memorize numbers quickly.',
      'D. Reduces the need for instructor guidance.',
    ],
    correctAnswer: 'A',
    explanation: 'A builds skills. B focuses on speed, C is memorization, D is incorrect.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'According to Level 2A, how should instructors introduce addition facts?',
    options: [
      'A. Start with 1-5 problems, then add more with guidance.',
      'B. Begin with 10 problems, reducing if needed.',
      'C. Teach all problems at once with a chart.',
      'D. Solve silently, showing problems later.',
    ],
    correctAnswer: 'A',
    explanation: 'A follows the manual’s progression. B reverses order, C overwhelms, D skips verbal.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'What does the manual suggest for students struggling with addition?',
    options: [
      'A. Solve with them to guide the process.',
      'B. Let them observe peers before retrying.',
      'C. Provide a new sheet without assistance.',
      'D. Skip to counting exercises.',
    ],
    correctAnswer: 'A',
    explanation: 'A aligns with guidance. B delays, C lacks support, D shifts focus.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'How should instructors use the 10-sheet structure?',
    options: [
      'A. Guide solving with support for the full set.',
      'B. Teach students to guess problems quickly.',
      'C. Focus on writing after solving.',
      'D. Allow self-correction without help.',
    ],
    correctAnswer: 'A',
    explanation: 'A matches the manual. B avoids accuracy, C is premature, D lacks support.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'What is the aim of the counting sequence exercise per the manual?',
    options: [
      'A. Build initial number recognition skills with support.',
      'B. Ensure students memorize all sequences.',
      'C. Teach fast counting without guidance.',
      'D. Prepare for immediate addition facts.',
    ],
    correctAnswer: 'A',
    explanation: 'A reflects the goal. B is memorization, C skips support, D is unrelated.',
    level: QuestionLevel.level2a,
  ),
  Question(
    text: 'According to the manual, when can students solve 10 addition problems smoothly?',
    options: [
      'A. After mastering solving the 10-sheet set accurately.',
      'B. When they finish all the sheets quickly.',
      'C. If they recognize numbers without help.',
      'D. After observing peers solve successfully.',
    ],
    correctAnswer: 'A',
    explanation: 'A ensures mastery. B focuses on speed, C skips practice, D relies on others.',
    level: QuestionLevel.level2a,
  ),
];

final List<Question> levelAQuestions = [
  Question(
    text: 'A student struggles to solve subtraction problems up to 100 (e.g., 85 - 37). What would you do?',
    options: [
      'A. Let them attempt without assistance.',
      'B. Solve the problem with them, guiding each step.',
      'C. Demonstrate solving, then have them follow.',
      'D. Show the problem and ask them to try again.',
    ],
    correctAnswer: 'B',
    explanation: 'B provides direct support. A lacks guidance, C shifts to modeling, D is passive.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'A student makes errors while solving word problems (e.g., "Tom has 45 apples, gives away 19. How many left?"). How should you respond?',
    options: [
      'A. Correct mistakes after they finish.',
      'B. Let them continue and review later.',
      'C. Solve the problem correctly, asking them to follow.',
      'D. Point out errors and guide their calculation.',
    ],
    correctAnswer: 'C',
    explanation: 'C corrects with immediate guidance. A delays, B avoids correction, D is verbal-only.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'A student finishes subtraction problems quickly but with mistakes. What would you do?',
    options: [
      'A. Observe and let them self-correct next time.',
      'B. Assign a new subtraction exercise with focus.',
      'C. Praise their speed and ask for accuracy.',
      'D. Review their work, guiding correct solutions.',
    ],
    correctAnswer: 'D',
    explanation: 'D addresses errors directly. A lacks support, B is preparatory, C reinforces speed.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'A student refuses to solve word problems in a group setting. What’s your best action?',
    options: [
      'A. Move to a one-on-one session for practice.',
      'B. Model solving aloud, inviting them to join.',
      'C. Pair them with a peer to solve together.',
      'D. Allow silent solving and check their work.',
    ],
    correctAnswer: 'B',
    explanation: 'B encourages participation gently. A over-adjusts, C adds pressure, D avoids group practice.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'A student struggles with addition up to 100, mixing up place values. What should you do?',
    options: [
      'A. Give simpler problems to build confidence.',
      'B. Ask them to retry without assistance.',
      'C. Show a place value chart and guide their solving.',
      'D. Solve the problem with them, correcting place values.',
    ],
    correctAnswer: 'D',
    explanation: 'D corrects with guidance. A lowers difficulty, B lacks support, C relies on tools.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'A student hesitates solving a subtraction problem on a worksheet. What would you do?',
    options: [
      'A. Let them solve it again without help.',
      'B. Demonstrate solving, asking them to copy.',
      'C. Provide a sample problem for them to study first.',
      'D. Solve the problem with them, guiding each step.',
    ],
    correctAnswer: 'D',
    explanation: 'D offers direct support. A lacks aid, B shifts to modeling, C delays practice.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'A student stops at problem 5 while solving 10 subtraction problems. What’s your approach?',
    options: [
      'A. Assign a task stopping at 5 to build skill.',
      'B. Show a problem list and ask them to continue.',
      'C. Encourage them past 5 with your guidance.',
      'D. Solve all 10 with them, emphasizing 5-10.',
    ],
    correctAnswer: 'C',
    explanation: 'C builds on their limit with support. A limits progress, B relies on tools, D over-directs.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'Parent Says: “My child solves the same subtraction problems daily. Is this necessary?”',
    options: [
      'A. Note that daily practice ensures quick number recall.',
      'B. Suggest that consistent solving prepares them for multiplication.',
      'C. Assure them repetition strengthens math habits over time.',
      'D. Explain that repetition builds subtraction accuracy and skill.',
    ],
    correctAnswer: 'D',
    explanation: 'D ties repetition to accuracy. A is vague, B shifts focus to multiplication, C lacks detail.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'Parent Says: “My child finds word problems boring.”',
    options: [
      'A. Assure them word problem practice strengthens early math.',
      'B. Note that problem practice develops analytical skills.',
      'C. Explain that repetition improves problem-solving and confidence.',
      'D. Highlight that word problems build focus and application.',
    ],
    correctAnswer: 'D',
    explanation: 'D addresses focus and application. A is too broad, B is partial, C misses engagement.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'Parent Says: “My child knows numbers. Why practice subtraction?”',
    options: [
      'A. Assure them that subtraction solidifies number foundations.',
      'B. Note that progressing to subtraction develops confidence.',
      'C. Explain that subtraction practice ensures full early mastery.',
      'D. Clarify that subtraction builds a stronger math base.',
    ],
    correctAnswer: 'C',
    explanation: 'C emphasizes mastery. A lacks specificity, B focuses on confidence, D is general.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'Parent Says: “My child struggles with subtraction up to 100.”',
    options: [
      'A. Advise focusing on slow solving with support.',
      'B. Recommend using worksheets to improve subtraction skills.',
      'C. Offer to model solving during sessions.',
      'D. Suggest practicing subtraction with guidance at home.',
    ],
    correctAnswer: 'C',
    explanation: 'C provides direct support. A lacks structure, B is passive, D shifts to parents.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'Parent Says: “Why does my child read word problems aloud so much?”',
    options: [
      'A. Suggest that verbal reading strengthens habits.',
      'B. Assure them reading aloud reinforces problem recall.',
      'C. Note that speaking enhances memory and understanding.',
      'D. Explain that reading aloud builds verbal math skills.',
    ],
    correctAnswer: 'D',
    explanation: 'D links to verbal skills. A is repetitive, B is vague, C is secondary.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'Parent Says: “My child makes mistakes when tired.”',
    options: [
      'A. Propose reducing the session length slightly.',
      'B. Advise observing and correcting later.',
      'C. Suggest continuing with fewer problems to finish.',
      'D. Recommend a break before resuming with guidance.',
    ],
    correctAnswer: 'D',
    explanation: 'D addresses fatigue effectively. A is temporary, B delays help, C lowers expectation.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'A student subtracts numbers inaccurately due to place value issues. What’s the best first step?',
    options: [
      'A. Provide a new subtraction list with help.',
      'B. Ask them to subtract without assistance.',
      'C. Demonstrate correct subtraction before they retry.',
      'D. Solve the problem with them, guiding place values.',
    ],
    correctAnswer: 'D',
    explanation: 'D corrects place values directly. A delays focus, B lacks support, C is preparatory.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'A student hesitates solving word problems. What’s your priority?',
    options: [
      'A. Show a problem chart for them to study.',
      'B. Encourage them to solve with minimal help.',
      'C. Solve with them, guiding each step.',
      'D. Model solving slowly, asking them to follow.',
    ],
    correctAnswer: 'C',
    explanation: 'C combines support and practice. A is passive, B lacks aid, D is modeling-only.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'A student skips steps while subtracting numbers. What should you do first?',
    options: [
      'A. Observe and offer hints if they struggle.',
      'B. Assign simpler problems to rebuild.',
      'C. Let them retry and check their accuracy.',
      'D. Solve the problem with them, pointing to missed steps.',
    ],
    correctAnswer: 'D',
    explanation: 'D ensures immediate correction. A is indirect, B reduces challenge, C delays help.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'A student struggles with number patterns. What’s your best action?',
    options: [
      'A. Provide a new worksheet with pattern exercises.',
      'B. Ask them to identify without assistance.',
      'C. Show a pattern chart and guide their solving.',
      'D. Identify the pattern with them, guiding each step.',
    ],
    correctAnswer: 'D',
    explanation: 'D offers direct guidance. A is preparatory, B lacks support, C relies on tools.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'A student loses focus solving a 10-sheet set. What’s your priority?',
    options: [
      'A. Assign a new task to regain their interest.',
      'B. Suggest a break before resuming the task.',
      'C. Continue solving with them, keeping focus.',
      'D. Redirect with a short math game and praise.',
    ],
    correctAnswer: 'C',
    explanation: 'C maintains engagement. A shifts focus, B delays, D is distracting.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'Case Study: A 6-year-old student solves addition but stops, looking confused. What’s the best way to help them progress?',
    options: [
      'A. Provide a new sheet with problems printed.',
      'B. Guide their solving to 10 with support.',
      'C. Show the problems and ask them to solve alone.',
      'D. Solve to 10 with them, guiding each step.',
    ],
    correctAnswer: 'B',
    explanation: 'B builds on their skill with guidance. A adds complexity, C lacks aid, D is gradual.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'Case Study: A student solves 1-5 subtraction problems correctly but stumbles at 6-10. How should you support their learning?',
    options: [
      'A. Let them try again without immediate help.',
      'B. Show a problem list and guide their solving.',
      'C. Point to 6-10 while they solve alone.',
      'D. Solve 6-10 with them, guiding each step.',
    ],
    correctAnswer: 'D',
    explanation: 'D combines verbal and physical aid. A lacks support, B relies on tools, C lacks guidance.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'Case Study: A student makes errors in word problems often. What’s your first step to correct this?',
    options: [
      'A. Assign a new task focusing on problem-solving.',
      'B. Guide their solving for each problem.',
      'C. Show a problem chart and ask them to resolve.',
      'D. Solve the problem with them, correcting errors.',
    ],
    correctAnswer: 'D',
    explanation: 'D corrects with real-time guidance. A delays focus, B is general, C is passive.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'Case Study: A student hesitates during number pattern solving, looking at peers. What should you do to build confidence?',
    options: [
      'A. Suggest they solve silently to reduce pressure.',
      'B. Demonstrate solving, asking them to follow.',
      'C. Encourage them to watch peers, then try.',
      'D. Solve with them, offering praise.',
    ],
    correctAnswer: 'D',
    explanation: 'D boosts confidence with support. A avoids practice, B shifts focus, C increases comparison.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'Case Study: A student struggles with solving a 10-sheet set. What additional steps would you take?',
    options: [
      'A. Assign more worksheets with problem lists.',
      'B. Model solving, then guide their practice.',
      'C. Use number cards for extra pattern drills.',
      'D. Practice solving with guidance daily.',
    ],
    correctAnswer: 'B & D',
    explanation: 'B and D reinforce solving with guidance. A is repetitive, C is tool-dependent.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'What is the main goal of subtraction in Level A?',
    options: [
      'A. Help students memorize number patterns.',
      'B. Teach students to recognize numbers quickly.',
      'C. Build fluency in subtraction up to 100.',
      'D. Ensure students subtract without errors daily.',
    ],
    correctAnswer: 'C',
    explanation: 'C focuses on fluency. A is memorization, B is secondary, D is unrealistic.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'Why does Kumon emphasize guidance during word problems?',
    options: [
      'A. It ensures students memorize problem types.',
      'B. It reduces the need for verbal instructions.',
      'C. It speeds up problem-solving practice.',
      'D. It helps students understand correct application.',
    ],
    correctAnswer: 'D',
    explanation: 'D enhances application. A is incidental, B minimizes teaching, C overstates speed.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'When should a student move from addition to subtraction?',
    options: [
      'A. After recognizing all numbers.',
      'B. Once they master subtraction fully.',
      'C. When they can add without help.',
      'D. After consistent accuracy with addition.',
    ],
    correctAnswer: 'D',
    explanation: 'D ensures readiness. A skips addition, B is premature, C lacks progression.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'What is the purpose of the 10-sheet structure in Level A?',
    options: [
      'A. Ensure mastery of number lists.',
      'B. Help students count numbers quickly.',
      'C. Teach students to write numbers correctly.',
      'D. Develop skills for addition and subtraction.',
    ],
    correctAnswer: 'D',
    explanation: 'D targets addition and subtraction. A is broader, B is unrelated, C is writing-focused.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'How should instructors handle a student skipping steps in subtraction?',
    options: [
      'A. Assign easier problems to rebuild skills.',
      'B. Let them self-correct on the next attempt.',
      'C. Solve with them, pointing to missed steps.',
      'D. None of the above.',
    ],
    correctAnswer: 'D',
    explanation: 'D applies; immediate correction is needed, not self-correction or easing.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'What role does repetition play in Level A?',
    options: [
      'A. Reduces the need for instructor guidance.',
      'B. Ensures they memorize problems quickly.',
      'C. Helps students finish worksheets faster.',
      'D. Reinforces subtraction accuracy and confidence.',
    ],
    correctAnswer: 'D',
    explanation: 'D builds skills. A is incorrect, B is memorization, C focuses on speed.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'According to Level A, how should instructors introduce subtraction problems?',
    options: [
      'A. Solve silently, showing problems later.',
      'B. Teach all problems at once with a chart.',
      'C. Begin with 10 problems, reducing if needed.',
      'D. Start with 1-5 problems, then add more with guidance.',
    ],
    correctAnswer: 'D',
    explanation: 'D follows the manual’s progression. A skips verbal, B overwhelms, C reverses order.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'What does the manual suggest for students struggling with subtraction?',
    options: [
      'A. Skip to addition exercises.',
      'B. Provide a new sheet without assistance.',
      'C. Let them observe peers before retrying.',
      'D. Solve with them to guide the process.',
    ],
    correctAnswer: 'D',
    explanation: 'D aligns with guidance. A shifts focus, B lacks support, C delays.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'How should instructors use the 10-sheet structure?',
    options: [
      'A. Allow self-correction without help.',
      'B. Focus on writing after solving.',
      'C. Teach students to guess problems quickly.',
      'D. Guide solving with support for the full set.',
    ],
    correctAnswer: 'D',
    explanation: 'D matches the manual. A lacks support, B is premature, C avoids accuracy.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'What is the aim of the number pattern exercise per the manual?',
    options: [
      'A. Prepare for immediate subtraction facts.',
      'B. Teach fast solving without guidance.',
      'C. Ensure students memorize all patterns.',
      'D. Build initial pattern recognition skills with support.',
    ],
    correctAnswer: 'D',
    explanation: 'D reflects the goal. A is unrelated, B skips support, C is memorization.',
    level: QuestionLevel.levelA,
  ),
  Question(
    text: 'According to the manual, when can students solve 10 subtraction problems smoothly?',
    options: [
      'A. After observing peers solve successfully.',
      'B. If they recognize numbers without help.',
      'C. When they finish all the sheets quickly.',
      'D. After mastering solving the 10-sheet set accurately.',
    ],
    correctAnswer: 'D',
    explanation: 'D ensures mastery. A relies on others, B skips practice, C focuses on speed.',
    level: QuestionLevel.levelA,
  ),
];

final List<Question> levelBQuestions = [
  Question(
    text: 'A student struggles to solve addition problems up to 200 (e.g., 145 + 38). What would you do?',
    options: [
      'A. Demonstrate solving, then have them follow.',
      'B. Show the problem and ask them to try again.',
      'C. Solve the problem with them, guiding each step.',
      'D. Let them attempt without assistance.',
    ],
    correctAnswer: 'C',
    explanation: 'C provides direct support. A shifts to modeling, B is passive, D lacks guidance.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'A student makes errors while subtracting larger numbers (e.g., 192 - 76 = 126). How should you respond?',
    options: [
      'A. Let them continue and review later.',
      'B. Correct mistakes after they finish.',
      'C. Point out errors and guide their calculation.',
      'D. Solve the problem correctly, asking them to follow.',
    ],
    correctAnswer: 'D',
    explanation: 'D corrects with immediate guidance. A avoids correction, B delays, C is verbal-only.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'A student finishes word problems quickly but with mistakes. What would you do?',
    options: [
      'A. Praise their speed and ask for accuracy.',
      'B. Review their work, guiding correct solutions.',
      'C. Observe and let them self-correct next time.',
      'D. Assign a new word problem exercise with focus.',
    ],
    correctAnswer: 'B',
    explanation: 'B addresses errors directly. A reinforces speed, C lacks support, D is preparatory.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'A student refuses to solve multiplication problems in a group setting. What’s your best action?',
    options: [
      'A. Pair them with a peer to solve together.',
      'B. Allow silent solving and check their work.',
      'C. Move to a one-on-one session for practice.',
      'D. Model solving aloud, inviting them to join.',
    ],
    correctAnswer: 'D',
    explanation: 'D encourages participation gently. A adds pressure, B avoids group practice, C over-adjusts.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'A student struggles with subtraction up to 200, mixing up borrowing. What should you do?',
    options: [
      'A. Solve the problem with them, correcting borrowing.',
      'B. Give simpler problems to build confidence.',
      'C. Show a place value chart and guide their solving.',
      'D. Ask them to retry without assistance.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects with guidance. B lowers difficulty, C relies on tools, D lacks support.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'A student hesitates solving a multiplication problem on a worksheet. What would you do?',
    options: [
      'A. Provide a sample problem for them to study first.',
      'B. Solve the problem with them, guiding each step.',
      'C. Let them solve again without help.',
      'D. Demonstrate solving, asking them to copy.',
    ],
    correctAnswer: 'B',
    explanation: 'B offers direct support. A delays practice, C lacks aid, D shifts to modeling.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'A student stops at problem 5 while solving 10 word problems. What’s your approach?',
    options: [
      'A. Solve all 10 with them, emphasizing 5-10.',
      'B. Show a problem list and ask them to continue.',
      'C. Assign a task stopping at 5 to build skill.',
      'D. Encourage them past 5 with your guidance.',
    ],
    correctAnswer: 'D',
    explanation: 'D builds on their limit with support. A over-directs, B relies on tools, C limits progress.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'Parent Says: “My child solves the same problems daily. Is this necessary?”',
    options: [
      'A. Assure them repetition strengthens math habits over time.',
      'B. Explain that repetition builds accuracy and skill with larger numbers.',
      'C. Suggest that consistent solving prepares them for division.',
      'D. Note that daily practice ensures quick number recall.',
    ],
    correctAnswer: 'B',
    explanation: 'B ties repetition to accuracy with larger numbers. A lacks detail, C shifts focus to division, D is vague.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'Parent Says: “My child finds multiplication boring.”',
    options: [
      'A. Note that multiplication practice develops analytical skills.',
      'B. Highlight that multiplication builds focus and understanding.',
      'C. Assure them multiplication practice strengthens early math.',
      'D. Explain that repetition improves multiplication and confidence.',
    ],
    correctAnswer: 'B',
    explanation: 'B addresses focus and understanding. A is partial, C is too broad, D misses engagement.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'Parent Says: “My child knows subtraction. Why practice word problems?”',
    options: [
      'A. Note that progressing to word problems develops confidence.',
      'B. Clarify that word problems build a stronger math base.',
      'C. Assure them word problems solidify subtraction foundations.',
      'D. Explain that word problems ensure full early mastery.',
    ],
    correctAnswer: 'D',
    explanation: 'D emphasizes mastery. A focuses on confidence, B is general, C lacks specificity.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'Parent Says: “My child struggles with multiplication concepts.”',
    options: [
      'A. Suggest practicing multiplication with guidance at home.',
      'B. Offer to model solving during sessions.',
      'C. Recommend using worksheets to improve multiplication skills.',
      'D. Advise focusing on slow solving with support.',
    ],
    correctAnswer: 'B',
    explanation: 'B provides direct support. A shifts to parents, C is passive, D lacks structure.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'Parent Says: “Why does my child read word problems aloud so much?”',
    options: [
      'A. Note that speaking enhances memory and understanding.',
      'B. Explain that reading aloud builds verbal math skills.',
      'C. Suggest that verbal reading strengthens habits.',
      'D. Assure them reading aloud reinforces problem recall.',
    ],
    correctAnswer: 'B',
    explanation: 'B links to verbal skills. A is secondary, C is repetitive, D is vague.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'Parent Says: “My child makes mistakes when tired.”',
    options: [
      'A. Suggest continuing with fewer problems to finish.',
      'B. Recommend a break before resuming with guidance.',
      'C. Propose reducing the session length slightly.',
      'D. Advise observing and correcting later.',
    ],
    correctAnswer: 'B',
    explanation: 'B addresses fatigue effectively. A lowers expectation, C is temporary, D delays help.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'A student subtracts larger numbers inaccurately due to borrowing issues. What’s the best first step?',
    options: [
      'A. Solve the problem with them, guiding borrowing.',
      'B. Provide a new subtraction list with help.',
      'C. Ask them to subtract without assistance.',
      'D. Demonstrate correct subtraction before they retry.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects borrowing directly. B delays focus, C lacks support, D is preparatory.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'A student hesitates solving multiplication problems. What’s your priority?',
    options: [
      'A. Model solving slowly, asking them to follow.',
      'B. Encourage them to solve with minimal help.',
      'C. Solve with them, guiding each step.',
      'D. Show a multiplication chart for them to study.',
    ],
    correctAnswer: 'C',
    explanation: 'C combines support and practice. A is modeling-only, B lacks aid, D is passive.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'A student skips steps while solving word problems. What should you do first?',
    options: [
      'A. Let them retry and check their accuracy.',
      'B. Solve the problem with them, pointing to missed steps.',
      'C. Assign simpler problems to rebuild.',
      'D. Observe and offer hints if they struggle.',
    ],
    correctAnswer: 'B',
    explanation: 'B ensures immediate correction. A delays help, C reduces challenge, D is indirect.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'A student struggles with subtraction up to 200. What’s your best action?',
    options: [
      'A. Ask them to subtract without assistance.',
      'B. Solve the problem with them, guiding each step.',
      'C. Provide a new worksheet with subtraction problems.',
      'D. Show a place value chart and guide their solving.',
    ],
    correctAnswer: 'B',
    explanation: 'B offers direct guidance. A lacks support, C is preparatory, D relies on tools.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'A student loses focus solving a 10-sheet set. What’s your priority?',
    options: [
      'A. Suggest a break before resuming the task.',
      'B. Redirect with a short math game and praise.',
      'C. Assign a new task to regain their interest.',
      'D. Continue solving with them, keeping focus.',
    ],
    correctAnswer: 'D',
    explanation: 'D maintains engagement. A delays, B is distracting, C shifts focus.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'Case Study: A 7-year-old student solves subtraction but stops, looking confused. What’s the best way to help them progress?',
    options: [
      'A. Show the problems and ask them to solve alone.',
      'B. Guide their solving to 10 with support.',
      'C. Provide a new sheet with problems printed.',
      'D. Solve to 10 with them, guiding each step.',
    ],
    correctAnswer: 'B',
    explanation: 'B builds on their skill with guidance. A lacks aid, C adds complexity, D is gradual.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'Case Study: A student solves 1-5 word problems correctly but stumbles at 6-10. How should you support their learning?',
    options: [
      'A. Solve 6-10 with them, guiding each step.',
      'B. Let them try again without immediate help.',
      'C. Show a problem list and guide their solving.',
      'D. Point to 6-10 while they solve alone.',
    ],
    correctAnswer: 'A',
    explanation: 'A combines verbal and physical aid. B lacks support, C relies on tools, D lacks guidance.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'Case Study: A student makes errors in multiplication problems often. What’s your first step to correct this?',
    options: [
      'A. Show a multiplication chart and ask them to resolve.',
      'B. Solve the problem with them, correcting errors.',
      'C. Assign a new task focusing on multiplication.',
      'D. Guide their solving for each problem.',
    ],
    correctAnswer: 'B',
    explanation: 'B corrects with real-time guidance. A is passive, C delays focus, D is general.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'Case Study: A student hesitates during word problem solving, looking at peers. What should you do to build confidence?',
    options: [
      'A. Encourage them to watch peers, then try.',
      'B. Solve with them, offering praise.',
      'C. Suggest they solve silently to reduce pressure.',
      'D. Demonstrate solving, asking them to follow.',
    ],
    correctAnswer: 'B',
    explanation: 'B boosts confidence with support. A increases comparison, C avoids practice, D shifts focus.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'What is the main goal of multiplication in Level B?',
    options: [
      'A. Ensure students multiply without errors daily.',
      'B. Build understanding of multiplication as repeated addition.',
      'C. Teach students to recognize numbers quickly.',
      'D. Help students memorize multiplication tables.',
    ],
    correctAnswer: 'B',
    explanation: 'B focuses on understanding. A is unrealistic, C is secondary, D is memorization.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'Why does Kumon emphasize guidance during subtraction with larger numbers?',
    options: [
      'A. It speeds up subtraction practice.',
      'B. It helps students understand correct borrowing.',
      'C. It ensures students memorize number facts.',
      'D. It reduces the need for verbal instructions.',
    ],
    correctAnswer: 'B',
    explanation: 'B enhances borrowing. A overstates speed, C is incidental, D minimizes teaching.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'When should a student move from subtraction to multiplication?',
    options: [
      'A. After consistent accuracy with subtraction up to 200.',
      'B. When they can subtract without help.',
      'C. Once they master multiplication fully.',
      'D. After recognizing all larger numbers.',
    ],
    correctAnswer: 'A',
    explanation: 'A ensures readiness. B lacks progression, C is premature, D skips subtraction.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'What is the purpose of the 10-sheet structure in Level B?',
    options: [
      'A. Teach students to write numbers correctly.',
      'B. Help students count numbers quickly.',
      'C. Develop skills for subtraction and multiplication.',
      'D. Ensure mastery of number lists.',
    ],
    correctAnswer: 'C',
    explanation: 'C targets subtraction and multiplication. A is writing-focused, B is unrelated, D is broader.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'How should instructors handle a student skipping steps in word problems?',
    options: [
      'A. Let them self-correct on the next attempt.',
      'B. Solve with them, pointing to missed steps.',
      'C. Assign easier problems to rebuild skills.',
      'D. None of the above.',
    ],
    correctAnswer: 'D',
    explanation: 'D applies; immediate correction is needed, not self-correction or easing.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'What role does repetition play in Level B?',
    options: [
      'A. Ensures they memorize problems quickly.',
      'B. Reinforces accuracy and confidence with larger numbers.',
      'C. Helps students finish worksheets faster.',
      'D. Reduces the need for instructor guidance.',
    ],
    correctAnswer: 'B',
    explanation: 'B builds skills. A is memorization, C focuses on speed, D is incorrect.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'According to Level B, how should instructors introduce multiplication problems?',
    options: [
      'A. Teach all problems at once with a chart.',
      'B. Start with 1-5 problems, then add more with guidance.',
      'C. Solve silently, showing problems later.',
      'D. Begin with 10 problems, reducing if needed.',
    ],
    correctAnswer: 'B',
    explanation: 'B follows the manual’s progression. A overwhelms, C skips verbal, D reverses order.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'What does the manual suggest for students struggling with word problems?',
    options: [
      'A. Let them observe peers before retrying.',
      'B. Skip to subtraction exercises.',
      'C. Solve with them to guide the process.',
      'D. Provide a new sheet without assistance.',
    ],
    correctAnswer: 'C',
    explanation: 'C aligns with guidance. A delays, B shifts focus, D lacks support.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'How should instructors use the 10-sheet structure?',
    options: [
      'A. Teach students to guess problems quickly.',
      'B. Guide solving with support for the full set.',
      'C. Allow self-correction without help.',
      'D. Focus on writing after solving.',
    ],
    correctAnswer: 'B',
    explanation: 'B matches the manual. A avoids accuracy, C lacks support, D is premature.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'What is the aim of the multiplication exercise per the manual?',
    options: [
      'A. Teach fast solving without guidance.',
      'B. Build initial understanding of repeated addition with support.',
      'C. Ensure students memorize all tables.',
      'D. Prepare for immediate division facts.',
    ],
    correctAnswer: 'B',
    explanation: 'B reflects the goal. A skips support, C is memorization, D is unrelated.',
    level: QuestionLevel.levelB,
  ),
  Question(
    text: 'According to the manual, when can students solve 10 word problems smoothly?',
    options: [
      'A. When they finish all sheets quickly.',
      'B. After mastering solving the 10-sheet set accurately.',
      'C. If they recognize numbers without help.',
      'D. After observing peers solve successfully.',
    ],
    correctAnswer: 'B',
    explanation: 'B ensures mastery. A focuses on speed, C skips practice, D relies on others.',
    level: QuestionLevel.levelB,
  ),
];

final List<Question> levelCQuestions = [
  Question(
    text: 'A student struggles to solve multiplication facts up to 12 (e.g., 7 × 8). What would you do?',
    options: [
      'A. Demonstrate solving, then have them follow.',
      'B. Solve the problem with them, guiding each step.',
      'C. Show the problem and ask them to try again.',
      'D. Let them attempt without assistance.',
    ],
    correctAnswer: 'B',
    explanation: 'B provides direct support. A shifts to modeling, C is passive, D lacks guidance.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'A student makes errors while adding numbers up to 1,000 (e.g., 674 + 289 = 953). How should you respond?',
    options: [
      'A. Point out errors and guide their calculation.',
      'B. Solve the problem correctly, asking them to follow.',
      'C. Let them continue and review later.',
      'D. Correct mistakes after they finish.',
    ],
    correctAnswer: 'B',
    explanation: 'B corrects with immediate guidance. A is verbal-only, C avoids correction, D delays.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'A student finishes multi-step word problems quickly but with mistakes. What would you do?',
    options: [
      'A. Observe and let them self-correct next time.',
      'B. Assign a new word problem exercise with focus.',
      'C. Review their work, guiding correct solutions.',
      'D. Praise their speed and ask for accuracy.',
    ],
    correctAnswer: 'C',
    explanation: 'C addresses errors directly. A lacks support, B is preparatory, D reinforces speed.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'A student refuses to solve division problems in a group setting. What’s your best action?',
    options: [
      'A. Model solving aloud, inviting them to join.',
      'B. Move to a one-on-one session for practice.',
      'C. Allow silent solving and check their work.',
      'D. Pair them with a peer to solve together.',
    ],
    correctAnswer: 'A',
    explanation: 'A encourages participation gently. B over-adjusts, C avoids group practice, D adds pressure.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'A student struggles with subtraction up to 1,000, mixing up borrowing. What should you do?',
    options: [
      'A. Show a place value chart and guide their solving.',
      'B. Ask them to retry without assistance.',
      'C. Solve the problem with them, correcting borrowing.',
      'D. Give simpler problems to build confidence.',
    ],
    correctAnswer: 'C',
    explanation: 'C corrects with guidance. A relies on tools, B lacks support, D lowers difficulty.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'A student hesitates solving a multi-step word problem on a worksheet. What would you do?',
    options: [
      'A. Demonstrate solving, asking them to copy.',
      'B. Let them solve it again without help.',
      'C. Solve the problem with them, guiding each step.',
      'D. Provide a sample problem for them to study first.',
    ],
    correctAnswer: 'C',
    explanation: 'C offers direct support. A shifts to modeling, B lacks aid, D delays practice.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'A student stops at problem 5 while solving 10 multiplication problems. What’s your approach?',
    options: [
      'A. Show a problem list and ask them to continue.',
      'B. Encourage them past 5 with your guidance.',
      'C. Solve all 10 with them, emphasizing 5-10.',
      'D. Assign a task stopping at 5 to build skill.',
    ],
    correctAnswer: 'B',
    explanation: 'B builds on their limit with support. A relies on tools, C over-directs, D limits progress.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'Parent Says: “My child solves the same problems daily. Is this necessary?”',
    options: [
      'A. Note that daily practice ensures quick recall.',
      'B. Assure them repetition strengthens math habits over time.',
      'C. Explain that repetition builds accuracy with multiplication and division.',
      'D. Suggest that consistent solving prepares them for fractions.',
    ],
    correctAnswer: 'C',
    explanation: 'C ties repetition to accuracy with multiplication and division. A is vague, B lacks detail, D shifts focus to fractions.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'Parent Says: “My child finds division boring.”',
    options: [
      'A. Explain that repetition improves division and confidence.',
      'B. Highlight that division builds focus and problem-solving skills.',
      'C. Note that division practice develops analytical skills.',
      'D. Assure them division practice strengthens early math.',
    ],
    correctAnswer: 'B',
    explanation: 'B addresses focus and problem-solving. A misses engagement, C is partial, D is too broad.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'Parent Says: “My child knows multiplication. Why practice word problems?”',
    options: [
      'A. Explain that word problems ensure full early mastery.',
      'B. Assure them word problems solidify multiplication foundations.',
      'C. Note that progressing to word problems develops confidence.',
      'D. Clarify that word problems build a stronger math base.',
    ],
    correctAnswer: 'A',
    explanation: 'A emphasizes mastery. B lacks specificity, C focuses on confidence, D is general.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'Parent Says: “My child struggles with multi-step word problems.”',
    options: [
      'A. Recommend using worksheets to improve problem-solving skills.',
      'B. Advise focusing on slow solving with support.',
      'C. Suggest practicing word problems with guidance at home.',
      'D. Offer to model solving during sessions.',
    ],
    correctAnswer: 'D',
    explanation: 'D provides direct support. A is passive, B lacks structure, C shifts to parents.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'Parent Says: “Why does my child read word problems aloud so much?”',
    options: [
      'A. Assure them reading aloud reinforces problem recall.',
      'B. Suggest that verbal reading strengthens habits.',
      'C. Explain that reading aloud builds verbal math skills.',
      'D. Note that speaking enhances memory and understanding.',
    ],
    correctAnswer: 'C',
    explanation: 'C links to verbal skills. A is vague, B is repetitive, D is secondary.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'Parent Says: “My child makes mistakes when tired.”',
    options: [
      'A. Advise observing and correcting later.',
      'B. Propose reducing the session length slightly.',
      'C. Recommend a break before resuming with guidance.',
      'D. Suggest continuing with fewer problems to finish.',
    ],
    correctAnswer: 'C',
    explanation: 'C addresses fatigue effectively. A delays help, B is temporary, D lowers expectation.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'A student divides numbers inaccurately due to misunderstanding remainders. What’s the best first step?',
    options: [
      'A. Demonstrate correct division before they retry.',
      'B. Solve the problem with them, guiding remainders.',
      'C. Provide a new division list with help.',
      'D. Ask them to divide without assistance.',
    ],
    correctAnswer: 'B',
    explanation: 'B corrects remainders directly. A is preparatory, C delays focus, D lacks support.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'A student hesitates solving multi-step word problems. What’s your priority?',
    options: [
      'A. Show a problem chart for them to study.',
      'B. Model solving slowly, asking them to follow.',
      'C. Encourage them to solve problems with minimal help.',
      'D. Solve with them, guiding each step.',
    ],
    correctAnswer: 'D',
    explanation: 'D combines support and practice. A is passive, B is modeling-only, C lacks aid.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'A student skips steps while subtracting numbers up to 1,000. What should you do first?',
    options: [
      'A. Observe and offer hints if they struggle.',
      'B. Assign simpler problems to rebuild.',
      'C. Solve the problem with them, pointing to missed steps.',
      'D. Let them retry and check their accuracy.',
    ],
    correctAnswer: 'C',
    explanation: 'C ensures immediate correction. A is indirect, B reduces challenge, D delays help.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'A student struggles with multiplication facts up to 12. What’s your best action?',
    options: [
      'A. Show a multiplication chart and guide their solving.',
      'B. Provide a new worksheet with multiplication problems.',
      'C. Solve the problem with them, guiding each step.',
      'D. Ask them to multiply without assistance.',
    ],
    correctAnswer: 'C',
    explanation: 'C offers direct guidance. A relies on tools, B is preparatory, D lacks support.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'A student loses focus solving a 10-sheet set. What’s your priority?',
    options: [
      'A. Continue solving with them, keeping focus.',
      'B. Assign a new task to regain their interest.',
      'C. Suggest a break before resuming the task.',
      'D. Redirect with a short math game and praise.',
    ],
    correctAnswer: 'A',
    explanation: 'A maintains engagement. B shifts focus, C delays, D is distracting.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'Case Study: A 7-year-old student solves multiplication but stops, looking confused. What’s the best way to help them progress?',
    options: [
      'A. Solve to 10 with them, guiding each step.',
      'B. Guide their solving to 10 with support.',
      'C. Show the problems and ask them to solve alone.',
      'D. Provide a new sheet with problems printed.',
    ],
    correctAnswer: 'B',
    explanation: 'B builds on their skill with guidance. A is gradual, C lacks aid, D adds complexity.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'Case Study: A student solves 1-5 division problems correctly but stumbles at 6-10. How should you support their learning?',
    options: [
      'A. Point to 6-10 while they solve alone.',
      'B. Show a problem list and guide their solving.',
      'C. Solve 6-10 with them, guiding each step.',
      'D. Let them try again without immediate help.',
    ],
    correctAnswer: 'C',
    explanation: 'C combines verbal and physical aid. A lacks guidance, B relies on tools, D lacks support.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'Case Study: A student makes errors in multi-step word problems often. What’s your first step to correct this?',
    options: [
      'A. Guide their solving for each problem.',
      'B. Solve the problem with them, correcting errors.',
      'C. Show a problem chart and ask them to resolve it.',
      'D. Assign a new task focusing on problem-solving.',
    ],
    correctAnswer: 'B',
    explanation: 'B corrects with real-time guidance. A is general, C is passive, D delays focus.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'Case Study: A student hesitates during division problem solving, looking at peers. What should you do to build confidence?',
    options: [
      'A. Demonstrate solving, asking them to follow.',
      'B. Suggest they solve silently to reduce pressure.',
      'C. Solve with them, offering praise.',
      'D. Encourage them to watch peers, then try.',
    ],
    correctAnswer: 'C',
    explanation: 'C boosts confidence with support. A shifts focus, B avoids practice, D increases comparison.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'What is the main goal of division in Level C?',
    options: [
      'A. Teach students to recognize numbers quickly.',
      'B. Build fluency in division facts up to 12.',
      'C. Help students memorize division tables.',
      'D. Ensure students divide without errors daily.',
    ],
    correctAnswer: 'B',
    explanation: 'B focuses on fluency. A is secondary, C is memorization, D is unrealistic.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'Why does Kumon emphasize guidance during multi-step word problems?',
    options: [
      'A. It reduces the need for verbal instructions.',
      'B. It helps students understand correct problem-solving steps.',
      'C. It ensures students memorize problem types.',
      'D. It speeds up problem-solving practice.',
    ],
    correctAnswer: 'B',
    explanation: 'B enhances problem-solving. A minimizes teaching, C is incidental, D overstates speed.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'When should a student move from multiplication to division?',
    options: [
      'A. After consistent accuracy with multiplication facts.',
      'B. After recognizing all larger numbers.',
      'C. Once they master division fully.',
      'D. When they can multiply without help.',
    ],
    correctAnswer: 'A',
    explanation: 'A ensures readiness. B skips multiplication, C is premature, D lacks progression.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'What is the purpose of the 10-sheet structure in Level C?',
    options: [
      'A. Ensure mastery of number lists.',
      'B. Develop skills for multiplication and division.',
      'C. Teach students to write numbers correctly.',
      'D. Help students count numbers quickly.',
    ],
    correctAnswer: 'B',
    explanation: 'B targets multiplication and division. A is broader, C is writing-focused, D is unrelated.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'How should instructors handle a student skipping steps in division?',
    options: [
      'A. Let them self-correct on the next attempt.',
      'B. Solve with them, pointing to missed steps.',
      'C. Assign easier problems to rebuild skills.',
      'D. None of the above.',
    ],
    correctAnswer: 'D',
    explanation: 'D applies; immediate correction is needed, not self-correction or easing.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'What role does repetition play in Level C?',
    options: [
      'A. Reduces the need for instructor guidance.',
      'B. Helps students finish worksheets faster.',
      'C. Reinforces accuracy and confidence with multiplication and division.',
      'D. Ensures they memorize problems quickly.',
    ],
    correctAnswer: 'C',
    explanation: 'C builds skills. A is incorrect, B focuses on speed, D is memorization.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'According to Level C, how should instructors introduce division problems?',
    options: [
      'A. Solve silently, showing problems later.',
      'B. Begin with 10 problems, reducing if needed.',
      'C. Teach all problems at once with a chart.',
      'D. Start with 1-5 problems, then add more with guidance.',
    ],
    correctAnswer: 'D',
    explanation: 'D follows the manual’s progression. A skips verbal, B reverses order, C overwhelms.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'What does the manual suggest for students struggling with division?',
    options: [
      'A. Provide a new sheet without assistance.',
      'B. Solve with them to guide the process.',
      'C. Skip to multiplication exercises.',
      'D. Let them observe peers before retrying.',
    ],
    correctAnswer: 'B',
    explanation: 'B aligns with guidance. A lacks support, C shifts focus, D delays.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'How should instructors use the 10-sheet structure?',
    options: [
      'A. Allow self-correction without help.',
      'B. Teach students to guess problems quickly.',
      'C. Guide solving with support for the full set.',
      'D. Focus on writing after solving.',
    ],
    correctAnswer: 'C',
    explanation: 'C matches the manual. A lacks support, B avoids accuracy, D is premature.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'What is the aim of the multiplication exercise per the manual?',
    options: [
      'A. Ensure students memorize all tables.',
      'B. Teach fast solving without guidance.',
      'C. Build fluency in multiplication facts with support.',
      'D. Prepare for immediate fraction facts.',
    ],
    correctAnswer: 'C',
    explanation: 'C reflects the goal. A is memorization, B skips support, D is unrelated.',
    level: QuestionLevel.levelC,
  ),
  Question(
    text: 'According to the manual, when can students solve 10 word problems smoothly?',
    options: [
      'A. After observing peers solve successfully.',
      'B. When they finish all the sheets quickly.',
      'C. After mastering solving the 10-sheet set accurately.',
      'D. If they recognize numbers without help.',
    ],
    correctAnswer: 'C',
    explanation: 'C ensures mastery. A relies on others, B focuses on speed, D skips practice.',
    level: QuestionLevel.levelC,
  ),
];

final List<Question> englevel7aQuestions = [
  Question(
    text: 'A student struggles to repeat familiar words aloud. What would you do?',
    options: [
      'A. Repeat the words with them, pointing to each.',
      'B. Show the words and ask them to try again.',
      'C. Model the words, then have them follow.',
      'D. Let them attempt silently without help.',
    ],
    correctAnswer: 'A',
    explanation: 'A provides direct support with pointing. B is passive, C shifts to modeling, D lacks verbal practice.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'A student mispronounces vocabulary during repetition. How should you respond?',
    options: [
      'A. Repeat the words correctly, asking them to echo.',
      'B. Point out errors and guide their pronunciation.',
      'C. Correct mistakes after they finish.',
      'D. Let them continue and review later.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects with immediate guidance. B is verbal only, C delays, D avoids correction.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'A student finishes repeating quickly but skips words. What would you do?',
    options: [
      'A. Review their repetition, guiding missed words.',
      'B. Praise their speed and ask for accuracy.',
      'C. Assign a new vocabulary exercise with focus.',
      'D. Observe and let them self correct next time.',
    ],
    correctAnswer: 'A',
    explanation: 'A addresses skips directly. B reinforces speed, C is preparatory, D lacks support.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'A student refuses to repeat in a group setting. What’s your best action?',
    options: [
      'A. Allow silent repetition and check their understanding.',
      'B. Pair them with a peer to repeat together.',
      'C. Model repeating aloud, inviting them to join.',
      'D. Move to a one on one session for practice.',
    ],
    correctAnswer: 'C',
    explanation: 'C encourages participation gently. A avoids group practice, B adds pressure, D overadjusts.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'A student struggles with repeating a 10sheet set, mixing word order. What should you do?',
    options: [
      'A. Repeat the set with them, correcting order.',
      'B. Show a word chart and guide their repetition.',
      'C. Ask them to retry without assistance.',
      'D. Give simpler expressions to build confidence.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects with guidance. B relies on tools, C lacks support, D lowers difficulty.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'A student hesitates repeating vocabulary on a worksheet. What would you do?',
    options: [
      'A. Repeat the words with them, guiding pronunciation.',
      'B. Provide a word list for them to study first.',
      'C. Demonstrate the words, asking them to copy.',
      'D. Let them repeat again without help.',
    ],
    correctAnswer: 'A',
    explanation: 'A offers direct support. B delays practice, C shifts to modeling, D lacks aid.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'A student stops at word 50 while repeating 100 words. What’s your approach?',
    options: [
      'A. Repeat all 100 with them, emphasizing 50100.',
      'B. Encourage them past 50 with your guidance.',
      'C. Show a word list and ask them to continue.',
      'D. Assign a task stopping at 50 to build skill.',
    ],
    correctAnswer: 'B',
    explanation: 'B builds on their limit with support. A overdirects, C relies on tools, D limits progress.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'Parent Says: “My child repeats the same words daily. Is this necessary?”',
    options: [
      'A. Explain that repetition builds pronunciation and recall.',
      'B. Note that daily practice ensures strong word recognition.',
      'C. Assure them repetition strengthens language skills over time.',
      'D. Suggest that consistent repetition prepares them for expressions.',
    ],
    correctAnswer: 'A',
    explanation: 'A ties repetition to pronunciation. B is vague, C lacks detail, D shifts focus to expressions.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'Parent Says: “My child finds repeating expressions boring.”',
    options: [
      'A. Highlight that repeating builds focus and language fluency.',
      'B. Explain that repetition improves repetition and confidence.',
      'C. Note that expression practice develops accuracy and skills.',
      'D. Assure them repeating practice strengthens early English.',
    ],
    correctAnswer: 'A',
    explanation: 'A addresses focus and fluency. B misses engagement, C is partial, D is too broad.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'Parent Says: “My child knows 50 words. Why repeat 100?”',
    options: [
      'A. Clarify that repeating 100 builds a stronger vocabulary base.',
      'B. Explain that repeating 100 ensures full early mastery.',
      'C. Note that progressing to 100 develops confidence.',
      'D. Assure them 100 repetitions solidify word foundations.',
    ],
    correctAnswer: 'B',
    explanation: 'B emphasizes mastery. A is general, C focuses on confidence, D lacks specificity.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'Parent Says: “My child struggles with repeating expressions.”',
    options: [
      'A. Suggest practicing repetition with guidance at home.',
      'B. Recommend using worksheets to improve repetition skills.',
      'C. Offer to model repeating during sessions.',
      'D. Advise focusing on slow repetition with support.',
    ],
    correctAnswer: 'C',
    explanation: 'C provides direct support. A shifts to parents, B is passive, D lacks structure.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'Parent Says: “Why does my child repeat aloud so much?”',
    options: [
      'A. Explain that repeating aloud builds verbal language skills.',
      'B. Note that speaking enhances memory and fluency.',
      'C. Assuring them repeating aloud reinforces word recall.',
      'D. Suggest that verbal repetition strengthens habits.',
    ],
    correctAnswer: 'A',
    explanation: 'A link to verbal skills. B is secondary, C is vague, D is repetitive.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'Parent Says: “My child stumbles when tired.”',
    options: [
      'A. Recommend a break before resuming with guidance.',
      'B. Suggest continuing with fewer words to finish.',
      'C. Advise observing and correcting later.',
      'D. Propose reducing the session length slightly.',
    ],
    correctAnswer: 'A',
    explanation: 'A addresses fatigue effectively. B lowers expectation, C delays help, D is temporary.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'A student repeats words inaccurately due to pronunciation issues. What’s the best first step?',
    options: [
      'A. Repeat the words with them, guiding pronunciation.',
      'B. Demonstrate correct pronunciation before they retry.',
      'C. Ask them to repeat without assistance.',
      'D. Provide a new word list with help.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects pronunciation directly. B is preparatory, C lacks support, D delays focus.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'A student hesitates repeating everyday expressions. What’s your priority?',
    options: [
      'A. Model repeating slowly, asking them to follow.',
      'B. Repeat with them, guiding each word.',
      'C. Encourage them to repeat with minimal help.',
      'D. Show an expression chart for them to study.',
    ],
    correctAnswer: 'B',
    explanation: 'B combines support and practice. A is modeling only, C lacks aid, D is passive.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'A student skips words while repeating a 10sheet set. What should you do first?',
    options: [
      'A. Repeat the set with them, pointing to missed words.',
      'B. Let them retry and check their accuracy.',
      'C. Assign simpler words to rebuild.',
      'D. Observe and offer hints if they struggle.',
    ],
    correctAnswer: 'A',
    explanation: 'A ensures immediate correction. B delays help, C reduces challenge, D is indirect.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'A student struggles with repeating vocabulary. What’s your best action?',
    options: [
      'A. Repeat the words with them, guiding each one.',
      'B. Show a vocabulary list and guide their repetition.',
      'C. Ask them to repeat without assistance.',
      'D. Provide a new worksheet with word lines.',
    ],
    correctAnswer: 'A',
    explanation: 'A offers direct guidance. B relies on tools, C lacks support, D is preparatory.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'A student loses focus repeating a 10sheet set. What’s your priority?',
    options: [
      'A. Redirect with a short repetition game and praise.',
      'B. Continue repeating with them, keeping focus.',
      'C. Suggest a break before resuming the task.',
      'D. Assign a new task to regain their interest.',
    ],
    correctAnswer: 'B',
    explanation: 'B maintains engagement. A is distracting, C delays, D shifts focus.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'Case Study: A 6 year old student repeats familiar words but stops, looking confused. What’s the best way to help them progress?',
    options: [
      'A. Repeat words to 50 with them, guiding pronunciation.',
      'B. Show the words and ask them to repeat alone.',
      'C. Guide their repetition to 50 with support.',
      'D. Provide a new sheet with words written.',
    ],
    correctAnswer: 'C',
    explanation: 'C builds on their skill with guidance. A is gradual, B lacks aid, D adds complexity.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'Case Study: A student repeats 150 words correctly but stumbles at 51100. How should you support their learning?',
    options: [
      'A. Repeat 51100 with them, guiding pronunciation.',
      'B. Point to 51100 while they repeat alone.',
      'C. Show a word list and guide their repetition.',
      'D. Let them try again without immediate help.',
    ],
    correctAnswer: 'A',
    explanation: 'A combines verbal and physical aid. B lacks guidance, C relies on tools, D lacks support.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'Case Study: A student mixes word order in everyday expressions often. What’s your first step to correct this?',
    options: [
      'A. Repeat the expressions with them, correcting order.',
      'B. Show an expression chart and ask them to repeat.',
      'C. Guide their repetition for correct order.',
      'D. Assign a new task focusing on expression order.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects with real time guidance. B is passive, C is general, D delays focus.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'Case Study: A student hesitates during vocabulary repetition, looking at peers. What should you do to build confidence?',
    options: [
      'A. Repeat with them, offering praise.',
      'B. Encourage them to watch peers, then try.',
      'C. Demonstrate repeating, asking them to follow.',
      'D. Suggest they repeat silently to reduce pressure.',
    ],
    correctAnswer: 'A',
    explanation: 'A boosts confidence with support. B increases comparison, C shifts focus, D avoids practice.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'What is the main goal of repeating in Level 7A?',
    options: [
      'A. Build fluency in repeating words and expressions.',
      'B. Teach students to recognize vocabulary quickly.',
      'C. Help students memorize expressions instantly.',
      'D. Ensure students repeat without errors daily.',
    ],
    correctAnswer: 'A',
    explanation: 'A focuses on fluency. B is secondary, C is memorization, D is unrealistic.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'Why does Kumon emphasize guidance during repetition?',
    options: [
      'A. It helps students understand correct pronunciation.',
      'B. It speeds up repetition practice.',
      'C. It reduces the need for verbal instructions.',
      'D. It ensures students memorize word order.',
    ],
    correctAnswer: 'A',
    explanation: 'A enhances pronunciation. B overstates speed, C minimizes teaching, D is incidental.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'When should a student move from words to expressions?',
    options: [
      'A. After consistent accuracy with word repetition.',
      'B. When they can repeat words without help.',
      'C. Once they master expressions fully.',
      'D. After recognizing all words in a set.',
    ],
    correctAnswer: 'A',
    explanation: 'A ensures readiness. B lacks progression, C is premature, D skips repeating.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'What is the purpose of the 10sheet structure in early levels?',
    options: [
      'A. Develop verbal recall of words and expressions.',
      'B. Teach students to write sentences correctly.',
      'C. Help students count words quickly.',
      'D. Ensure mastery of vocabulary lists.',
    ],
    correctAnswer: 'A',
    explanation: 'A targets recall. B is writing focused, C is unrelated, D is broader.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'How should instructors handle a student skipping words?',
    options: [
      'A. Repeat with them, pointing to missed words.',
      'B. Let them self correct on the next attempt.',
      'C. Assign easier words to rebuild skills.',
      'D. None of the above.',
    ],
    correctAnswer: 'D',
    explanation: 'D applies; immediate correction is needed, not self correction or easing.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'What role does repetition play in Level 7A?',
    options: [
      'A. Reinforces pronunciation accuracy and confidence.',
      'B. Helps students finish worksheets faster.',
      'C. Ensures they memorize expressions quickly.',
      'D. Reduces the need for instructor guidance.',
    ],
    correctAnswer: 'A',
    explanation: 'A builds skills. B focuses on speed, C is memorization, D is incorrect.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'According to Level 7A, how should instructors introduce repeating words?',
    options: [
      'A. Start with 150 words, then add more with guidance.',
      'B. Begin with 100 words, reducing if needed.',
      'C. Teach all words at once with a chart.',
      'D. Repeat silently, showing words later.',
    ],
    correctAnswer: 'A',
    explanation: 'A follows the manual’s progression. B reverses order, C overwhelms, D skips verbal.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'What does the manual suggest for students struggling with repetition?',
    options: [
      'A. Repeat with them to guide the process.',
      'B. Let them observe peers before retrying.',
      'C. Provide a new sheet without assistance.',
      'D. Skip to writing exercises.',
    ],
    correctAnswer: 'A',
    explanation: 'A aligns with guidance. B delays, C lacks support, D shifts focus.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'How should instructors use the 10sheet structure?',
    options: [
      'A. Guide repetition with support for the full set.',
      'B. Teach students to guess words quickly.',
      'C. Focus on writing after repeating.',
      'D. Allow self correction without help.',
    ],
    correctAnswer: 'A',
    explanation: 'A matches the manual. B avoids accuracy, C is premature, D lacks support.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'What is the aim of the vocabulary review exercise per the manual?',
    options: [
      'A. Build initial repetition skills with support.',
      'B. Ensure students memorize all words.',
      'C. Teach fast repeating without guidance.',
      'D. Prepare for immediate expression use.',
    ],
    correctAnswer: 'A',
    explanation: 'A reflects the goal. B is memorization, C skips support, D is unrelated.',
    level: QuestionLevel.EngLevel7a,
  ),
  Question(
    text: 'According to the manual, when can students repeat 100 words smoothly?',
    options: [
      'A. After mastering repetition of the 10sheet set.',
      'B. When they finish all the sheets quickly.',
      'C. If they recognize words without help.',
      'D. After observing peers repeat successfully.',
    ],
    correctAnswer: 'A',
    explanation: 'A ensures mastery. B focuses on speed, C skips practice, D relies on others.',
    level: QuestionLevel.EngLevel7a,
  ),
];

final List<Question> englevel6aQuestions = [
  Question(
    text: 'A student struggles to write familiar phrases accurately. What would you do?',
    options: [
      'A. Write the phrases with them, guiding their hand.',
      'B. Show the phrases and ask them to try again.',
      'C. Model the writing, then have them follow.',
      'D. Let them attempt silently without help.',
    ],
    correctAnswer: 'A',
    explanation: 'A provides direct support with guidance. B is passive, C shifts to modeling, D lacks practice.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'A student misspells words while writing phrases. How should you respond?',
    options: [
      'A. Write the phrases correctly, asking them to copy.',
      'B. Point out errors and guide their spelling.',
      'C. Correct mistakes after they finish.',
      'D. Let them continue and review later.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects with immediate guidance. B is verbal only, C delays, D avoids correction.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'A student finishes writing quickly but with sloppy handwriting. What would you do?',
    options: [
      'A. Review their writing, guiding proper form.',
      'B. Praise their speed and ask for neatness.',
      'C. Assign a new sentence exercise with focus.',
      'D. Observe and let them self correct next time.',
    ],
    correctAnswer: 'A',
    explanation: 'A addresses form directly. B reinforces speed, C is preparatory, D lacks support.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'A student refuses to write in a group setting. What’s your best action?',
    options: [
      'A. Allow silent writing and check their work.',
      'B. Pair them with a peer to write together.',
      'C. Model writing aloud, inviting them to join.',
      'D. Move to a one on one session for practice.',
    ],
    correctAnswer: 'C',
    explanation: 'C encourages participation gently. A avoids group practice, B adds pressure, D overadjusts.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'A student struggles with writing a 10sheet set, mixing word order. What should you do?',
    options: [
      'A. Write the set with them, correcting order.',
      'B. Show a sentence chart and guide their writing.',
      'C. Ask them to retry without assistance.',
      'D. Give simpler phrases to build confidence.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects with guidance. B relies on tools, C lacks support, D lowers difficulty.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'A student hesitates writing vocabulary on a worksheet. What would you do?',
    options: [
      'A. Write the words with them, guiding spelling.',
      'B. Provide a word list for them to study first.',
      'C. Demonstrate the writing, asking them to copy.',
      'D. Let them write again without help.',
    ],
    correctAnswer: 'A',
    explanation: 'A offers direct support. B delays practice, C shifts to modeling, D lacks aid.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'A student stops at sentence 5 while writing 10 sentences. What’s your approach?',
    options: [
      'A. Write all 10 with them, emphasizing 510.',
      'B. Encourage them past 5 with your guidance.',
      'C. Show a sentence list and ask them to continue.',
      'D. Assign a task stopping at 5 to build skill.',
    ],
    correctAnswer: 'B',
    explanation: 'B builds on their limit with support. A overdirects, C relies on tools, D limits progress.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'Parent Says: “My child writes the same phrases daily. Is this needed?”',
    options: [
      'A. Explain that repetition builds writing accuracy and skill.',
      'B. Note that daily practice ensures neat phrase formation.',
      'C. Assure them repetition strengthens writing habits over time.',
      'D. Suggest that consistent writing prepares them for sentences.',
    ],
    correctAnswer: 'A',
    explanation: 'A ties repetition to accuracy. B is vague, C lacks detail, D shifts focus to sentences.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'Parent Says: “My child finds writing sentences boring.”',
    options: [
      'A. Highlight that writing builds focus and language fluency.',
      'B. Explain that repetition improves writing and confidence.',
      'C. Note that sentence practice develops accuracy and skills.',
      'D. Assure them writing practice strengthens early English.',
    ],
    correctAnswer: 'A',
    explanation: 'A addresses focus and fluency. B misses engagement, C is partial, D is too broad.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'Parent Says: “My child knows phrases. Why write sentences?”',
    options: [
      'A. Clarify that sentences build a stronger writing base.',
      'B. Explain that writing sentences ensures full early mastery.',
      'C. Note that progressing to sentences develops confidence.',
      'D. Assure them sentences solidify phrase foundations.',
    ],
    correctAnswer: 'B',
    explanation: 'B emphasizes mastery. A is general, C focuses on confidence, D lacks specificity.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'Parent Says: “My child struggles with sentence writing.”',
    options: [
      'A. Suggest practicing writing with guidance at home.',
      'B. Recommend using worksheets to improve writing skills.',
      'C. Offer to model writing during sessions.',
      'D. Advise focusing on slow writing with support.',
    ],
    correctAnswer: 'C',
    explanation: 'C provides direct support. A shifts to parents, B is passive, D lacks structure.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'Parent Says: “Why does my child write aloud so much?”',
    options: [
      'A. Explain that writing aloud builds verbal language skills.',
      'B. Note that speaking enhances memory and fluency.',
      'C. Assure them writing aloud reinforces word recall.',
      'D. Suggest that verbal writing strengthens habits.',
    ],
    correctAnswer: 'A',
    explanation: 'A links to verbal skills. B is secondary, C is vague, D is repetitive.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'Parent Says: “My child writes sloppily when tired.”',
    options: [
      'A. Recommend a break before resuming with guidance.',
      'B. Suggest continuing with fewer sentences to finish.',
      'C. Advise observing and correcting later.',
      'D. Propose reducing the session length slightly.',
    ],
    correctAnswer: 'A',
    explanation: 'A addresses fatigue effectively. B lowers expectation, C delays help, D is temporary.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'A student writes phrases inaccurately due to spelling issues. What’s the best first step?',
    options: [
      'A. Write the phrases with them, guiding spelling.',
      'B. Demonstrate correct writing before they retry.',
      'C. Ask them to write without assistance.',
      'D. Provide a new phrase list with help.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects spelling directly. B is preparatory, C lacks support, D delays focus.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'A student hesitates writing short sentences. What’s your priority?',
    options: [
      'A. Model writing slowly, asking them to follow.',
      'B. Write with them, guiding each word.',
      'C. Encourage them to write with minimal help.',
      'D. Show a sentence chart for them to study.',
    ],
    correctAnswer: 'B',
    explanation: 'B combines support and practice. A is modeling only, C lacks aid, D is passive.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'A student skips words while writing sentences. What should you do first?',
    options: [
      'A. Write the sentences with them, pointing to missed words.',
      'B. Let them retry and check their accuracy.',
      'C. Assign simpler phrases to rebuild.',
      'D. Observe and offer hints if they struggle.',
    ],
    correctAnswer: 'A',
    explanation: 'A ensures immediate correction. B delays help, C reduces challenge, D is indirect.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'A student struggles with writing vocabulary. What’s your best action?',
    options: [
      'A. Write the words with them, guiding each one.',
      'B. Show a vocabulary list and guide their writing.',
      'C. Ask them to write without assistance.',
      'D. Provide a new worksheet with word lines.',
    ],
    correctAnswer: 'A',
    explanation: 'A offers direct guidance. B relies on tools, C lacks support, D is preparatory.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'A student loses focus writing a 10sheet set. What’s your priority?',
    options: [
      'A. Redirect with a short writing game and praise.',
      'B. Continue writing with them, keeping focus.',
      'C. Suggest a break before resuming the task.',
      'D. Assign a new task to regain their interest.',
    ],
    correctAnswer: 'B',
    explanation: 'B maintains engagement. A is distracting, C delays, D shifts focus.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'Case Study: A 6 yea rold student writes phrases but stops, looking confused. What’s the best way to help them progress?',
    options: [
      'A. Write phrases to 5 with them, guiding their hand.',
      'B. Show the phrases and ask them to write alone.',
      'C. Guide their writing to 5 with support.',
      'D. Provide a new sheet with phrases printed.',
    ],
    correctAnswer: 'C',
    explanation: 'C builds on their skill with guidance. A is gradual, B lacks aid, D adds complexity.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'Case Study: A student writes 15 sentences correctly but stumbles at 610. How should you support their learning?',
    options: [
      'A. Write 610 with them, guiding each sentence.',
      'B. Point to 610 while they write alone.',
      'C. Show a sentence list and guide their writing.',
      'D. Let them try again without immediate help.',
    ],
    correctAnswer: 'A',
    explanation: 'A combines verbal and physical aid. B lacks guidance, C relies on tools, D lacks support.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'Case Study: A student reverses letter order in sentences often. What’s your first step to correct this?',
    options: [
      'A. Write the sentences with them, correcting order.',
      'B. Show a letter chart and ask them to rewrite.',
      'C. Guide their hand for correct letter order.',
      'D. Assign a new task focusing on sentence writing.',
    ],
    correctAnswer: 'A',
    explanation: 'A corrects with realtime guidance. B is passive, C is for tracing, D delays focus.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'Case Study: A student hesitates during phrase writing, looking at peers. What should you do to build confidence?',
    options: [
      'A. Write with them, offering praise.',
      'B. Encourage them to watch peers, then try.',
      'C. Demonstrate writing, asking them to follow.',
      'D. Suggest they write silently to reduce pressure.',
    ],
    correctAnswer: 'A',
    explanation: 'A boosts confidence with support. B increases comparison, C shifts focus, D avoids practice.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'What is the main goal of writing in Level 6A?',
    options: [
      'A. Build fluency in writing phrases and sentences.',
      'B. Teach students to recognize words quickly.',
      'C. Help students memorize sentence structures.',
      'D. Ensure students write without errors daily.',
    ],
    correctAnswer: 'A',
    explanation: 'A focuses on fluency. B is secondary, C is memorization, D is unrealistic.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'Why does Kumon emphasize guidance during writing?',
    options: [
      'A. It helps students form words and sentences correctly.',
      'B. It speeds up writing practice.',
      'C. It reduces the need for verbal instructions.',
      'D. It ensures students memorize sentence order.',
    ],
    correctAnswer: 'A',
    explanation: 'A enhances form. B overstates speed, C minimizes teaching, D is incidental.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'When should a student move from phrases to sentences?',
    options: [
      'A. After consistent accuracy with phrase writing.',
      'B. When they can write phrases without help.',
      'C. Once they master sentences fully.',
      'D. After recognizing all words in a set.',
    ],
    correctAnswer: 'A',
    explanation: 'A ensures readiness. B lacks progression, C is premature, D skips writing.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'What is the purpose of the 10sheet structure in early levels?',
    options: [
      'A. Develop writing skills for phrases and sentences.',
      'B. Teach students to read sentences correctly.',
      'C. Help students count words quickly.',
      'D. Ensure mastery of vocabulary lists.',
    ],
    correctAnswer: 'A',
    explanation: 'A targets writing. B is reading focused, C is unrelated, D is broader.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'How should instructors handle a student writing sloppily?',
    options: [
      'A. Guide their hand to improve form.',
      'B. Let them self correct on the next attempt.',
      'C. Assign easier tasks to rebuild skills.',
      'D. None of the above.',
    ],
    correctAnswer: 'D',
    explanation: 'D applies; immediate guidance is needed, not self correction or easing.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'What role does repetition play in Level 6A?',
    options: [
      'A. Reinforces writing accuracy and confidence.',
      'B. Helps students finish worksheets faster.',
      'C. Ensures they memorize sentences quickly.',
      'D. Reduces the need for instructor guidance.',
    ],
    correctAnswer: 'A',
    explanation: 'A builds skills. B focuses on speed, C is memorization, D is incorrect.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'According to Level 6A, how should instructors introduce writing phrases?',
    options: [
      'A. Start with 15 phrases, then add more with guidance.',
      'B. Begin with 10 phrases, reducing if needed.',
      'C. Teach all phrases at once with a chart.',
      'D. Write silently, showing phrases later.',
    ],
    correctAnswer: 'A',
    explanation: 'A follows the manual’s progression. B reverses order, C overwhelms, D skips verbal.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'What does the manual suggest for students struggling with sentence writing?',
    options: [
      'A. Write with them to guide the process.',
      'B. Let them observe peers before retrying.',
      'C. Provide a new sheet without assistance.',
      'D. Skip to reading exercises.',
    ],
    correctAnswer: 'A',
    explanation: 'A aligns with guidance. B delays, C lacks support, D shifts focus.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'How should instructors use the 10sheet structure?',
    options: [
      'A. Guide writing with support for the full set.',
      'B. Teach students to guess sentences quickly.',
      'C. Focus on reading after writing.',
      'D. Allow self correction without help.',
    ],
    correctAnswer: 'A',
    explanation: 'A matches the manual. B avoids accuracy, C is premature, D lacks support.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'What is the aim of the sentence writing exercise per the manual?',
    options: [
      'A. Build initial writing skills with support.',
      'B. Ensure students memorize all sentences.',
      'C. Teach fast writing without guidance.',
      'D. Prepare for immediate phrase use.',
    ],
    correctAnswer: 'A',
    explanation: 'A reflects the goal. B is memorization, C skips support, D is unrelated.',
    level: QuestionLevel.EngLevel6a,
  ),
  Question(
    text: 'According to the manual, when can students write 10 sentences smoothly?',
    options: [
      'A. After mastering writing the 10sheet set accurately.',
      'B. When they finish all sheets quickly.',
      'C. If they recognize sentences without help.',
      'D. After observing peers write successfully.',
    ],
    correctAnswer: 'A',
    explanation: 'A ensures mastery. B focuses on speed, C skips practice, D relies on others.',
    level: QuestionLevel.EngLevel6a,
  ),
];