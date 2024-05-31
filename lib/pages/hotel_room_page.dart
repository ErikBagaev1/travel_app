import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/components/my_room_card.dart';
import 'package:social_network/provider/hotels_provider.dart';

class HotelRoomPage extends StatefulWidget {
  const HotelRoomPage({super.key});

  @override
  _HotelRoomPageState createState() => _HotelRoomPageState();
}

class _HotelRoomPageState extends State<HotelRoomPage> {
  @override
  void initState() {
    super.initState();
    final hotelProvider = Provider.of<HotelProvider>(context, listen: false);
    final selectedHotel = hotelProvider.selectedHotel;
    if (selectedHotel != null) {
      hotelProvider.fetchRooms(selectedHotel.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),
      appBar: AppBar(
        centerTitle: true,
        title: Consumer<HotelProvider>(
          builder: (context, provider, child) {
            return Text(provider.selectedHotel?.name ?? 'Hotel Rooms');
          },
        ),
      ),
      body: Consumer<HotelProvider>(
        builder: (context, provider, child) {
          if (provider.rooms.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: provider.rooms.length,
              itemBuilder: (context, index) {
                final room = provider.rooms[index];
                return MyRoomCard(room: room);
              },
            );
          }
        },
      ),
    );
  }
}
