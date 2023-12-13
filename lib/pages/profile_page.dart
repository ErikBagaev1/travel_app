import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/components/my_expanded.dart';
import 'package:social_network/models/user_data.dart';

// class ProfilePage extends StatelessWidget {
//   ProfilePage({super.key});
//   final User? currentUser = FirebaseAuth.instance.currentUser;

//   Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
//     return await FirebaseFirestore.instance
//         .collection("Users")
//         .doc(currentUser!.email)
//         .get();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).colorScheme;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Профиль'),
//       ),
//       backgroundColor: theme.background,
//       body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//         future: getUserDetails(),

//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.data}');
//           } else if (snapshot.hasData) {
//             Map<String, dynamic>? user = snapshot.data!.data();
//             return Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       const SizedBox(
//                         height: 25,
//                       ),
//                       Container(
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                 width: 1,
//                               ),
//                               color: theme.primary,
//                               borderRadius: BorderRadius.circular(18)),
//                           padding: const EdgeInsets.all(25),
//                           child: const Icon(
//                             Icons.person,
//                             size: 88,
//                           )),
//                       const SizedBox(
//                         height: 25,
//                       ),
//                       MyExpanded(
//                         left: 'Имя',
//                         right: user!['username'],
//                       ),
//                       MyExpanded(
//                         left: 'Email',
//                         right: user['email'],
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: InkWell(
//                         onTap: () {
//                           Navigator.pushNamed(context, '/editing_page',
//                               arguments: user);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: theme.primary,
//                               border: Border.all(
//                                 width:
//                                     1, //                   <--- border width here
//                               ),
//                               borderRadius: BorderRadius.circular(18)),
//                           padding: const EdgeInsets.all(25),
//                           child: const Text(
//                             textAlign: TextAlign.center,
//                             'Редактировать данные',
//                             style: TextStyle(fontSize: 25),
//                           ),
//                         )),
//                   )
//                 ],
//               ),
//             );
//           } else {
//             return const Text('No data');
//           }
//         },
//       ),
//     );
//   }
// }
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
    final userDataProvider = Provider.of<UserDataProvider>(context);
    Map<String, dynamic>? user = userDataProvider.userData;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Профиль'),
      ),
      backgroundColor: theme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
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
                      // Создаем виджеты для отображения данных из документа
                      for (var entry in user!.entries)
                        MyExpanded(
                          left: entry.key,
                          right: entry.value.toString(),
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
                          userDataProvider.setUserData(
                              updatedData as Map<String, dynamic>?);
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
                        padding: const EdgeInsets.all(25),
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
            );
          } else {
            return const Text('No data');
          }
        },
      ),
    );
  }
}
