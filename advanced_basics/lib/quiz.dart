import 'package:advanced_basics/questions_screen.dart';
import 'package:advanced_basics/start_quiz_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<StatefulWidget> {
  var activeScreen = 'start_quiz_screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions_screen';
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple.shade900, Colors.purple.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Center(
              child: activeScreen == 'start_quiz_screen'
                  ? StartQuizeScreen(switchScreen)
                  : const QuestionsScreen(),
            ),
          ),
        ),
      );
}
