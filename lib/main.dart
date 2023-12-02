import 'package:flutter/material.dart';
import 'package:social_network/auth/login_on_register.dart';
import 'package:social_network/theme/dark_mode.dart';
import 'package:social_network/theme/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginOnRegister(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
