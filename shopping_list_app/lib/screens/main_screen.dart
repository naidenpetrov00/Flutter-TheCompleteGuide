import 'package:flutter/material.dart';
import 'package:shopping_list_app/widgets/grocery_items.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Your Grocceries',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const GroceryItems(),
    );
  }
}
