import 'package:flutter/material.dart';

class SettingsOfWheelModel extends ChangeNotifier {
  bool selectedDirection = false;
  bool get clockwise => selectedDirection == false;

  void changeDirectionRoll(bool isOff) {
    selectedDirection = isOff ? false : true;
    notifyListeners();
  }
}
