import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/helper/helper_function.dart';
import 'package:social_network/models/controller_model.dart';
import 'package:social_network/pages/editing_page.dart';
import 'package:social_network/provider/gender_provider.dart';

class UserDataProvider extends ChangeNotifier {
  Map<String, dynamic>? _userData;

  Map<String, dynamic>? get userData => _userData;

  void setUserData(Map<String, dynamic>? userData) {
    _userData = userData;
    notifyListeners();
  }

  User? currentUser;
  Map<String, dynamic>? data;

  Future<Map<String, dynamic>?> fetchUserDetails() async {
    currentUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
    data = snapshot.data();
    notifyListeners();
    return data;
  }

  Future<void> createUsersDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
      });
    }
  }

  void register(
      context, passwordController, confirmController, emailController) async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    if (passwordController.text != confirmController.text) {
      Navigator.pop(context);
      displayMessageToUser("Пароли не совпадают", context);
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        createUsersDocument(userCredential);
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
    }
  }

  void login(context, emailController, passwordController) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  void saveChanges(arguments, context, ControllerModel models) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      String userEmail = arguments['email'];
      int countChildren =
          int.tryParse(models.countChildrenController.text) ?? 0;
      final genderProvider =
          Provider.of<GenderProvider>(context, listen: false);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userEmail)
          .update({
        'seriesPassport': models.seriesPassportController.text,
        'numberPassport': models.numberPassportController.text,
        'firstName': models.firstNameController.text,
        'lastName': models.lastNameController.text,
        'fatherName': models.fatherNameController.text,
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
}
