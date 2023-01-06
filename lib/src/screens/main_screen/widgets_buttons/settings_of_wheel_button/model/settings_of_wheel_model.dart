import 'package:flutter/material.dart';

class SettingsOfWheelModel extends ChangeNotifier {
  bool selectedDirection = false;
  bool get clockwise => selectedDirection == false;

  Duration _seconds = const Duration(seconds: 5);
  Duration get selectedSeconds => _seconds;

  /// Смена направления кручения колеса
  void changeDirectionRoll(bool isOn) {
    selectedDirection = isOn ? true : false;
    notifyListeners();
  }

  /// Смена времени кручения колеса
  void changeDuration(Duration value) {
    _seconds = value;
  }
}
