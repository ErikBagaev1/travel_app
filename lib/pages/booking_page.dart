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
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passportNumberController =
      TextEditingController();
  final TextEditingController _passportSeriesController =
      TextEditingController();

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
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _checkInController,
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(
                    labelText: 'Дата заезда',
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
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
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(
                    labelText: 'Дата выезда',
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
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
                  controller: _lastNameController,
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(
                    labelText: 'Фамилия',
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите фамилию';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'Имя',
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите имя';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _middleNameController,
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(
                    labelText: 'Отчество',
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите отчество';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Номер телефона',
                    labelStyle: TextStyle(color: Colors.black),
                    focusColor: Colors.black,
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
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller: _passportNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Номер паспорта',
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите номер паспорта';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller: _passportSeriesController,
                  decoration: const InputDecoration(
                    labelText: 'Серия паспорта',
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите серию паспорта';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BookingModel booking = BookingModel(
                        checkIn: _checkInController.text,
                        checkOut: _checkOutController.text,
                        guestName:
                            "${_lastNameController.text} ${_firstNameController.text} ${_middleNameController.text}",
                        phone: _phoneController.text,
                        passportNumber: _passportNumberController.text,
                        passportSeries: _passportSeriesController.text,
                        userId: currentUser?.uid ?? '',
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
                                  Navigator.of(context).pop();
                                  Navigator.pop(context);
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
      ),
    );
  }
}
