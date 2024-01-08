import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/models/hotels_mdel.dart';
import 'package:social_network/provider/hotels_provider.dart';

class MyGrid extends StatelessWidget {
  const MyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 2,
      ),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return GridItem(
          index: index,
          name: 'название $index',
          price: 'цена $index',
          distance: 'расстояние $index',
          nightPrice: 'цена $index',
          stars: index + 1,
        );
      },
    );
  }
}

class GridItem extends StatelessWidget {
  final int index;
  final int stars;
  final String name;
  final String price;
  final String distance;
  final String nightPrice;

  const GridItem(
      {Key? key,
      required this.index,
      required this.name,
      required this.price,
      required this.distance,
      required this.nightPrice,
      required this.stars})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HotelProvider hotelProvider =
        Provider.of<HotelProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: Theme.of(context).colorScheme.secondary,
        onTap: () {
          Hotel selectedHotel = Hotel(
            stars: stars > 5 ? 5 : index + 1,
            name: 'Название отеля ${index + 1}',
            distance: 'Растояние до города',
            nightPrice: 'Цена за ночь',
          );
          hotelProvider.selectHotel(selectedHotel);
          Navigator.pushNamed(
            context,
            '/hotel_about_page',
          );
        },
        child: Card(
          elevation: 5,
          shadowColor: Theme.of(context).colorScheme.inversePrimary,
          color: const Color.fromARGB(255, 202, 202, 202),
          child: Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black),
                    ),
                  )),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(
                          stars > 5 ? 5 : index + 1,
                          (index) => const Icon(
                            Icons.star,
                            color: Color.fromRGBO(255, 215, 0, 1.0),
                            size: 30,
                            shadows: [
                              Shadow(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                blurRadius: 6,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        name,
                      ),
                      Text(
                        distance,
                      ),
                      Text(
                        nightPrice,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
