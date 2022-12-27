import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/resources/app_images.dart';
import 'package:wheel_auction/src/screens/add_wheel_screen/model/list_of_wheels_model.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/arrow.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/constants.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_controller.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_group.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_style.dart';
import 'package:wheel_auction/src/theme/app_theme.dart';

class WheelWidget extends StatefulWidget {
  const WheelWidget({Key? key}) : super(key: key);

  @override
  State<WheelWidget> createState() => _WheelWidgetState();
}

class _WheelWidgetState extends State<WheelWidget>
    with TickerProviderStateMixin {
  static final _random = Random();

  late WheelController wheelController;
  // bool _clockwise = true;

  // final weight = <double>[
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  // ];

  @override
  void initState() {
    final provider = context.read<ListOfWheelsModel>();
    final events =
        provider.events.isNotEmpty ? provider.events.first : Default.events;

    // инициализация контроллера
    final group = WheelGroup.uniform(
      events.length,
      colorBuilder: AppColors.colorsWheel,
      textBuilder: events.elementAt,
      // weightBuilder: weight.elementAt,
    );
    wheelController = WheelController(vsync: this, group: group);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider = context.watch<ListOfWheelsModel>();

    provider.addListener(() {
      if (provider.events.isNotEmpty) {
        wheelController.dispose();
        final events = provider.events.first;
        final group = WheelGroup.uniform(
          events.length,
          colorBuilder: AppColors.colorsWheel,
          textBuilder: events.elementAt,
          // weightBuilder: weight.elementAt,
        );
        wheelController = WheelController(vsync: this, group: group);
      } else if (provider.events.isEmpty) {
        return;
      }
      setState(() {});
    });
    wheelController.addListener(() {
      setState(() {});
    });
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
            1,
            _random.nextInt(10),
            // provider.events.first.length - 1,

            // TODO провайдером передать из настроек
            // clockwise: _clockwise,
            offset: _random.nextDouble() * 25,
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
    final provider = context.read<ListOfWheelsModel>();
    provider.removeListener(() {});
    wheelController.removeListener(() {});
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
    final theme = Theme.of(context);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Wheel(
            controller: controller,
            style: WheelStyle(
              dividerThickness: 1.5,
              dividerColor: theme.dividerColor,
              centerStickerColor: theme.dividerColor,
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
              backgroundColor: AppColors.transparent,
              foregroundImage: AssetImage(AppImages.whiteCat),
              maxRadius: 35,
            ),
          ),
        ),
      ],
    );
  }
}
