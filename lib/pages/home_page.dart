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
        title: const Text('Домашняя страница'),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                focusColor: Colors.black,
                labelText: 'Поиск',
                labelStyle: const TextStyle(color: Colors.black),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                      searchQuery = '';
                    });
                  },
                ),
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
                  final String? firstName = data['firstName']
                      as String?; // Безопасная навигация по данным
                  final String? email = data['email']
                      as String?; // Безопасная навигация по данным
                  final String? passport = data['numberPassport']
                      as String?; // Безопасная навигация по данным
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
                              .contains(searchQuery.toLowerCase());
                }).toList();
                return ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index]
                        .data()!; // Получаем данные пользователя
                    return ListTile(
                      title: Text(user['firstName'] ??
                          ''), // Используем пустую строку вместо null
                      subtitle: Text(
                          "паспорт: ${user['numberPassport'] ?? ''}"), // Используем пустую строку вместо null
                      leading: SizedBox(
                        width: 180,
                        child: Text(
                          user['email'] ?? '',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ), // Используем пустую строку вместо null
                      // Добавьте другие поля пользователя по вашему выбору
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
