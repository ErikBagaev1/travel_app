import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  const MyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: theme.primary, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
