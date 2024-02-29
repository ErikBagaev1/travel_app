import 'package:flutter/material.dart';

class MyBlueButton extends StatelessWidget {
  final String path;
  final String title;
  const MyBlueButton({super.key, required this.path, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFF0D72FF))),
        onPressed: () {
          Navigator.pushNamed(context, path);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 19),
          ),
        ),
      ),
    );
  }
}
