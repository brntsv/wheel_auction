import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/resources/app_images.dart';
import 'package:wheel_auction/src/screens/add_wheel_screen/model/list_of_wheels_model.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/arrow.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_controller.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_group.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_style.dart';

class WheelWidget extends StatefulWidget {
  const WheelWidget({Key? key}) : super(key: key);

  @override
  State<WheelWidget> createState() => _WheelWidgetState();
}

class _WheelWidgetState extends State<WheelWidget>
    with SingleTickerProviderStateMixin {
  static final _random = Random();

  late WheelController wheelController;
  // bool _clockwise = true;

  final colors = <Color>[
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  ];

  // final colors = <Color>[
  //   const Color(0xffeb3b),
  //   const Color(0xb0bec5),
  //   const Color(0x78909c),
  //   const Color(0x455a64),
  //   const Color(0x263238),
  //   const Color(0x48696d),
  //   const Color(0x2f6b7d),
  //   const Color(0x8C4F4F),
  //   const Color(0xBB9C9C),
  //   const Color(0xC55454),
  //   const Color(0xf48fb1),
  //   const Color(0xff3c3c),
  //   const Color(0x6fdd6f),
  //   const Color(0x6cc16c),
  //   const Color(0xf39b4b),
  //   const Color(0xb285ff),
  // ];

  final text = <String>[
    'data',
    'data 19191',
    'data asddas',
    'data',
    'data',
    'dataddd ff',
    'data',
    'data',
    'data',
    'data',
    'data',
    'data',
    'data',
    'data',
    'data',
    'data',
  ];

  final weight = <double>[
    1.0,
    4.0,
    3.0,
    2.5,
    0.5,
    4.0,
    1.0,
    2.0,
    1.0,
    2.0,
    7.0,
    2.5,
    1.5,
    6.0,
    1.0,
    2.0,
  ];

  @override
  void initState() {
    // final provider = context.watch<ListOfWheelsModel>();
    // final events = provider.events.isNotEmpty ? provider.events.last : [''];

    // инициализация контроллера
    final group = WheelGroup.uniform(
      colors.length,
      colorBuilder: colors.elementAt,
      textBuilder: text.elementAt,
      weightBuilder: weight.elementAt,
    );
    wheelController = WheelController(vsync: this, group: group);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        // const Text(
        //   'Clockwise: ',
        //   style: TextStyle(fontSize: 18),
        // ),
        // Switch(
        //   value: _clockwise,
        //   onChanged: (onChanged) {
        //     setState(() {
        //       _controller.resetAnimation();
        //       _clockwise = !_clockwise;
        //     });
        //   },
        // ),
        //   ],
        // ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 80,
          ),
          child: MyWheel(controller: wheelController),
        ),
        ElevatedButton(
          onPressed: () => wheelController.rollTo(
            3,
            _random.nextInt(10),
            // провайдером передать из настроек
            // clockwise: _clockwise,
            offset: _random.nextDouble() * 20,
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll<Color>(theme.primaryColor),
            minimumSize: MaterialStateProperty.all(const Size(95, 40)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          child: Text('КРУТИТЬ', style: theme.textTheme.button),
        )
      ],
    );
  }

  @override
  void dispose() {
    wheelController.dispose();
    super.dispose();
  }
}

class MyWheel extends StatelessWidget {
  const MyWheel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final WheelController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Wheel(
            controller: controller,
            style: const WheelStyle(
              dividerThickness: 2,
              dividerColor: Color(0xFFEEEEEE),
              centerStickerColor: Color(0xFFEEEEEE),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.topCenter,
          child: Arrow(),
        ),
        const Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              foregroundImage: AssetImage(AppImages.pepegaCoolman),
              radius: 35,
            ),
          ),
        ),
      ],
    );
  }
}
