import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/components/blockAboutHotel/first_block_about_hotel.dart';
import 'package:social_network/components/blockAboutHotel/second_block_about_hotel.dart';
import 'package:social_network/components/my_blue_button.dart';
import 'package:social_network/models/hotels_model.dart';
import 'package:social_network/provider/hotels_provider.dart';

class HotelAbout extends StatelessWidget {
  const HotelAbout({super.key});

  @override
  Widget build(BuildContext context) {
    HotelProvider hotelProvider = Provider.of<HotelProvider>(context);
    Hotel? selectedHotel = hotelProvider.selectedHotel;

    if (selectedHotel == null) {
      return Container();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),
      appBar: AppBar(
        centerTitle: true,
        title: Text(selectedHotel.name),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              FirstBlockAboutHotel(selectedHotel: selectedHotel),
              const SizedBox(
                height: 12,
              ),
              SecondBlockAboutHotel(selectedHotel: selectedHotel),
              const Padding(
                padding:
                    EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 8),
                child: MyBlueButton(
                  path: '/hotel_room_page',
                  title: 'К выбору номера',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
