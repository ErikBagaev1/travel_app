import 'package:flutter/material.dart';
import 'package:social_network/components/my_blue_button.dart';
import 'package:social_network/components/my_grid_comfort.dart';
import 'package:social_network/models/room_model.dart';

class MyRoomCard extends StatelessWidget {
  final RoomModel room;

  const MyRoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).colorScheme.background,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 18.0,
                ),
                child: AspectRatio(
                  aspectRatio: 1.4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: NetworkImage(room.photo.isNotEmpty
                            ? room.photo[0]
                            : 'https://via.placeholder.com/150'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                room.name,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyGridComfort(text: 'Все включено'),
                  SizedBox(
                    width: 20,
                  ),
                  MyGridComfort(text: 'Кондиционер')
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'от ${room.price} ₽',
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
              ),
              const SizedBox(
                height: 10,
              ),
              const MyBlueButton(
                path: '/booking_page',
                title: 'Выбрать номер',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
