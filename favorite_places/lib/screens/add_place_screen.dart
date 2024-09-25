import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();

  late List<String> places;
  var _title = '';
  var _isSendingTheData = false;

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSendingTheData = true;
      });

      Navigator.of(context).pop(_title);
    }
  }

  @override
  Widget build(BuildContext context) {
    places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length < 2 ||
                      value.trim().length > 50) {
                    return 'Must be between 2 and 50';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              ElevatedButton(
                onPressed: _isSendingTheData ? null : _saveItem,
                child: const Text('Add Item'),
              ),
            ],
          )),
    );
  }
}
