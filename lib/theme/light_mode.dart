import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Colors.grey.shade200,
      secondary: Colors.grey.shade500,
      background: Colors.grey.shade300,
      inversePrimary: Colors.grey.shade600,
    ),
    textTheme: ThemeData.light()
        .textTheme
        .apply(bodyColor: Colors.grey[800], displayColor: Colors.grey.shade600),
    appBarTheme: AppBarTheme(
      color: Colors.grey.shade300,
    ));
