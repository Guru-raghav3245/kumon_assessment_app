import 'package:kumon_assessment_app/models.dart';

// Level 6a Questions (33 questions, removed questions 2 and 24)
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

// Level 5a Questions (33 questions, removed questions 2 and 24)
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

// Level 4a Questions (33 questions, removed questions 2 and 24)
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
