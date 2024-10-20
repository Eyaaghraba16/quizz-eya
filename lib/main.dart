import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool isQuizCompleted = false;

  final List<Map<String, Object>> questions = [
  {
    'question': 'Quel pays est le plus grand en superficie ?',
    'answers': ['USA', 'Chine', 'Russie', 'Canada'],
    'correctAnswer': 'Russie'
  },
  {
    'question': 'Quel est le plus grand océan sur Terre ?',
    'answers': ['Océan Atlantique', 'Océan Indien', 'Océan Arctique', 'Océan Pacifique'],
    'correctAnswer': 'Océan Pacifique'
  },
  {
    'question': 'Quel est le symbole chimique de l'eau ?',
    'answers': ['O2', 'H2O', 'CO2', 'N2'],
    'correctAnswer': 'H2O'
  }
  ];

  void validateAnswer(String selectedAnswer) {
    String correctAnswer = questions[currentQuestionIndex]['correctAnswer'] as String;

    if (selectedAnswer == correctAnswer) {
      setState(() {
        score++;
      });
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      setState(() {
        isQuizCompleted = true;
      });
    }
  }

  void resetQuiz() {
    setState(() {
      score = 0;
      currentQuestionIndex = 0;
      isQuizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: isQuizCompleted
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Score: $score/${questions.length}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: resetQuiz,
                    child: Text('Restart Quiz'),
                  )
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    questions[currentQuestionIndex]['question'] as String,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ...(questions[currentQuestionIndex]['answers'] as List<String>).map((answer) {
                  return ElevatedButton(
                    onPressed: () => validateAnswer(answer),
                    child: Text(answer),
                  );
                }).toList(),
              ],
            ),
    );
  }
}
