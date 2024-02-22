import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/models/hotels_model.dart';
import 'package:social_network/provider/hotels_provider.dart';

class MyGrid extends StatelessWidget {
  const MyGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Hotel?>(
      builder: (context, hotel, _) {
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
              selectedHotel: hotel,
            );
          },
        );
      },
    );
  }
}

class GridItem extends StatelessWidget {
  final int index;
  final Hotel? selectedHotel;

  const GridItem({
    Key? key,
    required this.index,
    required this.selectedHotel, // Сделать selectedHotel nullable
  }) : super(key: key);

  Future<void> _navigateToHotelAboutPage(context) async {
    final selectedHotelProvider =
        Provider.of<HotelProvider>(context, listen: false);
    final selectedHotel = await selectedHotelProvider.getHotelByIndex();
    selectedHotelProvider.selectHotel(selectedHotel!);

    // Теперь мы можем использовать навигацию без BuildContext в асинхронной функции
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
                    // child: CachedNetworkImage(
                    //   imageUrl: selectedHotel?.photos[1] ?? '',
                    //   fit: BoxFit.cover,
                    //   placeholder: (context, url) =>
                    //       const CircularProgressIndicator(), // Круг загрузки во время загрузки изображения
                    //   errorWidget: (context, url, error) => const Icon(Icons
                    //       .error), // Отображение иконки ошибки при неудачной загрузке изображения
                    // ),
                  ),
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
                          (selectedHotel?.stars ?? 6) > 5 ? 5 : index + 1,
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
