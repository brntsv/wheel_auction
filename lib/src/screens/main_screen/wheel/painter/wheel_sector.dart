import 'package:flutter/material.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_style.dart';
import 'package:wheel_auction/src/theme/app_theme.dart';

/// Опишите площадь сектора колеса
class WheelSector {
  const WheelSector({
    this.text,
    this.textStyle,
    required this.color,
    required this.weight,
  });

  /// Создайте сектор с текстом
  const WheelSector.text(
    String text, {
    TextStyle textStyle = WheelStyle.defaultTextStyle,
    Color color = AppColors.purpleDominant,
    double weight = 1.0,
  }) : this(text: text, textStyle: textStyle, color: color, weight: weight);

  /// Создайте сектор только с цветом, но без текста
  const WheelSector.noText({
    Color color = AppColors.purpleDominant,
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





/// Вариант отрисовки секторов
// class _SectorsPainter extends CustomPainter {
//   final List<bool> availableSectors;
//   final int selectedSector;

//   _SectorsPainter({
//     required this.availableSectors,
//     required this.selectedSector,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final strokeWidth = size.width / 4;
//     final rect = Rect.fromCenter(
//         center: Offset(size.width / 2, size.height / 2),
//         height: size.height - strokeWidth,
//         width: size.width - strokeWidth);

//     for (var i = 0; i < availableSectors.length; i++) {
//       final paint = Paint()
//         ..color = availableSectors[i] ? Colors.grey : Colors.black
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = strokeWidth;

//       canvas.drawArc(
//         rect,
//         2 * pi * i / availableSectors.length,
//         2 * pi / availableSectors.length * 0.95, //5% просвет между секторами
//         false,
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     throw UnimplementedError();
//   }
// }
