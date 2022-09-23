import 'package:flutter/material.dart';

import '../screens/settings_of_chosen_wheel.dart';

class SettingsOfWheelButton extends StatefulWidget {
  SettingsOfWheelButton({Key? key}) : super(key: key);

  @override
  State<SettingsOfWheelButton> createState() => _SettingsOfWheelButtonState();
}

class _SettingsOfWheelButtonState extends State<SettingsOfWheelButton> {
  bool _isSwitched = true;
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showGeneralDialog(
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: const Duration(milliseconds: 300),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 600,
                margin: const EdgeInsets.only(bottom: 50, left: 50, right: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: StatefulBuilder(
                  builder: (context, setState) => Dialog(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    insetPadding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    elevation: 0,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            color: Theme.of(context).primaryColorLight,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              splashColor: Colors.white.withAlpha(30),
                              onTap: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 5),
                                child: Row(
                                  children: [
                                    const Text('Режим на выбывание'),
                                    const Spacer(),
                                    Switch(
                                      value: _isSwitched,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _isSwitched = newValue;
                                        });
                                      },
                                      activeTrackColor: Theme.of(context)
                                          .toggleableActiveColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Card(
                            color: Theme.of(context).primaryColorLight,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 5, top: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Text('Длительность вращения'),
                                      Spacer(),
                                    ],
                                  ),
                                  Slider(
                                    value: _currentSliderValue,
                                    max: 60,
                                    divisions: 60,
                                    label:
                                        _currentSliderValue.round().toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        _currentSliderValue = value;
                                      });
                                    },
                                    activeColor:
                                        Theme.of(context).toggleableActiveColor,
                                    thumbColor:
                                        Theme.of(context).toggleableActiveColor,
                                    inactiveColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Card(
                            color: Theme.of(context).primaryColorLight,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 5, top: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Text('Стиль колеса'),
                                      Spacer(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: Card(
                            color: Theme.of(context).primaryColorLight,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              splashColor: Colors.white.withAlpha(30),
                              onTap: () {
                                Navigator.restorablePushNamed(
                                    context, SettingsOfChosenWheel.routeName);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 5),
                                child: Row(
                                  children: const [
                                    Text('Редактировать колесо'),
                                    Spacer(),
                                    Icon(Icons.keyboard_arrow_right)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position:
                  Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                      .animate(anim1),
              child: child,
            );
          },
        );
      },
      icon: const Icon(Icons.menu_sharp),
    );
  }
}
