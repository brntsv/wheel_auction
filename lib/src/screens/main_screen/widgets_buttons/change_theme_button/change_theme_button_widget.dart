import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets_buttons/change_theme_button/theme_provider.dart';

class ChangeThemeButtonWidget extends StatefulWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  State<ChangeThemeButtonWidget> createState() =>
      _ChangeThemeButtonWidgetState();
}

class _ChangeThemeButtonWidgetState extends State<ChangeThemeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    var isDark = context.read<ThemeProvider>().isDarkMode;
    final provider = context.watch<ThemeProvider>();

    return IconButton(
      onPressed: () {
        final newMode = !isDark;
        setState(() => isDark = newMode);
        provider.toggleTheme(newMode);
      },
      icon: Icon(
        isDark ? Icons.sunny : Icons.nightlight_round,
      ),
    );
  }
}



  /// Заготовка для shared preferences
  
  // final _themePreferences = ThemeDataProvider();
  // bool _isOn = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _getValue();
  // }

  // void _getValue() async {
  //   final theme = await _themePreferences.loadThemeValue();
  //   setState(() {
  //     _isOn = theme.isOn;
  //   });
  // }

  // void _saveValue() {
  //   final newMode = Settings(_isOn);
  //   _themePreferences.saveThemeValue(newMode);
  // }
