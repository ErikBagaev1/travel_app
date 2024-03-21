import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/provider/person_data_provider.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final double padding;
  final bool obscureText;
  final String? modelIndex;
  final TextEditingController controller;
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      required this.padding,
      this.modelIndex});

  @override
  Widget build(BuildContext context) {
    final personDataProvider =
        Provider.of<PersonDataProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextField(
          onChanged: (text) {
            if (modelIndex != null) {
              switch (modelIndex) {
                case 'seriesPassport':
                  personDataProvider.updatePerson(
                      seriesPassport: int.tryParse(text));
                  break;
                case 'numberPassport':
                  personDataProvider.updatePerson(
                      numberPassport: int.tryParse(text));
                  break;
                case 'firstName':
                  personDataProvider.updatePerson(firstName: text);
                  break;
                case 'lastName':
                  personDataProvider.updatePerson(lastName: text);
                  break;
                case 'fatherName':
                  personDataProvider.updatePerson(fatherName: text);
                  break;
                case 'countChildren':
                  personDataProvider.updatePerson(
                      countChildren: int.tryParse(text));
                  break;
              }
            }
          },
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
