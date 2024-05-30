import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/models/booking_model.dart';
import 'package:social_network/provider/hotels_provider.dart';
import 'package:social_network/provider/user_data_provider.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _checkInController = TextEditingController();
  final TextEditingController _checkOutController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Цвет акцентов (выбранная дата)
              onPrimary: Colors.white, // Цвет текста на кнопках
              onSurface: Colors.black, // Цвет текста на датах
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme
                  .primary, // Цвет текста на кнопках "OK" и "CANCEL"
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        controller.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserDataProvider userDataProvider = Provider.of<UserDataProvider>(context);
    var currentUser = userDataProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Бронирование номера'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _checkInController,
                decoration: const InputDecoration(
                  labelText: 'Дата заезда',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите дату заезда';
                  }
                  return null;
                },
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await _selectDate(_checkInController);
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _checkOutController,
                decoration: const InputDecoration(
                  labelText: 'Дата выезда',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите дату выезда';
                  }
                  return null;
                },
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await _selectDate(_checkOutController);
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'ФИО жильца',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите ФИО';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Номер телефона',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите номер телефона';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Цвет кнопки
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BookingModel booking = BookingModel(
                      checkIn: _checkInController.text,
                      checkOut: _checkOutController.text,
                      guestName: _nameController.text,
                      phone: _phoneController.text,
                      userId: currentUser?.uid ??
                          '', // Используем ID текущего пользователя
                    );
                    Provider.of<HotelProvider>(context, listen: false)
                        .addBooking(booking);

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Успех'),
                          content:
                              const Text('Бронирование успешно добавлено.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Закрыть всплывающее окно
                                Navigator.pop(
                                    context); // Вернуться на предыдущую страницу
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Забронировать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
