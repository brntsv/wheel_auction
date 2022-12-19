import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_group.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_unit.dart';

/// Создаёт анимацию из контроллера, чтобы начать эффект поворота.
/// Конечная позиция поворота - targetValue.

Animation<double> makeAnimation(
  AnimationController controller,
  double targetValue,
  Curve? curve, {
  double initialValue = 0,
}) {
  final begin = initialValue % (2 * pi);
  if (curve != null) {
    final curved = CurvedAnimation(parent: controller, curve: curve);
    return curved.drive(Tween(begin: begin, end: targetValue));
  } else {
    return controller.drive(Tween(begin: begin, end: targetValue));
  }
}

/// Вычисление значения конечного поворота с помощью targetIndex.
/// Возвращаемое значение содержит круги, которые нужно свернуть.
/// Убедитесь, что при запуске этого метода в [group] есть хотя бы один [WheelUnit].
///
/// [group] - это [WheelGroup] для запуска анимации поворота.
/// [targetIndex] - это конечный индекс в [group].
/// [clockwise] - определяет, должен ли аниматор выполняться в противоположном направлении.
/// [minRotateCircles] - круги, прокрученные ранее.
/// [random] - Предоставляет генератор случайных чисел для рандомизации, значение по умолчанию равно нулю
/// и случайного значения нет.

double calculateEndRotate(
  WheelGroup group,
  int targetIndex,
  bool clockwise,
  int minRotateCircles, {
  double offset = 0,
}) {
  final units = group.units;
  assert(units.isNotEmpty, 'You cannot roll an empty roulette.');
  assert(
    targetIndex >= 0 && targetIndex < group.divide,
    'targetIndex is out of group range.',
  );
  final passUnits = clockwise
      ? units.reversed.take(group.divide - targetIndex - 1)
      : units.take(targetIndex);
  final preRotation = minRotateCircles * 2 * pi;
  // final totalRotateWeight = passUnits.sum((unit) => unit.weight);
  final totalRotateWeight =
      passUnits.sum((dynamic unit) => unit.weight as double);
  // Веса должны вращаться
  final targetRotate = 2 * pi * totalRotateWeight / group.totalWeights;
  final targetCoverRotate =
      2 * pi * units[targetIndex].weight / group.totalWeights;
  var offsetValue = offset * targetCoverRotate; // Случайный поворот
  final totalRotate = preRotation + targetRotate + offsetValue;
  return clockwise ? totalRotate : -totalRotate;
}

typedef DoubleSelector<T> = double Function(T source);

extension DoubleSum<T> on Iterable<T> {
  double sum(DoubleSelector selector) =>
      fold(0.0, (previousValue, element) => previousValue + selector(element));
}

typedef IndexBuilder<T> = T Function(int index);
