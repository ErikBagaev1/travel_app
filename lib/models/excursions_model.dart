import 'package:cloud_firestore/cloud_firestore.dart';

class Excursions {
  final String name;
  final String description;
  final Timestamp date;
  final int price;
  final List<String> photos;

  const Excursions({
    required this.name,
    required this.description,
    required this.date,
    required this.price,
    required this.photos,
  });
}
