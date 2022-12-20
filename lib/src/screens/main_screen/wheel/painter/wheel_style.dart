import 'package:flutter/material.dart';

/// Опишите стиль рендеринга рулетки.
class WheelStyle {
  /// Стиль текста раздела по умолчанию
  static const defaultTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.normal,
    fontFamily: 'Sans',
  );

  const WheelStyle({
    this.dividerThickness = 2,
    this.dividerColor = Colors.white,
    this.centerStickerColor = Colors.white,
    this.centerStickSizePercent = 0.06,
    this.textLayoutBias = 0.85,
    this.textStyle = defaultTextStyle,
  });

  /// Толщина разделителя между каждой частью
  final double dividerThickness;

  /// Цвет разделителя между каждой частью
  final Color dividerColor;

  /// Цвет круга в центре
  final Color centerStickerColor;

  /// Размер в процентах от окружности в центре
  final double centerStickSizePercent;

  /// Смещение макета текста, используемое для определения того, где рисовать текст
  final double textLayoutBias;

  /// Текстовый стиль [Wheel] может быть переопределен текстовым стилем [WheelUnit].
  final TextStyle textStyle;
}
