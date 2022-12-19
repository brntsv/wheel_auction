import 'package:flutter/material.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_controller.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_paint.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_style.dart';

/// Это анимируемый виджет колеса.
/// Вам необходимо представить [WheelController] для управления этим виджетом.
class Wheel extends StatefulWidget {
  const Wheel({
    Key? key,
    required this.controller,
    this.style = const WheelStyle(),
  }) : super(key: key);

  /// контроллер колеса.
  final WheelController controller;

  /// отображает стиль колеса.
  final WheelStyle style;

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WheelPaint(
      key: widget.key,
      animation: widget.controller.animation,
      style: widget.style,
      group: widget.controller.group,
    );
  }
}
