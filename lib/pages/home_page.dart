import 'package:flutter/material.dart';
import 'package:social_network/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: const Text('Домашняя страница'),
      ),
      drawer: const MyDrawer(),
    );
  }
}
