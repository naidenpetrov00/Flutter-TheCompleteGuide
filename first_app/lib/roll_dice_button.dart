import 'package:flutter/material.dart';

class RollDiceButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RollDiceButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
        ),
        child: const Text('Row Dice'),
      );
}
