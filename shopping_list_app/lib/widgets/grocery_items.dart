import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

class GroceryItems extends StatelessWidget {
  final List<GroceryItem> groceryItems;

  const GroceryItems({super.key, required this.groceryItems});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(groceryItems[index]),
            onDismissed: (direction) => groceryItems.removeAt(index),
            child: ListTile(
              title: Text(
                groceryItems[index].name,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              leading: Container(
                width: 16,
                height: 16,
                color: groceryItems[index].category.color,
              ),
              trailing: Text(
                groceryItems[index].quantity.toString(),
              ),
            ),
          ),
        ),
      );
}
