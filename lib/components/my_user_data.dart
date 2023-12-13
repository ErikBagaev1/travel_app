import 'package:flutter/material.dart';
import 'package:social_network/components/my_expanded.dart';

class UserDataWidget extends StatelessWidget {
  final Map<String, dynamic>? userData;
  static const Map<String, String> fieldMappings = {
    'email': 'ЕМАИЛ',
    // Добавьте другие поля по мере необходимости
  };

  const UserDataWidget({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Text('No data available');
    }

    List<Widget> userFields = [];

    // Проход по всем параметрам пользователя и добавление соответствующих виджетов
    userData!.forEach((key, value) {
      userFields.add(
        MyExpanded(
          left: fieldMappings.containsKey(key) ? fieldMappings[key] ?? "" : key,
          right: value.toString(),
        ),
      );
    });

    return Column(
      children: userFields,
    );
  }
}
