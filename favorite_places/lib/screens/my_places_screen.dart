import 'package:flutter/material.dart';

class MyPlacesScreen extends StatelessWidget {
  const MyPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: const Text('Your Places'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      );
}
