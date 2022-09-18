import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import 'add_wheel_screen.dart';
import 'settings_of_wheel.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    // final text =
    //     Provider.of<ThemeProvider>(context).selectedThemeMode == ThemeMode.dark
    //         ? 'DarkTheme'
    //         : 'LightTheme';
    return Scaffold(
      body: Column(
        children: [
          const _TopWidget(),
          _CenterWidget(),
          const _BottomWidget(),
        ],
      ),
    );
  }
}

class _TopWidget extends StatelessWidget {
  const _TopWidget({Key? key}) : super(key: key);

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
                'NameWheelButton',
                style: textStyle,
              ),
            ),
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
  _CenterWidget({Key? key}) : super(key: key);

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

class _BottomWidget extends StatefulWidget {
  const _BottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<_BottomWidget> {
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
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: IconButton(
                onPressed: () {
                  Navigator.restorablePushNamed(
                      context, SettingsOfWheel.routeName);
                },
                icon: const Icon(Icons.menu_sharp),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChangeThemeButtonWidget extends StatefulWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  State<ChangeThemeButtonWidget> createState() =>
      _ChangeThemeButtonWidgetState();
}

class _ChangeThemeButtonWidgetState extends State<ChangeThemeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var isDark = themeProvider.isDarkMode;
    return IconButton(
      onPressed: () {
        final newMode = !isDark;
        setState(() => isDark = newMode);
        //

        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(isDark);
      },
      icon: Icon(
        isDark ? Icons.sunny : Icons.nightlight_round,
      ),
    );
  }
}

// class ChangeThemeButtonWidget extends StatelessWidget {
//   const ChangeThemeButtonWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return Switch.adaptive(
//       value: themeProvider.isDarkMode,
//       onChanged: (value) {
//         final provider = Provider.of<ThemeProvider>(context, listen: false);
//         provider.toggleTheme(value);
//       },
//     );
//   }
// }
