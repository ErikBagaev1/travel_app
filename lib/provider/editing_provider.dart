import 'package:flutter/material.dart';

enum Gender { male, female }

class GenderProvider extends ChangeNotifier {
  Gender _selectedGender = Gender.male;

  Gender get selectedGender => _selectedGender;

  void setGender(Gender newGender) {
    _selectedGender = newGender;
    notifyListeners();
  }
}
