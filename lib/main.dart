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
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Qual tipo de animais é permitido a caça no Brasil?',
      'options': ['Ararajuba', 'Onça Pintada', 'Javali', 'Cervo do Pantanal'],
      'answer': 2
    },
    {
      'question': 'Quais as melhores armas?',
      'options': ['270 Winchester', 'balestra', '.44 Magnum', '.454 Casull'],
      'answer': 1
    },
    {
      'question': 'Quais melhores cães para essa caça?',
      'options': ['Vira Lata', 'Foxhound Americano', 'Caramelo', 'Salsicha'],
      'answer': 1
    },
    {
      'question': 'Qual melhor bioma?',
      'options': ['Mata', 'Cerrado', 'Neve', 'Deserto'],
      'answer': 1
    },
    {
      'question': 'Quantos continentes existem na Terra?',
      'options': ['5', '6', '7', '8'],
      'answer': 2
    }
  ];

  void _answerQuestion(int selectedOption) {
    if (selectedOption == _questions[_currentQuestionIndex]['answer']) {
      _score++;
    }

    setState(() {
      _currentQuestionIndex++;
    });

    if (_currentQuestionIndex >= _questions.length) {
      _showScoreDialog();
    }
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Quiz Concluído!'),
        content: Text('Você acertou $_score de ${_questions.length} perguntas.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetQuiz();
            },
            child: Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }

  void _resetQuiz() {
    setState(() {
      _score = 0;
      _currentQuestionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: _currentQuestionIndex < _questions.length
          ? _buildQuizQuestion()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://legalmentearmado.com.br/wp-content/uploads/2019/05/como-tirar-cr-no-exercito-cacador-atirador-colecionador.jpg",
                  width: 300,
                  height: 200,
                ),
                SizedBox(height: 20),
                Text(
                  'Parabéns! Você completou o quiz.',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
    );
  }
  Widget _buildQuizQuestion() {
    final question = _questions[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         
          if (_currentQuestionIndex =+ 0)
          Text(
            question['question'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ...List.generate(question['options'].length, (index) {
            return ElevatedButton(
              onPressed: () => _answerQuestion(index),
              child: Text(question['options'][index]),
            );
          }),
        ],
      ),
    );
  }
}
