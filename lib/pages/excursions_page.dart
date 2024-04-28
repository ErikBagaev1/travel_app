import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/my_drawer.dart';
import '../components/my_tour_card.dart';

class ExcursionsPage extends StatelessWidget {
  const ExcursionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список экскурсий'),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('excursions').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot? tour = snapshot.data!.docs[index];
              return TourCard(
                name: tour['name'],
                description: tour['description'],
                date: tour['date_evente'],
                price: tour['price'],
                photos: List<String>.from(tour['photo']),
              );
            },
          );
        },
      ),
    );
  }
}
