import 'package:flutter/material.dart';
import 'package:wheel_auction/resources/app_images.dart';

class SettingsOfWheelModel extends ChangeNotifier {
  bool _selectedDirection = false;
  bool get clockwise => _selectedDirection == false;

  Duration _seconds = const Duration(seconds: 5);
  Duration get selectedSeconds => _seconds;

  String _gif = AppImages.whiteCat;
  String get selectedGif => _gif;

  /// Смена направления кручения колеса
  void changeDirectionRoll(bool isOn) {
    _selectedDirection = isOn ? true : false;
    notifyListeners();
  }

  /// Смена времени кручения колеса
  void changeDuration(Duration value) {
    _seconds = value;
    notifyListeners();
  }

  /// Смена гифки в центре колеса
  void changeGifCenter(String gif) {
    _gif = gif;
    notifyListeners();
  }
}
