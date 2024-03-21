import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/components/my_button.dart';
import 'package:social_network/components/my_textfield.dart';
import 'package:social_network/provider/user_data_provider.dart';

class LoginPage extends StatefulWidget {
  final Function() onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserDataProvider userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.background,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
            child: ListView(
          children: [
            const SizedBox(
              height: 80,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  size: 80,
                  color: theme.inversePrimary,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Imazing Travel',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                MyTextField(
                   modelIndex: 'email',
                  padding: 0,
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                       padding: 0,
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
                MyButton(
                    text: 'Войти',
                    onTap: () => userDataProvider.login(
                        context, emailController, passwordController)),
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
                      onTap: widget.onTap,
                      child: const Text(
                        ' Зарегистрируйтесь',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
