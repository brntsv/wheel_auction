import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/constants.dart';
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
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                      children: const [
                        _EliminateModeWidget(),
                        _ChangeDurationRollWidget(),
                        _WheelStyleChangeWidget(),
                        _ChangeDirectionRollWidget(),
                        _GifPickerWidget(),
                        _EditWheelButtonWidget(),
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

class _EliminateModeWidget extends StatefulWidget {
  const _EliminateModeWidget({Key? key}) : super(key: key);

  @override
  State<_EliminateModeWidget> createState() => __EliminateModeWidgetState();
}

bool _isSwitched = false;

class __EliminateModeWidgetState extends State<_EliminateModeWidget> {
  final _servicePreferences = SettingsDataSaver();

  @override
  void initState() {
    super.initState();
    _getValue();
  }

  void _getValue() async {
    final settings = await _servicePreferences.loadValue();
    setState(() => _isSwitched = settings.isSwitched);
  }

  void _saveValue() => _servicePreferences.saveToggleValue(_isSwitched);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
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
            padding: const EdgeInsets.only(left: 20, right: 5),
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
                    setState(() => _isSwitched = !_isSwitched);
                    _saveValue();
                  },
                  activeTrackColor: theme.toggleableActiveColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChangeDurationRollWidget extends StatefulWidget {
  const _ChangeDurationRollWidget({Key? key}) : super(key: key);

  @override
  State<_ChangeDurationRollWidget> createState() =>
      __ChangeDurationRollWidgetState();
}

double _currentSliderValue = 5;

class __ChangeDurationRollWidgetState extends State<_ChangeDurationRollWidget> {
  final _servicePreferences = SettingsDataSaver();

  @override
  void initState() {
    super.initState();
    _getValue();
  }

  void _getValue() async {
    final settings = await _servicePreferences.loadValue();
    setState(() => _currentSliderValue = settings.currentSliderValue);
  }

  void _saveValue() => _servicePreferences.saveSliderValue(_currentSliderValue);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = context.watch<SettingsOfWheelModel>();

    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Card(
        color: theme.cardColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 5, top: 20),
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
                label: _currentSliderValue.round().toString(),
                onChanged: (newValue) {
                  setState(() {
                    _currentSliderValue = newValue;
                  });
                  settings.changeDuration(Duration(seconds: newValue.toInt()));
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
    );
  }
}

class _WheelStyleChangeWidget extends StatefulWidget {
  const _WheelStyleChangeWidget({Key? key}) : super(key: key);

  @override
  State<_WheelStyleChangeWidget> createState() =>
      _WheelStyleChangeWidgetState();
}

class _WheelStyleChangeWidgetState extends State<_WheelStyleChangeWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Card(
        color: theme.cardColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 5, top: 20),
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
    );
  }
}

class _ChangeDirectionRollWidget extends StatefulWidget {
  const _ChangeDirectionRollWidget({Key? key}) : super(key: key);

  @override
  State<_ChangeDirectionRollWidget> createState() =>
      __ChangeDirectionRollWidgetState();
}

bool _clockwise = false;

class __ChangeDirectionRollWidgetState
    extends State<_ChangeDirectionRollWidget> {
  final _servicePreferences = SettingsDataSaver();

  @override
  void initState() {
    super.initState();
    _getValue();
  }

  void _getValue() async {
    final settings = await _servicePreferences.loadValue();
    setState(() => _clockwise = settings.clockwise);
  }

  void _saveValue() => _servicePreferences.saveClockwise(_clockwise);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = context.watch<SettingsOfWheelModel>();

    return SizedBox(
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
            padding: const EdgeInsets.only(left: 20, right: 5),
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
                    setState(() => _clockwise = newValue);
                    settings.changeDirectionRoll(newValue);
                    _saveValue();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GifPickerWidget extends StatefulWidget {
  const _GifPickerWidget({Key? key}) : super(key: key);

  @override
  State<_GifPickerWidget> createState() => _GifPickerWidgetState();
}

class _GifPickerWidgetState extends State<_GifPickerWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = context.watch<SettingsOfWheelModel>();

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: theme.cardColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 15,
                  ),
                  child: Text(
                    'Гифка',
                    style: AppTextStyle.cardSettingsWheel,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: CenterGifWidget.gifs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Image.asset(
                            CenterGifWidget.gifs[index],
                            height: 60,
                            width: 60,
                          ),
                          onTap: () {
                            settings
                                .changeGifCenter(CenterGifWidget.gifs[index]);
                          },
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, mainAxisSpacing: 10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EditWheelButtonWidget extends StatelessWidget {
  const _EditWheelButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
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
            padding: const EdgeInsets.only(left: 20, right: 5),
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
    );
  }
}
