import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/src/screens/add_wheel_screen/add_wheel_screen.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/listener_event_widget.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/wheel_widget.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets_buttons/change_theme_button/change_theme_button_widget.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets_buttons/list_of_wheels_button/list_of_wheels_button.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets_buttons/settings_of_wheel_button/model/settings_of_wheel_model.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets_buttons/settings_of_wheel_button/settings_data_saver.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets_buttons/settings_of_wheel_button/settings_of_wheel_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          _TopWidget(),
          Spacer(flex: 1),
          _CenterWidget(),
          _BottomWidget(),
        ],
      ),
    );
  }
}

class _TopWidget extends StatelessWidget {
  const _TopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            flex: 1,
            child: ChangeThemeButtonWidget(),
          ),
          const Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: ListOfWheelsButton(),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: IconButton(
                onPressed: () {
                  Navigator.restorablePushNamed(
                      context, AddWheelScreen.routeName);
                },
                icon: const Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CenterWidget extends StatefulWidget {
  const _CenterWidget({Key? key}) : super(key: key);

  @override
  State<_CenterWidget> createState() => _CenterWidgetState();
}

String _gif = '';
bool _clockwise = false;
double _currentSliderValue = 5;

class _CenterWidgetState extends State<_CenterWidget> {
  final _servicePreferences = SettingsDataSaver();

  @override
  void initState() {
    super.initState();
    _getValue();
  }

  void _getValue() async {
    final settings = await _servicePreferences.loadValue();
    setState(() {
      _currentSliderValue = settings.currentSliderValue;
      _clockwise = settings.clockwise;
      _gif = settings.gif;
    });
    Future.delayed(Duration.zero, () async {
      final model = context.read<SettingsOfWheelModel>();

      model.changeDuration(Duration(seconds: _currentSliderValue.toInt()));
      model.changeDirectionRoll(_clockwise);
      model.changeGifCenter(_gif);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListenerEventWidget(),
        WheelWidget(),
      ],
    );
  }
}

class _BottomWidget extends StatelessWidget {
  const _BottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                // DeleteWinnerButton
                '',
                style: textStyle,
                maxLines: 1,
              ),
            ),
          ),
          const Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: SettingsOfWheelButton(),
            ),
          )
        ],
      ),
    );
  }
}
