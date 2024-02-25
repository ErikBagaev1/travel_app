import 'package:flutter/material.dart';

class ButtonAboutHotel extends StatelessWidget {
  const ButtonAboutHotel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFF0D72FF))),
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              'К выбору номера',
              style: TextStyle(fontSize: 19),
            ),
          ),
        ),
      ),
    );
  }
}
