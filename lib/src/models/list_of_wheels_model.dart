import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../entity/created_wheel.dart';

class ListOfWheelsModel extends ChangeNotifier {
  final String _nameOfWheel = '';
  final List<String> _listOfWheel = [];

  String get nameOfWheel => _nameOfWheel;
  List<String> get listOfWheel => _listOfWheel;

  Future<void> saveListOfWheel(BuildContext context) async {
    if (_nameOfWheel.isEmpty) return;
    if (_listOfWheel.isEmpty) return;

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CreatedWheelAdapter());
    }
    final box = await Hive.openBox<CreatedWheel>('wheels_box');
    final wheel = CreatedWheel(name: _nameOfWheel);
    await box.add(wheel);
    Navigator.of(context).pop();
  }

  void add(String item) {
    listOfWheel.add(item);
    notifyListeners();
  }
}
