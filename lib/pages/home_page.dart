import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/components/my_drawer.dart';
import 'package:social_network/provider/hotels_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final arrayHotelProvider =
        Provider.of<HotelProvider>(context, listen: false);
    arrayHotelProvider.initializeData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: const Text('Домашняя страница'),
      ),
      drawer: const MyDrawer(),
    );
  }
}
