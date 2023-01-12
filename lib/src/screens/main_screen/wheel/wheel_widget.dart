import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/src/screens/add_wheel_screen/model/list_of_wheels_model.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/arrow.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/constants.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_controller.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_group.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_style.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets_buttons/settings_of_wheel_button/model/settings_of_wheel_model.dart';
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

  // StreamController streamController = StreamController<String>();

  @override
  void initState() {
    final provider = context.read<ListOfWheelsModel>();
    final eventsList = provider.events;
    final events = eventsList.isNotEmpty ? eventsList.first : Default.events;
    final weightList = provider.weights;
    final weights = weightList.isNotEmpty ? weightList.first : Default.weights;

    // инициализация контроллера
    final group = WheelGroup.uniform(
      events.length,
      colorBuilder: AppColors.colorsWheel,
      textBuilder: events.elementAt,
      weightBuilder: weights.elementAt,
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
        final events = context.read<ListOfWheelsModel>().events.first;
        try {
          final weights = context.read<ListOfWheelsModel>().weights.first;
          final group = WheelGroup.uniform(
            events.length,
            colorBuilder: AppColors.colorsWheel,
            textBuilder: events.elementAt,
            weightBuilder: weights.elementAt,
          );
          wheelController = WheelController(vsync: this, group: group);
        } catch (e) {
          print('No element');
        }
      } else if (provider.events.isEmpty) {
        return;
      }
      setState(() {});
    });
    wheelController.addListener(() {
      setState(() {});
    });
  }

  int _randomizerRotateCircles() {
    final events = context.read<ListOfWheelsModel>().events;
    final countSectors = events.isNotEmpty ? events.first.length : 10;
    final selectedSeconds =
        context.read<SettingsOfWheelModel>().selectedSeconds;

    return _random.nextInt(selectedSeconds.inSeconds) + countSectors * 2;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final events = context.read<ListOfWheelsModel>().events;
    final countSectors = events.isNotEmpty ? events.first.length : 10;

    final settings = context.watch<SettingsOfWheelModel>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 80,
          ),
          child: MyWheel(wheelController: wheelController),
        ),
        ElevatedButton(
          onPressed: () {
            wheelController.rollTo(
              targetIndex: events.isNotEmpty ? countSectors ~/ 2 : 0,
              minRotateCircles: _randomizerRotateCircles(),
              duration: settings.selectedSeconds,
              clockwise: settings.clockwise,
              offset: _random.nextDouble() * pi * 2,
            );
            // streamController.sink.addStream(stream);
          },
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
  const MyWheel({Key? key, required this.wheelController}) : super(key: key);

  final WheelController wheelController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedGif = context.watch<SettingsOfWheelModel>().selectedGif;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Wheel(
            controller: wheelController,
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
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: AppColors.transparent,
              foregroundImage: AssetImage(selectedGif),
              maxRadius: 35,
            ),
          ),
        ),
      ],
    );
  }
}
