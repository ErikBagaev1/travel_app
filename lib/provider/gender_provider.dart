import 'package:flutter/material.dart';
import 'package:social_network/pages/editing_page.dart';

class GenderProvider extends ChangeNotifier {
  Gender _selectedGender = Gender.female;

  Gender get selectedGender => _selectedGender;

  void setGender(Gender newGender) {
    _selectedGender = newGender;
    notifyListeners();
  }
}
