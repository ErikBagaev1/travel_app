import 'package:flutter/material.dart';
import 'package:social_network/models/person_model.dart';

class PersonDataProvider extends ChangeNotifier {
  final Person _person = Person();

  Person get person => _person;

  void updatePerson(
      {String? firstName,
      String? lastName,
      String? fatherName,
      int? countChildren,
      int? numberPassport,
      int? seriesPassport,
      String? email}) {
    _person.firstName = firstName ?? _person.firstName;
    _person.lastName = lastName ?? _person.lastName;
    _person.fatherName = fatherName ?? _person.fatherName;
    _person.countChildren = countChildren ?? _person.countChildren;
    _person.numberPassport = numberPassport ?? _person.numberPassport;
    _person.seriesPassport = seriesPassport ?? _person.seriesPassport;
    _person.email = email ?? _person.email;
    notifyListeners();
  
  }
}
