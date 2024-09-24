import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();

  var _title = '';
  var _isSendingTheData = false;

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSendingTheData = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
