import 'package:flutter/material.dart';
import 'package:wheel_auction/src/app/app.dart';
import 'package:wheel_auction/src/settings/settings_controller.dart';

void main() async {
  final settingsController = SettingsController();
  runApp(MyApp(settingsController: settingsController));
}
