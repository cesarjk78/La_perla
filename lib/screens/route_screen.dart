import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  final List<Map<String, Object>> _questions = [
    {
      'question': '¿Cuál es la capital de Perú?',
      'answers': ['Lima', 'Cusco', 'Arequipa', 'Trujillo'],
      'correct': 'Lima',
    },
    {
      'question': '¿Cuál es la montaña más alta del Perú?',
      'answers': ['Huascarán', 'Ausangate', 'Misti', 'Coropuna'],
      'correct': 'Huascarán',
    },
    {
      'question': '¿Qué bebida es típica de Perú?',
      'answers': ['Chicha morada', 'Mate', 'Café americano', 'Té verde'],
      'correct': 'Chicha morada',
    },
    {
      'question': '¿Cuál es el río más largo del Perú?',
      'answers': ['Amazonas', 'Ucayali', 'Marañón', 'Huallaga'],
      'correct': 'Amazonas',
    },
    {
      'question': '¿En qué ciudad se encuentra Machu Picchu?',
      'answers': ['Cusco', 'Lima', 'Arequipa', 'Puno'],
      'correct': 'Cusco',
    },
  ];

  int _currentQuestion = 0;
  int _score = 0;
  String? _selectedAnswer;
  bool _answered = false;
  bool _isCorrect = false;

  void _answerQuestion(String answer) {
    if (_answered) return;

    setState(() {
      _selectedAnswer = answer;
      _answered = true;
      _isCorrect = answer == _questions[_currentQuestion]['correct'];
      if (_isCorrect) _score++;
    });

    // Avanzar a la siguiente pregunta después de un pequeño delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _currentQuestion++;
        _answered = false;
        _selectedAnswer = null;
      });
    });
  }

  void _resetGame() {
    setState(() {
      _currentQuestion = 0;
      _score = 0;
      _answered = false;
      _selectedAnswer = null;
    });
  }

  Color _getButtonColor(String answer) {
    if (!_answered) return AppColors.primary; // color normal

    if (answer == _questions[_currentQuestion]['correct']) {
      return AppColors.correct; // correcto
    }

    if (_selectedAnswer == answer && !_isCorrect) {
      return AppColors.wrong; // incorrecto
    }

    return AppColors.primary.withOpacity(0.5); // deshabilitado
  }

  Icon? _getIcon(String answer) {
    if (!_answered) return null;
    if (answer == _questions[_currentQuestion]['correct']) {
      return const Icon(Icons.check, color: Colors.white);
    }
    if (_selectedAnswer == answer && !_isCorrect) {
      return const Icon(Icons.close, color: Colors.white);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestion >= _questions.length) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Trivia Peruana 🎉'),
          backgroundColor: AppColors.primary,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¡Terminaste!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 24),
                Text(
                  'Tu puntaje: $_score/${_questions.length}',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _resetGame,
                  icon: const Icon(Icons.replay),
                  label: const Text('Jugar otra vez'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final current = _questions[_currentQuestion];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Trivia Peruana 🎉'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Pregunta
            Text(
              current['question'] as String,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 16),

            // Imagen think
            Center(
              child: Image.asset(
                'assets/image/think.png',
                height: 150,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 32),

            // Respuestas
            ...((current['answers'] as List<String>).map((ans) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton.icon(
                  onPressed: () => _answerQuestion(ans),
                  icon: _getIcon(ans) ?? const SizedBox(width: 24),
                  label: Text(ans),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getButtonColor(ans),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              );
            }).toList()),

            const Spacer(),

            Text(
              'Pregunta ${_currentQuestion + 1} de ${_questions.length}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
