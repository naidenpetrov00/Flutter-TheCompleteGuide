import 'package:advanced_basics/answer_button.dart';
import 'package:advanced_basics/data/questions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<StatefulWidget> {
  var currentQuestionIndex = 0;

  void answerQuestion() {
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                currentQuestion.text),
            const SizedBox(height: 32),
            ...currentQuestion.getShuffledAnswers().map((a) => AnswerButton(
                  answerText: a,
                  onPress: answerQuestion,
                ))
          ],
        ),
      ),
    );
  }
}
