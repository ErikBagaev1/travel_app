import 'package:flutter/material.dart';
import 'package:social_network/components/my_button.dart';
import 'package:social_network/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final Function() onTap;
  LoginPage({super.key, required this.onTap});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void login() {}
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.background,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 80,
              color: theme.inversePrimary,
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Н А Ч А Л О',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            MyTextField(
              hintText: 'Email',
              obscureText: false,
              controller: emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              hintText: 'Пароль',
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Забыли пароль?',
                  style: TextStyle(color: theme.inversePrimary),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(text: 'Войти', onTap: login),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Нет аккаунта?',
                  style: TextStyle(color: theme.inversePrimary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    ' Зарегистрируйтесь',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
