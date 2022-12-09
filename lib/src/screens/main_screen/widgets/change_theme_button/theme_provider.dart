import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode selectedThemeMode = ThemeMode.dark;

  bool get isDarkMode => selectedThemeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    selectedThemeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
