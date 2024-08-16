import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  final List<Map<String, Object>> questionsSummaryData;

  const QuestionsSummary({super.key, required this.questionsSummaryData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 304,
      child: SingleChildScrollView(
        child: Column(
          children: questionsSummaryData.map((data) {
            final correctAnswered =
                data['correct_answer'] == data['user_answer'];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: correctAnswered
                      ? Colors.purple.shade300
                      : Colors.blue.shade300,
                  foregroundColor: Colors.black,
                  radius: 16,
                  child: Text(((data['question_index'] as int) + 1).toString()),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['question'].toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                        Text(
                          data['user_answer'].toString(),
                          style: TextStyle(color: Colors.purple.shade300),
                        ),
                        Text(
                          data['correct_answer'].toString(),
                          style: TextStyle(color: Colors.blue.shade300),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
