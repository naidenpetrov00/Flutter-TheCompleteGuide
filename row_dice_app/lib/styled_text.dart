import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String text;

  const StyledText({required this.text, super.key});

  @override
  Widget build(BuildContext context) =>
      Text(style: const TextStyle(color: Colors.white, fontSize: 28), text);
}
