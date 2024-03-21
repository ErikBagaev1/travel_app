import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/components/my_gender_selection.dart';
import 'package:social_network/components/my_textfield.dart';
import 'package:social_network/models/controller_model.dart';
import 'package:social_network/provider/gender_provider.dart';
import 'package:social_network/provider/user_data_provider.dart';

enum Gender { male, female }

class EditingPage extends StatefulWidget {
  const EditingPage({Key? key}) : super(key: key);

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  final models = ControllerModel();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataProvider>(context, listen: false);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    models.seriesPassportController.text =
        (arguments['seriesPassport'] ?? '').isNotEmpty
            ? '${arguments['seriesPassport']}'
            : '';

    models.numberPassportController.text =
        (arguments['numberPassport'] ?? '').isNotEmpty
            ? '${arguments['numberPassport']}'
            : '';
    models.fatherNameController.text =
        (arguments['fatherName'] ?? '').isNotEmpty
            ? '${arguments['fatherName']}'
            : '';

    models.lastNameController.text = (arguments['lastName'] ?? '').isNotEmpty
        ? '${arguments['lastName']}'
        : '';

    models.firstNameController.text = (arguments['firstName'] ?? '').isNotEmpty
        ? '${arguments['firstName']}'
        : '';
    models.countChildrenController.text =
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
                      modelIndex: 'numberPassport',
                        padding: 10,
                        hintText: 'Серия паспорта',
                        obscureText: false,
                        controller: models.seriesPassportController),
                  ),
                  Expanded(
                    child: MyTextField(
                      modelIndex:'seriesPassport' ,
                        padding: 10,
                        hintText: 'Номер паспорта',
                        obscureText: false,
                        controller: models.numberPassportController),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                modelIndex: 'lastName',
                  padding: 10,
                  hintText: 'Фамилия',
                  obscureText: false,
                  controller: models.lastNameController),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                 modelIndex: 'firstName',
                  padding: 10,
                  hintText: 'Имя',
                  obscureText: false,
                  controller: models.firstNameController),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                 modelIndex: 'fatherName',
                  padding: 10,
                  hintText: 'Отчество (как в паспорте)',
                  obscureText: false,
                  controller: models.fatherNameController),
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
                 modelIndex: 'countChildren',
                  padding: 10,
                  hintText: 'Количество детей',
                  obscureText: false,
                  controller: models.countChildrenController),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                    onTap: () {
                      userData.saveChanges(arguments, context, models);
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
