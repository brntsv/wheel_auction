import 'package:flutter/material.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_sector.dart';

import 'package:wheel_auction/src/screens/main_screen/wheel/painter/helpers.dart'
    show DoubleSum, IndexBuilder;

/// Опишите всё колесо
class WheelGroup {
  /// Создайте группу колеса с заданными [sectors].
  WheelGroup(this.sectors);

  /// Хэлпер для создания колеса [WheelGroup].
  /// [itemCount] это количество элементов в группе.
  /// [textBuilder] это функция, которая возвращает текст единицы измерения.
  /// [colorBuilder] это функция, которая возвращает цвет единицы измерения.
  /// [textStyleBuilder] это функция, которая возвращает текстовый стиль блока.

  factory WheelGroup.uniform(
    int itemCount, {
    IndexBuilder<String?>? textBuilder,
    IndexBuilder<Color>? colorBuilder,
    IndexBuilder<TextStyle?>? textStyleBuilder,
    IndexBuilder<double?>? weightBuilder,
  }) {
    final sectors = List.generate(
      itemCount,
      (index) => WheelSector(
        text: textBuilder?.call(index),
        textStyle: textStyleBuilder?.call(index),
        color: colorBuilder?.call(index) ?? Colors.blue,
        weight: weightBuilder?.call(index) ?? 1.0,
      ),
    );
    return WheelGroup(sectors);
  }

  /// [WheelSector]s этой группы.
  final List<WheelSector> sectors;

  /// Общее количество веса для [sectors].
  late final totalWeights =
      sectors.sum((dynamic sectors) => sectors.weight as double);
  // late final totalWeights = units.sum((unit) => unit.weight);

  /// Количество деталей [sectors].
  int get divide => sectors.length;
}
