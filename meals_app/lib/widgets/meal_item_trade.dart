import 'package:flutter/material.dart';

class MealItemTrade extends StatelessWidget {
  final IconData icon;
  final String label;

  const MealItemTrade({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      );
}
