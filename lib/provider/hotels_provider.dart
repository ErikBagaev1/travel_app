import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_network/models/hotels_model.dart';

import '../models/booking_model.dart';
import '../models/room_model.dart';

class HotelProvider extends ChangeNotifier {
  Hotel? _selectedHotel;
  Map<String, dynamic>? _roomData;

  Map<String, dynamic>? get roomData => _roomData;
  Hotel? get selectedHotel => _selectedHotel;

  List<RoomModel> rooms = [];
  final List<BookingModel> _bookings = [];

  // Other methods and properties

  void addBooking(BookingModel booking) {
    _bookings.add(booking);

    notifyListeners();
  }

  List<BookingModel> get bookings => _bookings;
  void selectHotel(Hotel hotel) async {
    _selectedHotel = hotel;
    // await fetchRooms(hotel.id); // Fetch rooms after selecting the hotel
    notifyListeners();
  }

  final List<Hotel> _hotels = [];

  List<Hotel> get hotels => _hotels;

  // Method to initialize data
  void initializeData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Hotels').get();

      _hotels.clear();

      for (var doc in querySnapshot.docs) {
        String nightPrice = doc['price'].toString();
        List<dynamic> photosData = doc['photo'];
        List<String> photos =
            photosData.map((photo) => photo.toString()).toList();

        Hotel hotel = Hotel(
          stars: doc['stars'],
          name: doc['name'],
          id: doc['hotels_id'],
          photos: photos,
          location: doc['location'],
          about: doc['about'],
          nightPrice: nightPrice,
        );

        _hotels.add(hotel);
      }

      notifyListeners();
    } catch (error) {
      throw Exception('Ошибка при получении данных об отелях: $error');
    }
  }

  Future<Hotel?> getHotelByIndex() async {
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

  // Future<List<RoomModel>> fetchRooms(int hotelId) async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
  //         .instance
  //         .collection('Room')
  //         .where('luxe', isEqualTo: hotelId)
  //         .get();

  //     if (snapshot.docs.isNotEmpty) {
  //       List<RoomModel> rooms =
  //           snapshot.docs.map((doc) => RoomModel.fromMap(doc.data())).toList();
  //       return rooms;
  //     } else {
  //       throw Exception('Данные об отелях не найдены');
  //     }
  //   } catch (error) {
  //     throw Exception('Ошибка при получении данных об отеле: $error');
  //   }
  // }
}
