import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/models/hotels_model.dart';
import 'package:social_network/provider/hotels_provider.dart';

class MyGrid extends StatelessWidget {
  final List<Hotel> hotels;
  const MyGrid({Key? key, required this.hotels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 2,
      ),
      itemCount: hotels.length,
      itemBuilder: (BuildContext context, int index) {
        return GridItem(
          selectedHotel: hotels[index],
        );
      },
    );
  }
}

class GridItem extends StatelessWidget {
  final Hotel? selectedHotel;

  const GridItem({
    Key? key,
    required this.selectedHotel,
  }) : super(key: key);

  Future<void> _navigateToHotelAboutPage(context) async {
    final selectedHotelProvider =
        Provider.of<HotelProvider>(context, listen: false);
    final selectedHotel = await selectedHotelProvider.getHotelByIndex();
    selectedHotelProvider.selectHotel(selectedHotel!);

    Navigator.pushNamed(context, '/hotel_about_page');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: Theme.of(context).colorScheme.secondary,
        onTap: () async {
          await _navigateToHotelAboutPage(context);
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
                        color: Colors.black,
                      ),
                      child: Image.network(
                        selectedHotel?.photos[1] ?? '',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
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
                          (selectedHotel?.stars ?? 6) > 5 ? 5 : 1,
                          (index) => const Icon(
                            Icons.star,
                            color: Color.fromRGBO(255, 215, 0, 1.0),
                            size: 30,
                            shadows: [
                              Shadow(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (selectedHotel != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedHotel?.name ?? '',
                            ),
                            Text(
                              selectedHotel?.location ?? '',
                            ),
                            Text(
                              selectedHotel?.nightPrice.toString() ?? '',
                            ),
                          ],
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
