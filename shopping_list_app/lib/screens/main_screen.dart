import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/grocery_items.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  void _loadItems() async {
    final url = Uri.https(
      'shoppinglist-2af1a-default-rtdb.europe-west1.firebasedatabase.app',
      'shopping_list.json',
    );
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      setState(() {
        _error = "Failed To Fecth Data";
      });
    }
    if (response.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    final Map<String, dynamic> itemsData = json.decode(response.body);
    final List<GroceryItem> fetchedItems = [];
    for (var itemData in itemsData.entries) {
      final category = categories.entries
          .firstWhere((c) => c.value.name == itemData.value['category'])
          .value;
      fetchedItems.add(GroceryItem(
          id: itemData.key,
          name: itemData.value['name'],
          quantity: itemData.value['quantity'],
          category: category));
    }
    setState(() {
      _groceryItems = fetchedItems;
      _isLoading = false;
    });
  }

  void _addItem() async {
    final item = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (item == null) {
      return;
    }

    setState(() {
      _groceryItems.add(item);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    if (_isLoading) {
      bodyContent = const Center(child: CircularProgressIndicator());
    } else if (_groceryItems.isEmpty) {
      bodyContent = Center(
        child: Text(
          'You have no Items...',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    } else {
      bodyContent = GroceryItems(groceryItems: _groceryItems);
    }

    if (_error != null) {
      bodyContent = Center(
        child: Text(_error!),
      );
    }

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
        body: bodyContent);
  }
}
