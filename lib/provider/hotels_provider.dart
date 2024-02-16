import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_network/models/hotels_model.dart';

class HotelProvider extends ChangeNotifier {
  Hotel? _selectedHotel;
  Map<String, dynamic>? _roomData;

  Map<String, dynamic>? get roomData => _roomData;
  Hotel? get selectedHotel => _selectedHotel;

  void selectHotel(Hotel hotel) {
    _selectedHotel = hotel;
    notifyListeners();
  }

  Future<Hotel> getHotelByIndex() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc('Vladikavkaz')
          .get();
      if (doc.exists) {
        String nightPrice = doc['price'].toString();
        List<dynamic> photosData = doc['photo'];
        List<String> photos =
            photosData.map((photo) => photo.toString()).toList();
        return Hotel(
          stars: doc['stars'],
          name: doc['name'],
          id: doc['hotels_id'],
          photos: photos,
          location: doc['location'],
          about: doc['about'],
          nightPrice: nightPrice,
        );
      } else {
        throw Exception('Данные об отелях не найдены');
      }
    } catch (error) {
      throw Exception('Ошибка при получении данных об отеле: $error');
    }
  }
}
