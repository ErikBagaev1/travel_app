import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
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
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.data}');
          } else if (snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data!.data();
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width:
                                    1, //                   <--- border width here
                              ),
                              color: theme.primary,
                              borderRadius: BorderRadius.circular(18)),
                          padding: const EdgeInsets.all(25),
                          child: const Icon(
                            Icons.person,
                            size: 88,
                          )),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Имя:',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                user!['username'],
                                style: const TextStyle(fontSize: 21),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Email:',
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            user['email'],
                            style: const TextStyle(fontSize: 21),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: theme.primary,
                              border: Border.all(
                                width:
                                    1, //                   <--- border width here
                              ),
                              borderRadius: BorderRadius.circular(18)),
                          padding: const EdgeInsets.all(25),
                          child: const Text(
                            textAlign: TextAlign.center,
                            'Редактировать данные',
                            style: TextStyle(fontSize: 25),
                          ),
                        )),
                  )
                ],
              ),
            );
          } else {
            return const Text('No data');
          }
        },
      ),
    );
  }
}
