import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;

  final _titleController = TextEditingController();
  late List<Place> places;
  var _title = '';
  var _isSendingTheData = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSendingTheData = true;
      });
      final enteredTitle = _titleController.text;
      if (enteredTitle.isEmpty || _selectedImage == null) {
        return;
      }

      ref
          .read(placesProvider.notifier)
          .addPlace(title: enteredTitle, image: _selectedImage!);

      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
                controller: _titleController,
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
              const SizedBox(height: 10),
              ImageInput(
                onTakeImage: (File image) => _selectedImage = image,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _isSendingTheData ? null : _saveItem,
                label: _isSendingTheData
                    ? const CircularProgressIndicator()
                    : const Text('Add Item'),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
