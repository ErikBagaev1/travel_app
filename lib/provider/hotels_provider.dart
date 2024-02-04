import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_network/models/hotels_mdel.dart';

class HotelProvider extends ChangeNotifier {
  Hotel? _selectedHotel;
  Map<String, dynamic>? _roomData;

  Map<String, dynamic>? get roomData => _roomData;
  Hotel? get selectedHotel => _selectedHotel;

  void selectHotel(Hotel hotel) {
    _selectedHotel = hotel;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> fetchRoomDetails(
      {required String tableName, required String roomId}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(tableName)
        .doc(roomId)
        .get();
    Map<String, dynamic>? roomData = snapshot.data();
    notifyListeners();
    return roomData;
  }
}
