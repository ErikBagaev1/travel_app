import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(currentUser!.email)
          .get();

      return snapshot.data();
    } catch (error) {
      print('Error getting user data: $error');
      // Обработайте ошибку по вашему усмотрению
      return null;
    }
  }

  // Future<void> updateUserData(
  //     String userEmail, Map<String, dynamic> userData) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(userEmail)
  //         .update(userData);
  //   } catch (error) {
  //     print('Error updating user data: $error');
  //     // Обработайте ошибку по вашему усмотрению
  //   }
  // }
}
