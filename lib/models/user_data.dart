import 'package:flutter/material.dart';

class UserDataProvider with ChangeNotifier {
  Map<String, dynamic>? _userData;

  Map<String, dynamic>? get userData => _userData;

  void setUserData(Map<String, dynamic>? data) {
    _userData = data;
    notifyListeners();
  }
}
