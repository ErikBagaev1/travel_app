import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_network/auth/auth.dart';
import 'package:social_network/auth/login_on_register.dart';
import 'package:social_network/pages/editing_page.dart';
import 'package:social_network/pages/home_page.dart';
import 'package:social_network/pages/profile_page.dart';
import 'package:social_network/pages/users_page.dart';
import 'package:social_network/theme/dark_mode.dart';
import 'package:social_network/theme/light_mode.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register_page': (context) => const LoginOnRegister(),
        '/home_page': (context) => const HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/users_page': (context) => const UsersPage(),
        '/editing_page': (context) => const EditingPage(),
      },
    );
  }
}
