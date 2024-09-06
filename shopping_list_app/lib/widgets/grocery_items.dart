import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

import 'package:http/http.dart' as http;

class GroceryItems extends StatefulWidget {
  final List<GroceryItem> groceryItems;

  const GroceryItems({super.key, required this.groceryItems});

  @override
  State<GroceryItems> createState() => _GroceryItemsState();
}

class _GroceryItemsState extends State<GroceryItems> {
  void _removeItem(GroceryItem item) async {
    final index = widget.groceryItems.indexOf(item);
    final url = Uri.https(
      'hoppinglist-2af1a-default-rtdb.europe-west1.firebasedatabase.app',
      'shopping_list/${item.id}.json',
    );
    setState(() {
      widget.groceryItems.remove(item);
    });
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot Delete Item')),
      );
      setState(() {
        widget.groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: widget.groceryItems.length,
          itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(widget.groceryItems[index]),
            onDismissed: (direction) => _removeItem(widget.groceryItems[index]),
            child: ListTile(
              title: Text(
                widget.groceryItems[index].name,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              leading: Container(
                width: 16,
                height: 16,
                color: widget.groceryItems[index].category.color,
              ),
              trailing: Text(
                widget.groceryItems[index].quantity.toString(),
              ),
            ),
          ),
        ),
      );
}
