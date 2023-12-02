import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade700,
      background: Colors.grey.shade900,
      inversePrimary: Colors.grey.shade300,
    ),
    textTheme: ThemeData.dark()
        .textTheme
        .apply(bodyColor: Colors.grey[300], displayColor: Colors.white));
