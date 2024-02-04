import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/components/first_block_about_hotel.dart';
import 'package:social_network/components/my_grid_comfort.dart';
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
              Container(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Об отеле',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      const Row(
                        children: [
                          MyGridComfort(text: '3-я линия'),
                          SizedBox(
                            width: 8,
                          ),
                          MyGridComfort(text: 'Платный Wi-Fi в фойе'),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
                        children: [
                          MyGridComfort(text: '30 км до аэропорта'),
                          SizedBox(
                            width: 8,
                          ),
                          MyGridComfort(text: '1 км до пляжа'),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Отель VIP-класса с собственными гольф полями. Высокий уровнь сервиса. Рекомендуем для респектабельного отдыха. Отель принимает гостей от 18 лет!',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8999999761581421),
                          fontSize: 16,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
