import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/components/my_gender_selection.dart';
import 'package:social_network/components/my_textfield.dart';
import 'package:social_network/helper/helper_function.dart';
import 'package:social_network/provider/editing_provider.dart';
import 'package:social_network/provider/user_data_provider.dart';

enum Gender { male, female }

class EditingPage extends StatefulWidget {
  const EditingPage({Key? key}) : super(key: key);

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

  //----------------------------------------------------------------------------

  void _saveChanges(arguments, context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      String userEmail = arguments['email'];
      int countChildren = int.tryParse(countChildrenController.text) ?? 0;
      final genderProvider =
          Provider.of<GenderProvider>(context, listen: false);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userEmail)
          .update({
        'seriesPassport': seriesPassportController.text,
        'numberPassport': numberPassportController.text,
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'fatherName': fatherNameController.text,
        'gender': genderProvider.selectedGender == Gender.male
            ? 'Мужской'
            : 'Женский',
        'countChildren': countChildren,
      });
      final model = Provider.of<UserDataProvider>(context, listen: false);
      Map<String, dynamic>? userDetails = await model.fetchUserDetails();
      model.setUserData(userDetails);
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
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        padding: 10,
                        hintText: 'Серия паспорта',
                        obscureText: false,
                        controller: seriesPassportController),
                  ),
                  Expanded(
                    child: MyTextField(
                        padding: 10,
                        hintText: 'Номер паспорта',
                        obscureText: false,
                        controller: numberPassportController),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  padding: 10,
                  hintText: 'Фамилия',
                  obscureText: false,
                  controller: lastNameController),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  padding: 10,
                  hintText: 'Имя',
                  obscureText: false,
                  controller: firstNameController),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  padding: 10,
                  hintText: 'Отчество (как в паспорте)',
                  obscureText: false,
                  controller: fatherNameController),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Consumer<GenderProvider>(
                  builder: (context, genderProvider, child) {
                    return const GenderSelectionWidget();
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  padding: 10,
                  hintText: 'Количество детей',
                  obscureText: false,
                  controller: countChildrenController),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                    onTap: () {
                      final genderProvider =
                          Provider.of<GenderProvider>(context, listen: false);
                      _saveChanges(arguments, context);
                      print(genderProvider.selectedGender);
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
