import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets_buttons/settings_of_wheel_button/model/settings_of_wheel_model.dart';

class Settings {
  final bool isSwitched;
  final double currentSliderValue;
  final bool clockwise;

  Settings({
    required this.isSwitched,
    required this.currentSliderValue,
    required this.clockwise,
  });
}

class SettingsDataSaver {
  final sharedPreferences = SharedPreferences.getInstance();

  Future<Settings> loadValue() async {
    final isSwitched =
        (await sharedPreferences).getBool('is_switched') ?? false;
    final currentSliderValue =
        (await sharedPreferences).getDouble('current_slider_value') ?? 20.0;
    final clockwise = (await sharedPreferences).getBool('clockwise') ?? false;
    return Settings(
      isSwitched: isSwitched,
      currentSliderValue: currentSliderValue,
      clockwise: clockwise,
    );
  }

  Future<void> saveToggleValue(Settings toggle) async {
    (await sharedPreferences).setBool('is_switched', toggle.isSwitched);
  }

  Future<void> saveSliderValue(Settings slider) async {
    (await sharedPreferences)
        .setDouble('current_slider_value', slider.currentSliderValue);
  }

  Future<void> saveClockwise(Settings toggle) async {
    (await sharedPreferences).setBool('clockwise', toggle.clockwise);
  }
}
