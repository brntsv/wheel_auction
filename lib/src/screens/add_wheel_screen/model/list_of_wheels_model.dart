import 'package:flutter/material.dart';

class ListOfWheelsModel with ChangeNotifier {
  /// Внутреннее приватное состояние колес.
  final List<String?> _items = [];

  /// представление названий колес.
  List<String?> get wheels => _items;

  /// Внутреннее приватное состояние событий.
  final List<List<String?>> _listEvents = [];

  /// представление событий колес.
  List<List<String?>> get events => _listEvents;

  /// метод добавления колеса в список колес
  void addNameWheel(String? nameOfWheel) {
    _items.insert(0, nameOfWheel);
    notifyListeners();
  }

  /// метод добавления событий колеса в список событий
  void addListOfEvents(List<String?> listOfEvents) {
    _listEvents.insert(0, listOfEvents);
    notifyListeners();
  }
}




































/// Сохранил старые версии пока что


// class WheelObject {
//   final String? nameOfWheel;
//   final List<String> eventOptions;
//   WheelObject({
//     required this.nameOfWheel,
//     required this.eventOptions,
//   });
// }

// class ListOfWheelsModel with ChangeNotifier {
//   /// Внутреннее приватное состояние колес.
//   final List<WheelObject> _items = [];

//   /// Неизменяемое представление колес.
//   List<WheelObject> get wheels => _items;

//   /// метод добавления колеса в список колес
//   void addWheel(WheelObject item) {
//     _items.add(item);
//     notifyListeners();
//   }

//   /// метод удаления колеса
//   void removeWheel(WheelObject item) {
//     _items.remove(item);
//     notifyListeners();
//   }
// }



/*

   добавление колеса в список колес
  void addWheel(Wheel titleOfWheel) {
    _titlesOfWheels.add(titleOfWheel);
    notifyListeners();
  }

   удаление колеса из списка колес
  void deleteWheel(int index) {
    _titlesOfWheels.removeAt(index);
    notifyListeners();
  }

  List<String> list = [];

  void addWheel(String nameWheel) {
    list.add(nameWheel);
    notifyListeners();
  }

  void deleteWheel(int index) {
    list.removeAt(index);
    notifyListeners();
  }
  */