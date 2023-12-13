import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_network/components/my_expanded.dart';
import 'package:social_network/components/my_textfield.dart';
import 'package:social_network/helper/helper_function.dart';

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
  void _saveChanges(arguments, context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      String userEmail = arguments['email'];
      String passportData = passportController.text;
      String gender = genderController.text;
      int countChildren = int.tryParse(countChildrenController.text) ?? 0;

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userEmail)
          .update({
        'passportData': passportData,
        'gender': gender,
        'countChildren': countChildren,
      });
      Navigator.pop(context);

      showCustomDialog(
          context: context,
          title: 'Успешно',
          message: 'Данные успешно обновлены!');
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

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
                obscureText: false,
                controller: passportController),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: MyTextField(
                hintText: 'Пол',
                obscureText: false,
                controller: genderController),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: MyTextField(
                hintText: 'Количество детей',
                obscureText: false,
                controller: countChildrenController),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
                onTap: () {
                  _saveChanges(arguments, context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(
                        width: 1, //
                      ),
                      borderRadius: BorderRadius.circular(18)),
                  padding: const EdgeInsets.all(25),
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Сохранить',
                    style: TextStyle(fontSize: 25),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
