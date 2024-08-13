import 'package:first_app/dice_roller.dart';
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final List<Color> colors;

  const GradientContainer({required this.colors, super.key});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors),
        ),
        child: const Center(
          child: DiceRoller(),
        ),
      );
}
