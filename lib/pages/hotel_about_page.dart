import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/models/hotels_mdel.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(selectedHotel.name),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              selectedHotel.stars,
              (index) => const Icon(
                Icons.star,
                color: Color.fromRGBO(255, 215, 0, 1.0),
                size: 40,
                shadows: [
                  Shadow(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    blurRadius: 6,
                  )
                ],
              ),
            ),
          ),
          Text(selectedHotel.distance),
          Text(selectedHotel.nightPrice),
        ],
      ),
    );
  }
}
