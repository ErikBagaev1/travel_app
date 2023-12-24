import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final double padding;
  final bool obscureText;

  final TextEditingController controller;
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextField(
          cursorColor: Theme.of(context).colorScheme.inversePrimary,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            labelText: hintText,
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
            ),
          ),
          obscureText: obscureText),
    );
  }
}
