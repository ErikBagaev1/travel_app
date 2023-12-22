import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/components/my_expanded.dart';
import 'package:social_network/models/user_data.dart';

Map<String, String> fieldNames = {
  'countChildren': 'Количество детей',
  'email': 'Почта',
  'numberPassport': 'Номер паспорта',
  'seriesPassport': 'Серия паспорта',
  'gender': 'Пол',
  'firstName': 'Имя',
  'lastName': 'Фамилия',
  'fatherName': 'Отчество',
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
    userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
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
                    for (var entry in user.entries)
                      Column(
                        children: [
                          const Divider(
                            height: 20,
                          ),
                          MyExpanded(
                            left: fieldNames[entry.key] ??
                                entry.key.toUpperCase(),
                            right: entry.value.toString(),
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
