import 'dart:io';

import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _isLoginMode = true;
  var _enteredUsername = '';
  var _enteredEmail = '';
  var _enteredPassword = '';
  File? _selectedImage;
  var _isAuthenticating = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid || !_isLoginMode && _selectedImage == null) return;

    _form.currentState!.save();
    UserCredential userCredentials;
    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLoginMode) {
        userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredentials.user!.uid)
            .set(
          {
            "username": _enteredUsername,
            "email": _enteredEmail,
            "image_url": imageUrl,
          },
        );
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? "Authentication failed")));
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 32,
                    bottom: 24,
                    left: 24,
                    right: 24,
                  ),
                  width: 200,
                  child: Image.asset('assets/images/chat.png'),
                ),
                Card(
                  margin: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _form,
                        child: Column(
                          children: [
                            if (!_isLoginMode)
                              UserImagePicker(
                                onPickedImage: (pickedImage) =>
                                    _selectedImage = pickedImage,
                              ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Email address'),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter valid email address';
                                }

                                return null;
                              },
                              onSaved: (value) => _enteredEmail = value!,
                            ),
                            if (!_isLoginMode)
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Username'),
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().length < 4) {
                                    return 'Username must be at least 4 characters long';
                                  }

                                  return null;
                                },
                                onSaved: (newValue) =>
                                    _enteredUsername = newValue!,
                              ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }

                                return null;
                              },
                              onSaved: (value) => _enteredPassword = value!,
                            ),
                            const SizedBox(height: 16),
                            if (_isAuthenticating)
                              const CircularProgressIndicator(),
                            if (!_isAuthenticating)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                onPressed: _submit,
                                child: Text(_isLoginMode ? 'Login' : 'Sign up'),
                              ),
                            if (!_isAuthenticating)
                              TextButton(
                                onPressed: () => setState(() {
                                  _isLoginMode = !_isLoginMode;
                                }),
                                child: Text(_isLoginMode
                                    ? 'Create an account'
                                    : 'I alredy have an account'),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
