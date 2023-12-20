import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_network/components/my_textfield.dart';
import 'package:social_network/helper/helper_function.dart';

enum Gender { male, female }

class EditingPage extends StatefulWidget {
  const EditingPage({super.key});

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  //----------------------------К О Н Т Р О Й Л Е Р Ы---------------------------
  final TextEditingController seriesPassportController =
      TextEditingController();
  final TextEditingController numberPassportController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController countChildrenController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  Gender selectedGender = Gender.male; // Изначально выбран "Мужской"

  //----------------------------------------------------------------------------

  void _saveChanges(arguments, context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      String userEmail = arguments['email'];
      int countChildren = int.tryParse(countChildrenController.text) ?? 0;

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userEmail)
          .update({
        'seriesPassport': seriesPassportController.text,
        'numberPassport': numberPassportController.text,
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'fatherName': fatherNameController.text,
        'gender': selectedGender == Gender.male ? 'Мужской' : 'Женский',
        'countChildren': countChildren,
      });

      Navigator.pop(context);

      await showCustomDialog(
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
    seriesPassportController.text =
        (arguments['seriesPassport'] ?? '').isNotEmpty
            ? '${arguments['seriesPassport']}'
            : '';

    numberPassportController.text =
        (arguments['numberPassport'] ?? '').isNotEmpty
            ? '${arguments['numberPassport']}'
            : '';
    fatherNameController.text = (arguments['fatherName'] ?? '').isNotEmpty
        ? '${arguments['fatherName']}'
        : '';

    lastNameController.text = (arguments['lastName'] ?? '').isNotEmpty
        ? '${arguments['lastName']}'
        : '';

    firstNameController.text = (arguments['firstName'] ?? '').isNotEmpty
        ? '${arguments['firstName']}'
        : '';
    countChildrenController.text =
        (arguments['countChildren'] ?? '').toString().isNotEmpty
            ? '${arguments['countChildren']}'
            : '';
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['email']),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                          hintText:
                              (arguments['seriesPassport'] ?? '').isNotEmpty
                                  ? '${arguments['seriesPassport']}'
                                  : 'Серия паспорта',
                          obscureText: false,
                          controller: seriesPassportController),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: MyTextField(
                          hintText:
                              (arguments['numberPassport'] ?? '').isNotEmpty
                                  ? '${arguments['numberPassport']}'
                                  : 'Номер паспорта',
                          obscureText: false,
                          controller: numberPassportController),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: MyTextField(
                    hintText: (arguments['lastName'] ?? '').isNotEmpty
                        ? '${arguments['lastName']}'
                        : 'Фамилия',
                    obscureText: false,
                    controller: lastNameController),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: MyTextField(
                    hintText: (arguments['firstName'] ?? '').isNotEmpty
                        ? '${arguments['firstName']}'
                        : 'Имя',
                    obscureText: false,
                    controller: firstNameController),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: MyTextField(
                    hintText: (arguments['fatherName'] ?? '').isNotEmpty
                        ? '${arguments['fatherName']}'
                        : 'Отчество (как в паспорте)',
                    obscureText: false,
                    controller: fatherNameController),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Пол:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Radio(
                          activeColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          value: Gender.male,
                          groupValue: selectedGender,
                          onChanged: (Gender? value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                        const Text('Мужской'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          activeColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          value: Gender.female,
                          groupValue: selectedGender,
                          onChanged: (Gender? value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                        const Text('Женский'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: MyTextField(
                    hintText:
                        (arguments['countChildren'] ?? '').toString().isNotEmpty
                            ? '${arguments['countChildren']}'
                            : 'Количество детей',
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
                      padding: const EdgeInsets.all(15),
                      child: const Text(
                        textAlign: TextAlign.center,
                        'Сохранить',
                        style: TextStyle(fontSize: 25),
                      ),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
