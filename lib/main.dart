import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mencongak',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
          bodyMedium: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mencongak"), centerTitle: true),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "MENCONGAK D4 MANAJEMEN INFORMATIKA",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text("Play", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isQuizFinished = false;
  String _selectedAnswer = "";

  final List<Question> _questions = [
    Question("Apa itu Manajemen Informatika?", ["Ilmu tentang komputer", "Ilmu mengelola sistem informasi", "Ilmu tentang jaringan komputer", "Ilmu tentang hardware"], "Ilmu mengelola sistem informasi"),
    Question("Apa tujuan utama dari Manajemen Informatika?", ["Membuat website", "Mengelola data dan sistem informasi", "Memperbaiki komputer", "Mengembangkan hardware"], "Mengelola data dan sistem informasi"),
    Question("Apa software yang biasa digunakan dalam pengelolaan basis data?", ["Photoshop", "MySQL", "AutoCAD", "Illustrator"], "MySQL"),
    Question("Apa itu ERP dalam Manajemen Informatika?", ["Enterprise Resource Planning", "Electronic Resource Planning", "Enterprise Reactive Processing", "Electronic Reactive Processing"], "Enterprise Resource Planning"),
    Question("Apa yang dimaksud dengan analisis sistem dalam Manajemen Informatika?", ["Menganalisis kegunaan komputer", "Menganalisis dan merancang sistem informasi", "Menganalisis hardware", "Menganalisis kode program"], "Menganalisis dan merancang sistem informasi"),
    Question("Apa kepanjangan dari ITIL?", ["Information Technology Infrastructure Library", "Information Technology International License", "Information Training Infrastructure Library", "IT Industrial Language"], "Information Technology Infrastructure Library"),
    Question("Apa peran utama sistem informasi manajemen (SIM)?", ["Memproses penggajian", "Menyediakan informasi untuk pengambilan keputusan", "Memindai virus", "Menghubungkan jaringan lokal"], "Menyediakan informasi untuk pengambilan keputusan"),
    Question("Istilah CRUD merujuk pada?", ["Create, Read, Update, Delete", "Control, Run, Update, Delete", "Create, Run, Upload, Download", "Check, Read, Update, Delete"], "Create, Read, Update, Delete"),
    Question("Bahasa pemrograman yang sering digunakan untuk backend sistem informasi?", ["Python", "HTML", "CSS", "Sketch"], "Python"),
    Question("Apa tujuan utama dari audit sistem informasi?", ["Meningkatkan kecepatan komputer", "Menilai efektivitas dan keamanan sistem", "Mendokumentasikan kode program", "Menambahkan fitur baru"], "Menilai efektivitas dan keamanan sistem"),
  ];

  void _checkAnswer(String selectedAnswer) {
    setState(() {
      _selectedAnswer = selectedAnswer;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        if (selectedAnswer == _questions[_currentQuestionIndex].correctAnswer) {
          _score++;
        }

        if (_currentQuestionIndex < _questions.length - 1) {
          _currentQuestionIndex++;
          _selectedAnswer = "";
        } else {
          _isQuizFinished = true;
        }
      });
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _isQuizFinished = false;
      _selectedAnswer = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mencongak"), centerTitle: true),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: _isQuizFinished
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Quiz Selesai!\nSkor Anda: $_score / ${_questions.length}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _restartQuiz,
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                            child: const Text("Coba Lagi", style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const HomePage()),
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            child: const Text("Quit", style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _questions[_currentQuestionIndex].questionText,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      ..._questions[_currentQuestionIndex].options.map((option) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              onPressed: _selectedAnswer.isEmpty ? () => _checkAnswer(option) : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _selectedAnswer.isEmpty
                                    ? Colors.deepPurple
                                    : (option == _questions[_currentQuestionIndex].correctAnswer ? Colors.green : Colors.red),
                              ),
                              child: Text(option, style: const TextStyle(fontSize: 18, color: Colors.white)),
                            ),
                          )),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}
