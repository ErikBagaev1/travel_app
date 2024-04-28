import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TourCard extends StatelessWidget {
  final String name;
  final String description;
  final Timestamp date;
  final int price;
  final List<String> photos;

  const TourCard({
    super.key,
    required this.name,
    required this.description,
    required this.date,
    required this.price,
    required this.photos,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = date.toDate();
    // Форматируем дату в строку с помощью DateFormat
    // String formattedDate = DateFormat('dd.MM.yyyy').format(dateTime);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        // Виджет для отображения информации о туре
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: photos.isEmpty
                        ? const CircularProgressIndicator(
                            color: Colors.green,
                          ) // Показываем круг загрузки, если фото еще не загрузились
                        : Image.network(
                            photos[0],
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                name,
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    DateFormat('dd.MM.yyyy').format(dateTime),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Text(DateFormat('HH:mm').format(dateTime),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 46, 47, 46))),
                ],
              ),
            ),
            ListTile(
              leading: const Text(
                'Цена с человека:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              title: Text(
                ' $price ₽',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 52, 148, 55)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
