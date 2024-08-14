import 'package:flutter/material.dart';

class StartQuizeScreen extends StatelessWidget {
  final void Function() startQuiz;

  const StartQuizeScreen(this.startQuiz, {super.key});

  @override
  Widget build(BuildContext context) =>
      Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(
          color: const Color.fromARGB(150, 255, 255, 255),
          width: 192,
          'assets/images/quiz-logo.png',
        ),
        const SizedBox(height: 32),
        const Text(
            style: TextStyle(color: Colors.white, fontSize: 25),
            'Learn Flutter the fun way!'),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          onPressed: startQuiz,
          icon: const Icon(Icons.arrow_forward_ios_outlined),
          label: const Text(style: TextStyle(fontSize: 18), 'Start Quiz'),
        ),
      ]);
}
