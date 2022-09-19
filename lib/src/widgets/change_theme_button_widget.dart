import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';

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