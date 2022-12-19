import 'package:flutter/material.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_unit.dart';

import 'package:wheel_auction/src/screens/main_screen/wheel/painter/helpers.dart'
    show DoubleSum, IndexBuilder;

/// Опишите всё колесо
class WheelGroup {
  /// Создайте группу колеса с заданными [units].
  WheelGroup(this.units);

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
  }) {
    final units = List.generate(
      itemCount,
      (index) => WheelUnit(
        text: textBuilder?.call(index),
        textStyle: textStyleBuilder?.call(index),
        color: colorBuilder?.call(index) ?? Colors.blue,
        weight: 1,
      ),
    );
    return WheelGroup(units);
  }

  /// [WheelUnit]s этой группы.
  final List<WheelUnit> units;

  /// Общее количество весов для [units].
  late final totalWeights = units.sum((dynamic unit) => unit.weight as double);
  // late final totalWeights = units.sum((unit) => unit.weight);

  /// Количество деталей [units].
  int get divide => units.length;
}
