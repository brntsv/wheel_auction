import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets_buttons/settings_of_wheel_button/model/settings_of_wheel_model.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets_buttons/settings_of_wheel_button/settings_data_saver.dart';
import 'package:wheel_auction/src/screens/settings_of_chosen_screen/settings_of_chosen_wheel.dart';
import 'package:wheel_auction/src/theme/app_text_style.dart';

class SettingsOfWheelButton extends StatefulWidget {
  const SettingsOfWheelButton({Key? key}) : super(key: key);

  @override
  State<SettingsOfWheelButton> createState() => _SettingsOfWheelButtonState();
}

class _SettingsOfWheelButtonState extends State<SettingsOfWheelButton> {
  bool _isSwitched = false;
  double _currentSliderValue = 5;
  bool _clockwise = false;
  final _servicePreferences = SettingsDataSaver();

  // late WheelController wheelController;
  // bool _clockwise = false;

  @override
  void initState() {
    super.initState();
    _getValue();
  }

  void _getValue() async {
    final settings = await _servicePreferences.loadValue();
    setState(() {
      _isSwitched = settings.isSwitched;
      _currentSliderValue = settings.currentSliderValue;
      _clockwise = settings.clockwise;
    });
  }

  void _saveValue() {
    final newSettings = Settings(
      isSwitched: _isSwitched,
      currentSliderValue: _currentSliderValue,
      clockwise: _clockwise,
    );
    _servicePreferences.saveToggleValue(newSettings);
    _servicePreferences.saveSliderValue(newSettings);
    _servicePreferences.saveClockwise(newSettings);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = context.watch<SettingsOfWheelModel>();

    return IconButton(
      onPressed: () {
        showGeneralDialog(
          barrierLabel: 'Label',
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
                  color: theme.primaryColorDark,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: StatefulBuilder(
                  builder: (context, setState) => Dialog(
                    backgroundColor: theme.primaryColorDark,
                    insetPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    elevation: 0,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            color: theme.cardColor,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              splashColor: Colors.white.withAlpha(30),
                              onTap: () {
                                setState(() {
                                  if (_isSwitched == true) {
                                    _isSwitched = false;
                                  } else if (_isSwitched == false) {
                                    _isSwitched = true;
                                  }
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 5),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Режим на выбывание',
                                      style: AppTextStyle.cardSettingsWheel,
                                      overflow: TextOverflow.fade,
                                    ),
                                    const Spacer(),
                                    Switch(
                                      value: _isSwitched,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _isSwitched = !_isSwitched;
                                        });
                                        _saveValue();
                                      },
                                      activeTrackColor:
                                          theme.toggleableActiveColor,
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
                            color: theme.cardColor,
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
                                      Text(
                                        'Длительность вращения',
                                        style: AppTextStyle.cardSettingsWheel,
                                        overflow: TextOverflow.fade,
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                  Slider(
                                    value: _currentSliderValue,
                                    max: 60,
                                    divisions: 60,
                                    label:
                                        _currentSliderValue.round().toString(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _currentSliderValue = newValue;
                                      });
                                      settings.changeDuration(
                                          Duration(seconds: newValue.toInt()));
                                      _saveValue();
                                    },
                                    activeColor: theme.toggleableActiveColor,
                                    thumbColor: theme.toggleableActiveColor,
                                    inactiveColor: theme.primaryColorDark,
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
                            color: theme.cardColor,
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
                                      Text(
                                        'Стиль колеса',
                                        style: AppTextStyle.cardSettingsWheel,
                                        overflow: TextOverflow.fade,
                                      ),
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
                          child: Card(
                            color: theme.cardColor,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              splashColor: Colors.white.withAlpha(30),
                              onTap: () {
                                setState(() {
                                  if (_clockwise == true) {
                                    _clockwise = false;
                                  } else if (_clockwise == false) {
                                    _clockwise = true;
                                  }
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 5),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Смена направления',
                                      style: AppTextStyle.cardSettingsWheel,
                                      overflow: TextOverflow.fade,
                                    ),
                                    const Spacer(),
                                    Switch(
                                      value: _clockwise,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          // wheelController.resetAnimation();
                                          _clockwise = newValue;
                                        });
                                        settings.changeDirectionRoll(newValue);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: Card(
                            color: theme.cardColor,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                Navigator.restorablePushNamed(
                                    context, SettingsOfChosenWheel.routeName);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 5),
                                child: Row(
                                  children: const [
                                    Text(
                                      'Редактировать колесо',
                                      style: AppTextStyle.cardSettingsWheel,
                                      overflow: TextOverflow.fade,
                                    ),
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
