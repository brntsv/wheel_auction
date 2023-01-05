import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  final bool isSwitched;
  final double currentSliderValue;

  Settings({required this.isSwitched, required this.currentSliderValue});
}

class SettingsDataSaver {
  final sharedPreferences = SharedPreferences.getInstance();

  Future<Settings> loadValue() async {
    final isSwitched =
        (await sharedPreferences).getBool('is_switched') ?? false;
    final currentSliderValue =
        (await sharedPreferences).getDouble('current_slider_value') ?? 20.0;
    return Settings(
      isSwitched: isSwitched,
      currentSliderValue: currentSliderValue,
    );
  }

  Future<void> saveToggleValue(Settings toggle) async {
    (await sharedPreferences).setBool('is_switched', toggle.isSwitched);
  }

  Future<void> saveSliderValue(Settings slider) async {
    (await sharedPreferences)
        .setDouble('current_slider_value', slider.currentSliderValue);
  }
}
