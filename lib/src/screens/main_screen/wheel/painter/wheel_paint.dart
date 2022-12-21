import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_group.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_style.dart';
import 'dart:ui' as ui;

class WheelPaint extends AnimatedWidget {
  const WheelPaint({
    Key? key,
    required Animation<double> animation,
    required this.style,
    required this.group,
  }) : super(key: key, listenable: animation);

  final WheelStyle style;
  final WheelGroup group;

  Animation<double> get _rotation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: _WheelPainter(
          rotate: _rotation.value,
          style: style,
          group: group,
        ),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  _WheelPainter({
    required this.style,
    required this.rotate,
    required this.group,
  });

  final double rotate;
  final WheelStyle style;
  final WheelGroup group;

  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: Offset.zero, radius: radius);

    canvas.translate(size.width / 2, size.height / 2);

    canvas.save();
    canvas.rotate(-pi / 2 + rotate);

    _drawBackground(canvas, radius, rect);
    _drawSections(canvas, radius);

    canvas.restore();

    _drawCenterSticker(canvas, radius);
  }

  void _drawBackground(Canvas canvas, double radius, Rect rect) {
    _paint.strokeWidth = 0;
    _paint.style = ui.PaintingStyle.fill;

    double drewSweep = 0;
    for (var i = 0; i < group.divide; i++) {
      final unit = group.sectors[i];
      final sweep = 2 * pi * unit.weight / group.totalWeights;

      canvas.save();
      canvas.rotate(drewSweep);

      // Рисует фон сектора
      _paint.color = unit.color;
      _paint.strokeWidth = 0;
      _paint.style = ui.PaintingStyle.fill;
      canvas.drawArc(rect, 0.0 * i, sweep, true, _paint);

      // Рисует границы сектора
      _paint.color = style.dividerColor;
      _paint.strokeWidth = style.dividerThickness;
      _paint.style = ui.PaintingStyle.stroke;
      canvas.drawArc(rect, 0.0 * i, sweep, true, _paint);

      canvas.restore();

      drewSweep += sweep;
    }
  }

  void _drawSections(Canvas canvas, double radius) {
    double drewSweep = 0.0; // Рисует угол изгиба
    for (var i = 0; i < group.divide; i++) {
      // Рисует каждую секцию с юнитом
      final unit = group.sectors[i];
      final sweep = 2 * pi * unit.weight / group.totalWeights;

      canvas.save();
      canvas.rotate(drewSweep + pi / 2 + sweep / 2);

      final text = unit.text;
      if (text == null) {
        canvas.restore();
        continue;
      }

      final textStyle = unit.textStyle ?? style.textStyle;
      final pb = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: TextAlign.center,
      ))
        ..pushStyle(textStyle.asUiTextStyle())
        ..addText(text);

      // Рассчет хорды окружности
      final chord = 2 * (radius * style.textLayoutBias) * sin(sweep / 2);

      final p = pb.build();
      p.layout(ui.ParagraphConstraints(width: chord));

      canvas.drawParagraph(
          p, Offset(-chord / 2, -radius * style.textLayoutBias));
      canvas.restore();

      drewSweep += sweep;
    }
  }

  void _drawCenterSticker(Canvas canvas, double radius) {
    _paint.color = style.centerStickerColor;
    _paint.strokeWidth = 2;
    _paint.style = ui.PaintingStyle.stroke;
    canvas.drawCircle(
        Offset.zero, radius * style.centerStickSizePercent, _paint);
  }

  @override
  bool shouldRepaint(covariant _WheelPainter oldDelegate) =>
      oldDelegate.rotate != rotate ||
      oldDelegate.group != group ||
      oldDelegate.style != style;
}

extension _Cast on TextStyle {
  ui.TextStyle asUiTextStyle() => ui.TextStyle(
        color: color,
        decoration: decoration,
        decorationColor: decorationColor,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        textBaseline: textBaseline,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        background: background,
        foreground: foreground,
        shadows: shadows,
        fontFeatures: fontFeatures,
      );
}
