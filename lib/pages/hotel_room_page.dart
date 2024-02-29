import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/components/my_room_card.dart';
import 'package:social_network/models/hotels_model.dart';
import 'package:social_network/provider/hotels_provider.dart';

class HotelRoomPage extends StatelessWidget {
  const HotelRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    HotelProvider hotelProvider = Provider.of<HotelProvider>(context);
    Hotel? selectedHotel = hotelProvider.selectedHotel;
    final String hotelName = selectedHotel?.name ?? '';
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),
      appBar: AppBar(
        centerTitle: true,
        title: Text(hotelName),
      ),
      body: const Column(
        children: [MyRoomCard()],
      ),
    );
  }
}
