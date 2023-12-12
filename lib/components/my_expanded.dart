import 'package:flutter/material.dart';

class MyExpanded extends StatelessWidget {
  final String left;
  final String right;
  const MyExpanded({
    super.key,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$left:",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: Text(
              right,
              style: const TextStyle(fontSize: 21),
            ),
          ),
        ],
      ),
    );
  }
}
