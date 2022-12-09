import 'package:flutter/material.dart';
import 'package:wheel_auction/src/screens/add_wheel_screen/add_wheel_screen.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets/change_theme_button/change_theme_button_widget.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets/list_of_wheels_button/list_of_wheels_button.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets/settings_of_wheel_button/settings_of_wheel_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          _TopWidget(),
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
          Flexible(
            flex: 1,
            child: Container(),
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
  State<_CenterWidget> createState() => __CenterWidgetState();
}

class __CenterWidgetState extends State<_CenterWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      fallbackHeight: 600,
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
          const Flexible(
            flex: 1,
            child: ChangeThemeButtonWidget(),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'DeleteWinnerButton',
                style: textStyle,
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
