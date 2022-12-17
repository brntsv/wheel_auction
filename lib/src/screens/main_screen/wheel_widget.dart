import 'dart:math';

import 'package:flutter/material.dart';

class WheelWidget extends StatefulWidget {
  const WheelWidget({super.key});

  @override
  State<WheelWidget> createState() => _WheelWidgetState();
}

class _WheelWidgetState extends State<WheelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// Вариант отрисовки секторов
class _SectorsPainter extends CustomPainter {
  final List<bool> availableSectors;
  final int selectedSector;

  _SectorsPainter({
    required this.availableSectors,
    required this.selectedSector,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 4;
    final rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        height: size.height - strokeWidth,
        width: size.width - strokeWidth);

    for (var i = 0; i < availableSectors.length; i++) {
      final paint = Paint()
        ..color = availableSectors[i] ? Colors.grey : Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;

      canvas.drawArc(
        rect,
        2 * pi * i / availableSectors.length,
        2 * pi / availableSectors.length * 0.95, //5% просвет между секторами
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
