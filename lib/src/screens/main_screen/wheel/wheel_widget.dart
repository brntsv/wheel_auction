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
import 'package:wheel_auction/src/theme/app_theme.dart';

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

  // final colors = <Color>[
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  //   Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
  // ];

  final colorsWheel = <Color>[
    const Color(0xFF00B6AC),
    const Color(0xFF4A91AE),
    const Color(0xFF63C575),
    const Color(0xFFF85842),
    const Color(0xFF5D60E2),
    const Color(0xFFE58221),
    const Color(0xFF966062),
    const Color(0xFF7DAEE8),
    const Color(0xFF6690AD),
    const Color(0xFF2A8BEA),
    const Color(0xFFE385CF),
    const Color(0xFFE35182),
    const Color(0xFF36B5E9),
    const Color(0xFF355F56),
    const Color(0xFF375F4E),
    const Color(0xFF519CC0),
    const Color(0xFFD17175),
    const Color(0xFFB062E7),
    const Color(0xFFABCC9E),
    const Color(0xFF80C18B),
    const Color(0xFF717FF6),
    const Color(0xFF7c9f30),
    const Color(0xFFC3747F),
    const Color(0xFFEA5461),
    const Color(0xFFB87DC8),
    const Color(0xFF978FBC),
    const Color(0xFFDF5F56),
    const Color(0xFFF3BF41),
    const Color(0xFFFFCE24),
    const Color(0xFFEA631D),
    const Color(0xFFE33055),
    const Color(0xFF0085CB),
    const Color(0xFF275483),
    const Color(0xFF3CB787),
    const Color(0xFF80A649),
    const Color(0xFFE3904C),
    const Color(0xFFC94D51),
    const Color(0xFF5B4749),
  ];

  final text = <String>[
    'Кишлак',
    'Нойз МС',
    'boulevard depo',
    'Букер',
    'ssshhhiiittt',
    'plaksasadsa',
    'Дурик',
    'тима ищет свет',
    'Свидание',
    'Галантерея',
    'Пирокинезис',
    'i61',
    'Шизоид',
    'СЕРЕГА ПИРАТ',
    'Чудик',
    'Моргенштерн',
    'Кишлак',
    'Нойз МС',
    'boulevard depo',
    'Букер',
    'ssshhhiiittt',
    'plaksasadsa',
    'Дурик',
    'тима ищет свет',
    'Свидание',
    'Галантерея',
    'Пирокинезис',
    'i61',
    'Шизоид',
    'СЕРЕГА ПИРАТ',
    'Чудик',
    'Моргенштерн',
    'Пирокинезис',
    'i61',
    'Шизоид',
    'СЕРЕГА ПИРАТ',
    'Чудик',
    'Моргенштерн',
  ];

  // final weight = <double>[
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   5.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  //   1.0,
  // ];

  @override
  void initState() {
    // final provider = context.watch<ListOfWheelsModel>();
    // final events = provider.events.isNotEmpty ? provider.events.last : [''];

    // инициализация контроллера
    final group = WheelGroup.uniform(
      colorsWheel.length,
      colorBuilder: colorsWheel.elementAt,
      //colorsWheel[Random().nextInt(colorsWheel.length)],
      textBuilder: text.elementAt,
      // weightBuilder: weight.elementAt,
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
            // TODO провайдером передать из настроек
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
              radius: 35,
            ),
          ),
        ),
      ],
    );
  }
}
