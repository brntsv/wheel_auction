import 'package:flutter/material.dart';

class MyThemes {
  static const _defaultFontFamily = 'Roboto';
  static final darkTheme = ThemeData(
    primaryColor: const Color.fromRGBO(100, 65, 165, 1.0),
    primaryColorLight: Colors.grey.shade800,
    primaryColorDark: Colors.grey.shade800,
    scaffoldBackgroundColor: Colors.grey.shade900,
    cardColor: Colors.white24,
    toggleableActiveColor: const Color.fromARGB(255, 132, 109, 173),
    colorScheme: const ColorScheme.dark(),
    fontFamily: _defaultFontFamily,
    focusColor: const Color.fromARGB(255, 132, 109, 173),
    textTheme: const TextTheme(
      button: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.white),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Color.fromRGBO(100, 65, 165, 1.0),
    ),
    // iconTheme: const IconThemeData(color: Color.fromARGB(255, 132, 109, 173)),
  );
  static final lightTheme = ThemeData(
    primaryColor: const Color.fromRGBO(100, 65, 165, 1.0),
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.grey.shade300,
    scaffoldBackgroundColor: Colors.grey.shade200,
    cardColor: Colors.grey.shade200,
    toggleableActiveColor: const Color.fromARGB(255, 132, 109, 173),
    colorScheme: const ColorScheme.light(),
    fontFamily: _defaultFontFamily,
    focusColor: const Color.fromARGB(255, 132, 109, 173),
    textTheme: const TextTheme(
      button: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.black),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Color.fromRGBO(100, 65, 165, 1.0),
    ),
    // iconTheme: const IconThemeData(color: Color.fromARGB(255, 132, 109, 173)),
  );
}
