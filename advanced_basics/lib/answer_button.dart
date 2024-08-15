import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String answerText;

  final void Function() onPress;

  const AnswerButton(
      {required this.answerText, required this.onPress, super.key});

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple.shade300,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
      onPressed: onPress,
      child: Text(textAlign: TextAlign.center, answerText));
}
