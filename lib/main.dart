import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/auth/auth.dart';
import 'package:social_network/auth/login_on_register.dart';
import 'package:social_network/pages/editing_page.dart';
import 'package:social_network/pages/excursions_page.dart';
import 'package:social_network/pages/home_page.dart';
import 'package:social_network/pages/hotel_about_page.dart';
import 'package:social_network/pages/hotel_room_page.dart';
import 'package:social_network/pages/hotels_page.dart';
import 'package:social_network/pages/profile_page.dart';
import 'package:social_network/provider/gender_provider.dart';
import 'package:social_network/provider/hotels_provider.dart';
import 'package:social_network/provider/user_data_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserDataProvider()),
        ChangeNotifierProvider(create: (context) => GenderProvider()),
        ChangeNotifierProvider(
          create: (context) => HotelProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthPage(),
        theme: lightMode,
        darkTheme: darkMode,
        routes: {
          '/login_register_page': (context) => const LoginOnRegister(),
          '/home_page': (context) => const HomePage(),
          '/profile_page': (context) => const ProfilePage(),
          '/editing_page': (context) => const EditingPage(),
          '/excursions_page': (context) => const ExcursionsPage(),
          '/hotels_page': (context) => const HotelsPage(),
          '/hotel_about_page': (context) => const HotelAbout(),
          '/hotel_room_page': (context) => const HotelRoomPage(),
        },
      ),
    );
  }
}
