import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roulette/roulette.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/arrow.dart';

class WheelWidget extends StatefulWidget {
  const WheelWidget({Key? key}) : super(key: key);

  @override
  State<WheelWidget> createState() => _WheelWidgetState();
}

class _WheelWidgetState extends State<WheelWidget>
    with SingleTickerProviderStateMixin {
  static final _random = Random();

  late RouletteController _controller;
  bool _clockwise = true;

  final colors = <Color>[
    Colors.red.withAlpha(50),
    Colors.green.withAlpha(30),
    Colors.blue.withAlpha(70),
    Colors.yellow.withAlpha(90),
    Colors.amber.withAlpha(50),
    Colors.indigo.withAlpha(70),
  ];

  @override
  void initState() {
    // Initialize the controller
    final group = RouletteGroup.uniform(
      colors.length,
      colorBuilder: colors.elementAt,
    );
    _controller = RouletteController(vsync: this, group: group);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Clockwise: ',
              style: TextStyle(fontSize: 18),
            ),
            Switch(
              value: _clockwise,
              onChanged: (onChanged) {
                setState(() {
                  _controller.resetAnimation();
                  _clockwise = !_clockwise;
                });
              },
            ),
          ],
        ),
        MyRoulette(controller: _controller),
        ElevatedButton(
          onPressed: () => _controller.rollTo(
            3,
            clockwise: _clockwise,
            offset: _random.nextDouble(),
          ),
          child: const Icon(Icons.refresh_rounded),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MyRoulette extends StatelessWidget {
  const MyRoulette({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RouletteController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          width: 260,
          height: 260,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Roulette(
              // Provide controller to update its state
              controller: controller,
              // Configure roulette's appearance
              style: const RouletteStyle(
                dividerThickness: 4,
                textLayoutBias: .8,
                centerStickerColor: Color(0xFF45A3FA),
              ),
            ),
          ),
        ),
        const Arrow(),
      ],
    );
  }
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
