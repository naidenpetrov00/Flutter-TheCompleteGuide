import 'package:first_app/gradient_container.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    const MaterialApp(
      home: Scaffold(
          body: GradientContainer(
        colors: [
          Color.fromARGB(255, 82, 15, 196),
          Color.fromARGB(255, 77, 109, 208)
        ],
      )),
    ),
  );
}
