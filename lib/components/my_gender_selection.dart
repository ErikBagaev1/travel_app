import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/provider/editing_provider.dart';

class GenderSelectionWidget extends StatelessWidget {
  const GenderSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final genderProvider = Provider.of<GenderProvider>(context);
    final selectedGender = genderProvider.selectedGender;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          'Пол:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Radio(
              activeColor: Theme.of(context).colorScheme.inversePrimary,
              value: Gender.male,
              groupValue: selectedGender,
              onChanged: (value) {
                genderProvider.setGender(value as Gender);
              },
            ),
            const Text('Мужской'),
          ],
        ),
        Row(
          children: [
            Radio(
              activeColor: Theme.of(context).colorScheme.inversePrimary,
              value: Gender.female,
              groupValue: selectedGender,
              onChanged: (value) {
                genderProvider.setGender(value as Gender);
              },
            ),
            const Text('Женский'),
          ],
        ),
      ],
    );
  }
}
