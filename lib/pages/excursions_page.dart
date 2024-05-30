import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/models/excursions_model.dart';
import 'package:social_network/provider/excursions_provider.dart';

import '../components/my_drawer.dart';
import '../components/my_tour_card.dart';

class ExcursionsPage extends StatelessWidget {
  const ExcursionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arrayHotelProvider =
        Provider.of<ExcursionsProvider>(context, listen: false);
    arrayHotelProvider.initializeData();
    final excursions = arrayHotelProvider.excursions;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Список экскурсий'),
          centerTitle: true,
        ),
        drawer: const MyDrawer(),
        body: ListView.builder(
          itemCount: excursions.length,
          itemBuilder: (context, index) {
            Excursions selestExcursions = excursions[index];
            return TourCard(
              name: selestExcursions.name,
              description: selestExcursions.description,
              date: selestExcursions.date,
              price: selestExcursions.price,
              photos: List<String>.from(selestExcursions.photos),
            );
          },
        ));
  }
}
