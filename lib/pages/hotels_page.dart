import 'package:flutter/material.dart';
import 'package:social_network/components/my_drawer.dart';
import 'package:social_network/components/my_card.dart';

class HotelsPage extends StatelessWidget {
  const HotelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Отели'),
        ),
        drawer: const MyDrawer(),
        backgroundColor: theme.background,
        body: const MyGrid());
  }
}
