import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/grocery_items.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }
    print(newItem.name);
    setState(() {
      _groceryItems.add(newItem);
    });
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
      body: _groceryItems.isEmpty
          ? Center(
              child: Text(
                'You have no Items...',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : GroceryItems(
              groceryItems: _groceryItems,
            ),
    );
  }
}
