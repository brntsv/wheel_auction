import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  final bool isSwitched;
  final double currentSliderValue;
  final bool clockwise;
  final String gif;
  Settings({
    required this.isSwitched,
    required this.currentSliderValue,
    required this.clockwise,
    required this.gif,
  });
}

class SettingsDataSaver {
  final sharedPreferences = SharedPreferences.getInstance();

  Future<Settings> loadValue() async {
    final isSwitched =
        (await sharedPreferences).getBool('is_switched') ?? false;
    final currentSliderValue =
        (await sharedPreferences).getDouble('current_slider_value') ?? 5.0;
    final clockwise = (await sharedPreferences).getBool('clockwise') ?? false;
    final gif = (await sharedPreferences).getString('gif') ?? '';
    return Settings(
      isSwitched: isSwitched,
      currentSliderValue: currentSliderValue,
      clockwise: clockwise,
      gif: gif,
    );
  }

  Future<void> saveToggleValue(bool isSwitched) async {
    (await sharedPreferences).setBool('is_switched', isSwitched);
  }

  Future<void> saveSliderValue(double currentSliderValue) async {
    (await sharedPreferences)
        .setDouble('current_slider_value', currentSliderValue);
  }

  Future<void> saveClockwise(bool clockwise) async {
    (await sharedPreferences).setBool('clockwise', clockwise);
  }

  Future<void> saveGif(String gif) async {
    (await sharedPreferences).setString('gif', gif);
  }
}
