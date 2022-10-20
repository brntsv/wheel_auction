import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/models/list_of_wheels_model.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final settingsController = SettingsController(SettingsService());
  // await settingsController.loadSettings();
  runApp(
    App(settingsController: settingsController),
  );
}
