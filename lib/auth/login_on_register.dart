import 'package:flutter/material.dart';
import 'package:social_network/pages/login_page.dart';
import 'package:social_network/pages/register_page.dart';

class LoginOnRegister extends StatefulWidget {
  const LoginOnRegister({super.key});

  @override
  State<LoginOnRegister> createState() => _LoginOnRegisterState();
}

class _LoginOnRegisterState extends State<LoginOnRegister> {
  bool showLoginPage = true;

  void tooglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: tooglePages);
    } else {
      return RegisterPage(onTap: tooglePages);
    }
  }
}
