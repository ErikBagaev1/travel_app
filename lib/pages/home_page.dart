import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/components/my_drawer.dart';
import 'package:social_network/provider/hotels_provider.dart';
import 'package:social_network/provider/user_data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController searchController = TextEditingController();
String searchQuery = '';

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final arrayHotelProvider =
        Provider.of<HotelProvider>(context, listen: false);
    arrayHotelProvider.initializeData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: const Text('Пользователи'),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: const Color.fromARGB(255, 1, 211, 243),
              controller: searchController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color.fromARGB(255, 1, 211, 243)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusColor: Colors.black,
                labelText: 'Поиск',
                labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 119, 118, 118), fontSize: 16),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: UserDataProvider().getUsersStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Ошибка: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('Нет данных');
                }
                final List<DocumentSnapshot<Map<String, dynamic>>>
                    filteredUsers = snapshot.data!.docs.where((doc) {
                  final data = doc.data(); // Получаем данные документа
                  final String? seriesPassport =
                      data['seriesPassport'] as String?;
                  final String? firstName = data['firstName']
                      as String?; // Безопасная навигация по данным
                  final String? email = data['email']
                      as String?; // Безопасная навигация по данным

                  final String? gender = data['gender'] as String?;
                  final String? passport = data['numberPassport']
                      as String?; // Безопасная навигация по данным
                  final String? lastName = data['lastName'] as String?;
                  final String? fatherName = data['fatherName'] as String?;

                  // Проверяем, содержится ли искомый текст в имени, email или passport пользователя
                  return firstName != null &&
                          firstName
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()) ||
                      email != null &&
                          email
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()) ||
                      passport != null &&
                          passport
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()) ||
                      lastName != null &&
                          lastName
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()) ||
                      fatherName != null &&
                          fatherName
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()) ||
                      seriesPassport != null &&
                          seriesPassport
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()) ||
                      gender != null &&
                          gender
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase());
                }).toList();
                return ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index]
                        .data()!; // Получаем данные пользователя
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    user['lastName'] ?? 'неизвестно',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    user['firstName'] ?? 'неизвестно',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    user['fatherName'] ?? 'неизвестно',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                "Паспортные данные:  ${user['seriesPassport'] ?? 'неизвестно'}  ${user['numberPassport'] ?? 'неизвестно'}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Пол:  ${user['gender'] ?? 'неизвестно'}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "email:  ${user['email'] ?? 'неизвестно'}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
