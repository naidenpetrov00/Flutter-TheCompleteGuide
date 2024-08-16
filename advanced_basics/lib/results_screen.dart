import 'package:advanced_basics/data/questions.dart';
import 'package:advanced_basics/questions_summary.dart';
import 'package:advanced_basics/routes.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final List<String> chosenAnswer;
  final void Function(String screen) resetQuiz;

  const ResultsScreen(
      {super.key, required this.chosenAnswer, required this.resetQuiz});

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswer[i]
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where((data) => data['correct_answer'] == data['user_answer'])
        .length;

    return Container(
      margin: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              style: TextStyle(fontSize: 20, color: Colors.purple.shade50),
              textAlign: TextAlign.center,
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!'),
          const SizedBox(height: 32),
          QuestionsSummary(questionsSummaryData: summaryData),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              chosenAnswer.clear();
              resetQuiz(Routes.startQuizScreen);
            },
            label: const Text('Restart Quiz!'),
          ),
        ],
      ),
    );
  }
}
