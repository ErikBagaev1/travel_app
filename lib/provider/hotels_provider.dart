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

  Future<void> fetchRooms(int hotelId) async {
    try {
      rooms.clear();

      // Получаем ссылку на коллекцию Room
      CollectionReference roomCollection =
          FirebaseFirestore.instance.collection('Room');

      // Запрашиваем документы в коллекции, фильтруя по hotelId
      QuerySnapshot roomDocs =
          await roomCollection.where('hotel_id', isEqualTo: hotelId).get();

      // Проходимся по каждому документу в коллекции и добавляем его в список rooms
      for (var roomDoc in roomDocs.docs) {
        Map<String, dynamic> data = roomDoc.data() as Map<String, dynamic>;

        rooms.add(RoomModel.fromMap(data));
      }

      notifyListeners();
    } catch (error) {
      print("Ошибка при получении данных о номерах: $error");
      throw Exception('Ошибка при получении данных о номерах: $error');
    }
  }
}
