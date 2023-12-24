import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/components/my_expanded.dart';
import 'package:social_network/provider/user_data_provider.dart';

Map<String, String> fieldNames = {
  'email': 'Почта',
  'lastName': 'Фамилия',
  'firstName': 'Имя',
  'fatherName': 'Отчество',
  'seriesPassport': 'Серия паспорта',
  'numberPassport': 'Номер паспорта',
  'gender': 'Пол',
  'countChildren': 'Количество детей',
};

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  late UserDataProvider userDataProvider;
  @override
  void initState() {
    super.initState();
    userDataProvider = context.read<UserDataProvider>();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    Map<String, dynamic>? userDetails =
        await userDataProvider.fetchUserDetails();
    userDataProvider.setUserData(userDetails);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Профиль'),
        ),
        backgroundColor: theme.background,
        body: Consumer<UserDataProvider>(
          builder: (context, userDataProvider, child) {
            final user = userDataProvider.userData;
            return buildProfileContent(theme, user);
          },
        ));
  }

  Widget buildProfileContent(ColorScheme theme, Map<String, dynamic>? user) {
    return ListView(
      children: [
        if (user != null)
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                        color: theme.primary,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.all(25),
                      child: const Icon(
                        Icons.person,
                        size: 88,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    for (var key in fieldNames.keys)
                      if (user.containsKey(key))
                        Column(
                          children: [
                            const Divider(
                              height: 20,
                            ),
                            MyExpanded(
                              left: fieldNames[key] ?? key.toUpperCase(),
                              right: user[key].toString(),
                            ),
                          ],
                        ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () async {
                      var updatedData = await Navigator.pushNamed(
                        context,
                        '/editing_page',
                        arguments: user,
                      );

                      if (updatedData != null) {
                        userDataProvider
                            .setUserData(updatedData as Map<String, dynamic>?);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.primary,
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: const Text(
                        'Редактировать данные',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
