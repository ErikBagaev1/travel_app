import 'package:flutter/material.dart';
import 'package:social_network/components/my_grid_comfort.dart';
import 'package:social_network/models/hotels_model.dart';

class SecondBlockAboutHotel extends StatelessWidget {
  const SecondBlockAboutHotel({
    super.key,
    required this.selectedHotel,
  });

  final Hotel? selectedHotel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              selectedHotel?.about ?? 'Ничего',
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
    );
  }
}
