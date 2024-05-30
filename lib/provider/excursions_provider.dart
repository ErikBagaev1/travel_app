import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_network/models/excursions_model.dart';

class ExcursionsProvider extends ChangeNotifier {
  Excursions? _selectedExcursions;

  Excursions? get selectedHotel => _selectedExcursions;

  void selectHotel(Excursions excursions) {
    _selectedExcursions = excursions;
    notifyListeners();
  }

  final List<Excursions> _excursions = [];

  List<Excursions> get excursions => _excursions;

  // Метод для предварительной загрузки данных
  void initializeData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('excursions').get();

      _excursions.clear();

      for (var doc in querySnapshot.docs) {
        List<dynamic> photosData = doc['photo'];
        List<String> photos =
            photosData.map((photo) => photo.toString()).toList();

        Excursions excursions = Excursions(
          name: doc['name'],
          photos: photos,
          description: doc['description'],
          date: doc['date_evente'],
          price: doc['price'],
        );

        _excursions.add(excursions);
      }

      notifyListeners();
    } catch (error) {
      throw Exception('Ошибка при получении данных об экскурчиях: $error');
    }
  }

  Future<Excursions?> getHotelByIndex() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc('Vladikavkaz')
          .get();
      if (doc.exists) {
        List<dynamic> photosData = doc['photo'];
        List<String> photos =
            photosData.map((photo) => photo.toString()).toList();
        return Excursions(
          name: doc['name'],
          photos: photos,
          description: doc['description'],
          date: doc['date'],
          price: doc['price'],
        );
      } else {
        throw Exception('Данные об отелях не найдены');
      }
    } catch (error) {
      throw Exception('Ошибка при получении данных об отеле: $error');
    }
  }
}
