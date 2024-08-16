import 'package:advanced_basics/questions_screen.dart';
import 'package:advanced_basics/results_screen.dart';
import 'package:advanced_basics/start_quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:advanced_basics/data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<StatefulWidget> {
  final List<String> _selectedAnswers = [];
  var activeScreen = 'start_quiz_screen';

  void switchScreen(String screen) {
    setState(() {
      activeScreen = screen;
    });
  }

  void chooseAnswer(String answer) {
    _selectedAnswers.add(answer);

    if (_selectedAnswers.length >= questions.length) {
      setState(() {
        activeScreen = 'results_screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreenWidget = StartQuizScreen(switchScreen);

    if (activeScreen == 'questions_screen') {
      currentScreenWidget = QuestionsScreen(onSelectAnswer: chooseAnswer);
    } else if (activeScreen == 'results_screen') {
      currentScreenWidget = ResultsScreen(
        chosenAnswer: _selectedAnswers,
        resetQuiz: switchScreen,
      );
    } else if (activeScreen == 'start_quiz_screen') {
      currentScreenWidget = StartQuizScreen(switchScreen);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple.shade900, Colors.purple.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Center(child: currentScreenWidget),
        ),
      ),
    );
  }
}
