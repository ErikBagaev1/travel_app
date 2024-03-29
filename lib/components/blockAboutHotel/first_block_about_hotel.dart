import 'package:flutter/material.dart';
import 'package:social_network/models/hotels_model.dart';

class FirstBlockAboutHotel extends StatelessWidget {
  const FirstBlockAboutHotel({
    super.key,
    required this.selectedHotel,
  });

  final Hotel selectedHotel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            AspectRatio(
              aspectRatio: 1.334,
              child: PageView.builder(
                  itemCount: selectedHotel.photos.length,
                  pageSnapping: true,
                  itemBuilder: (context, pagePosition) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        selectedHotel.photos[pagePosition],
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 29,
              decoration: ShapeDecoration(
                color: const Color(0x33FFC600),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFFA800)),
                    Text(
                      "${selectedHotel.stars} ${getRatingText(selectedHotel.stars)}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFFFA800),
                        fontSize: 16,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              selectedHotel.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              selectedHotel.location,
              style: const TextStyle(
                color: Color(0xFF0D72FF),
                fontSize: 14,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  'от ${selectedHotel.nightPrice} ₽',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'за тур с перелётом',
                  style: TextStyle(
                    color: Color(0xFF828796),
                    fontSize: 16,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

String getRatingText(int stars) {
  switch (stars) {
    case 5:
      return 'Превосходно';
    case 4:
      return 'Хорошо';
    case 3:
      return 'Плохо';
    case 2:
      return 'Ужасно';
    case 1:
      return 'Хуже некуда';
    default:
      return 'Неопределено';
  }
}
