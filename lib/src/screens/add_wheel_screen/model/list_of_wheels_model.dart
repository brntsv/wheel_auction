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

  /// Внутреннее приватное состояние веса по секторам.
  final List<List<double?>> _listWeights = [];

  /// представление веса секторов.
  List<List<double?>> get weights => _listWeights;

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

  /// метод добавления веса каждого события
  void addWeightsOfEvents(List<double?> listOfWeights) {
    _listWeights.insert(0, listOfWeights);
    notifyListeners();
  }
}
