import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz de Esportes',
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, Object>> questions = [
    {
      'question': 'Quem é o maior artilheiro da história da seleção brasileira?',
      'answers': ['Pelé', 'Romário', 'Ronaldo', 'Neymar'],
      'correctAnswer': 'Neymar',
    },
    {
      'question': 'Qual seleção ganhou mais jogos na Copa do Mundo?',
      'answers': ['Alemanha', 'Brasil', 'Itália', 'Argentina'],
      'correctAnswer': 'Brasil',
    },
    {
      'question': 'Qual jogador é conhecido como "GOAT" do basquete?',
      'answers': ['Michael Jordan', 'LeBron James', 'Kobe Bryant', 'Shaquille O\'Neal'],
      'correctAnswer': 'Michael Jordan',
    },
    {
      'question': 'Quantos pontos vale um arremesso do perímetro no basquete?',
      'answers': ['1 ponto', '2 pontos', '3 pontos', '4 pontos'],
      'correctAnswer': '3 pontos',
    },
    {
      'question': 'Qual time é o maior campeão da história da NBA?',
      'answers': ['Chicago Bulls', 'Boston Celtics', 'Los Angeles Lakers', 'Miami Heat'],
      'correctAnswer': 'Boston Celtics',
    },
    {
      'question': 'Quem venceu a Copa do Mundo de 1974?',
      'answers': ['Alemanha', 'França', 'Brasil', 'Argentina'],
      'correctAnswer': 'Alemanha',
    },
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  String message = '';
  Color messageColor = Colors.black;
  bool answerSelected = false;

  void checkAnswer(String answer) {
    if (!answerSelected) {
      setState(() {
        answerSelected = true;
        if (answer == questions[currentQuestionIndex]['correctAnswer']) {
          score += 10;
          message = 'Resposta correta!';
          messageColor = const Color.fromARGB(255, 250, 3, 65);
        } else {
          message = 'Resposta errada!';
          messageColor = const Color.fromARGB(255, 3, 248, 36);
        }
      });
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        resetMessage();
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScorePage(score: score, onRestart: resetQuiz),
        ),
      );
    }
  }

  void resetMessage() {
    message = '';
    messageColor = Colors.black;
    answerSelected = false;
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      resetMessage();
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz de Esportes')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM_EAuE7Y-ihy9jqiqZ_0s7xdwP8nxkj9q-Q&s', 
              height: 400, 
              width: 400, 
            ),
            SizedBox(height: 20),
            if (currentQuestionIndex < questions.length) ...[
              Text(
                questions[currentQuestionIndex]['question'] as String,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ...(questions[currentQuestionIndex]['answers'] as List<String>).map((answer) {
                return ElevatedButton(
                  onPressed: () => checkAnswer(answer),
                  child: Text(answer),
                );
              }).toList(),
              SizedBox(height: 20),
              Text(message, style: TextStyle(fontSize: 20, color: messageColor)),
              if (answerSelected)
                ElevatedButton(
                  onPressed: nextQuestion,
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.deepPurple),
                  child: Text('Próxima Pergunta'),
                ),
            ]
          ],
        ),
      ),
    );
  }
}

class ScorePage extends StatelessWidget {
  final int score;
  final VoidCallback onRestart;

  ScorePage({required this.score, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pontuação Final')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sua Pontuação Total: $score pontos', style: TextStyle(fontSize: 24, color: Colors.blue)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: onRestart, child: Text('Deseja refazer este Quiz?')),
          ],
        ),
      ),
    );
  }
}
