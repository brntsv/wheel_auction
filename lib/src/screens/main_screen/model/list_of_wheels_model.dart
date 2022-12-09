import 'package:flutter/material.dart';

class ListOfWheelsModel with ChangeNotifier {
  //
  //  список самих колес
  // final List<Wheel> _titlesOfWheels = [];
  // List<Wheel> get wheels => _titlesOfWheels;

  //  список вариантов в колесе
  // final List<List<String>> _listOfVariants = [];
  // List<List<String>> get listOfVariants => _listOfVariants;

  //  добавление колеса в список колес
  // void addWheel(Wheel titleOfWheel) {
  //   _titlesOfWheels.add(titleOfWheel);
  //   notifyListeners();
  // }

  //  удаление колеса из списка колес
  // void deleteWheel(int index) {
  //   _titlesOfWheels.removeAt(index);
  //   notifyListeners();
  // }

  List<String> list = [];

  void addWheel(String nameWheel) {
    list.add(nameWheel);
    notifyListeners();
  }

  void deleteWheel(int index) {
    list.removeAt(index);
    notifyListeners();
  }
}
