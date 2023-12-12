import 'package:flutter/material.dart';
import 'package:social_network/components/my_expanded.dart';
import 'package:social_network/components/my_textfield.dart';

class EditingPage extends StatefulWidget {
  const EditingPage({super.key});

  @override
  State<EditingPage> createState() => _EditingPageState();
}                                        

class _EditingPageState extends State<EditingPage> {
  final TextEditingController passportController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  final TextEditingController countChildrenController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['username']),
        centerTitle: true,
      ),
      body: Column(
        children: [
          MyExpanded(
            left: 'Имя',
            right: arguments['username'],
          ),
          MyExpanded(
            left: 'Email',
            right: arguments['email'],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: MyTextField(
                hintText: 'Паспортные данные',
                obscureText: true,
                controller: passportController),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: MyTextField(
                hintText: 'Пол',
                obscureText: true,
                controller: genderController),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: MyTextField(
                hintText: 'Количество детей',
                obscureText: true,
                controller: countChildrenController),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
