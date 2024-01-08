import 'package:flutter/material.dart';
import 'package:social_network/models/hotels_mdel.dart';

class HotelProvider extends ChangeNotifier {
  Hotel? _selectedHotel;

  Hotel? get selectedHotel => _selectedHotel;

  void selectHotel(Hotel hotel) {
    _selectedHotel = hotel;
    notifyListeners();
  }
}
