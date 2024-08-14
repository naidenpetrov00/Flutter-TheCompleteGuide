import 'dart:math';

import 'package:first_app/roll_dice_button.dart';
import 'package:flutter/material.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<StatefulWidget> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<StatefulWidget> {
  var randomValue = 1;
  void onRollDiceButtonPressed() {
    setState(() {
      randomValue = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/dice-images/dice-$randomValue.png',
            width: 200,
          ),
          const SizedBox(height: 16),
          RollDiceButton(onPressed: onRollDiceButtonPressed)
        ],
      );
}
