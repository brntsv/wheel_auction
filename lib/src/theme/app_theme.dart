import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode selectedThemeMode = ThemeMode.dark;

  bool get isDarkMode => selectedThemeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    selectedThemeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static const _defaultFontFamily = 'Roboto';
  static final darkTheme = ThemeData(
    primaryColor: Colors.black,
    primaryColorLight: Colors.grey.shade800,
    scaffoldBackgroundColor: Colors.grey.shade900,
    cardColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
    fontFamily: _defaultFontFamily,
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: Colors.white),
    ),
    // iconTheme: const IconThemeData(color: Colors.amberAccent),
  );
  static final lightTheme = ThemeData(
    primaryColor: Colors.white,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.grey.shade200,
    colorScheme: const ColorScheme.light(),
    fontFamily: _defaultFontFamily,
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: Colors.black),
    ),
    // iconTheme: const IconThemeData(color: Colors.amberAccent),
  );
}
