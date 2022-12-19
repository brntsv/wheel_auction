import 'package:flutter/material.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_style.dart';

/// Опишите площадь сектора колеса
class WheelUnit {
  const WheelUnit({
    this.text,
    this.textStyle,
    required this.color,
    required this.weight,
  });

  /// Создайте сектор с текстом
  const WheelUnit.text(
    String text, {
    TextStyle textStyle = WheelStyle.defaultTextStyle,
    Color color = Colors.blue,
    double weight = 1.0,
  }) : this(text: text, textStyle: textStyle, color: color, weight: weight);

  /// Создайте сектор только с цветом, но без текста
  const WheelUnit.noText({
    Color color = Colors.blue,
    double weight = 1.0,
  }) : this(color: color, weight: weight);

  /// Текстовое наполнение этого сектора
  final String? text;

  /// Стиль текста этого сектора
  final TextStyle? textStyle;

  /// Цвет фона сектора
  final Color color;

  /// Вес этого сектора
  final double weight;
}
