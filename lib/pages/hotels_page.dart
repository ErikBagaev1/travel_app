import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/components/my_card.dart';
import 'package:social_network/components/my_drawer.dart';
import 'package:social_network/provider/hotels_provider.dart';

class HotelsPage extends StatelessWidget {
  const HotelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arrayHotelProvider =
        Provider.of<HotelProvider>(context, listen: false);
    arrayHotelProvider.initializeData();
    final hotels = arrayHotelProvider.hotels;

    final theme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Отели'),
        ),
        drawer: const MyDrawer(),
        backgroundColor: theme.background,
        body: MyGrid(hotels: hotels));
  }
}
