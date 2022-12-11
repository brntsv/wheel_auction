import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode selectedThemeMode = ThemeMode.dark;

  bool get isDarkMode => selectedThemeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    selectedThemeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}


/// Заготовка для shared preferences

// class Settings {
//   final bool isOn;

//   Settings(this.isOn);
// }

// class ThemeDataProvider {
//   final sharedPreferences = SharedPreferences.getInstance();

//   Future<Settings> loadThemeValue() async {
//     final isOn = (await sharedPreferences).getBool('is_on') ?? false;

//     return Settings(isOn);
//   }

//   Future<void> saveThemeValue(Settings theme) async {
//     (await sharedPreferences).setBool('is_on', theme.isOn);
//   }
// }
