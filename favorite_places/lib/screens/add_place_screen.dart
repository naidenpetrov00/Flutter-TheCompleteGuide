import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/models/place_location.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
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
  var _isSendingTheData = false;
  PlaceLocation? _selectedLocaion;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSendingTheData = true;
      });
      final enteredTitle = _titleController.text;
      if (enteredTitle.isEmpty ||
          _selectedImage == null ||
          _selectedLocaion == null) {
        return;
      }

      ref.read(placesProvider.notifier).addPlace(
          title: enteredTitle,
          image: _selectedImage!,
          location: _selectedLocaion!);

      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
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
              ),
              const SizedBox(height: 10),
              ImageInput(
                onTakeImage: (File image) => _selectedImage = image,
              ),
              const SizedBox(height: 10),
              LocationInput(
                  onSelectLocation: (location) => _selectedLocaion = location),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _isSendingTheData ? null : _saveItem,
                label: _isSendingTheData
                    ? const CircularProgressIndicator()
                    : const Text('Add Place'),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
