import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/src/providers/list_of_wheels_provider.dart';
import 'package:wheel_auction/src/screens/add_wheel_screen/add_wheel_screen.dart';
import 'package:wheel_auction/src/screens/global_settings_screen/global_settings_screen.dart';
import 'package:wheel_auction/src/screens/main_screen/main_screen.dart';
import 'package:wheel_auction/src/screens/settings_of_chosen_screen/settings_of_chosen_wheel.dart';
import 'package:wheel_auction/src/settings/settings_controller.dart';
import 'package:wheel_auction/src/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => ThemeProvider(),
              builder: (context, _) {
                final themeProvider = context.watch<ThemeProvider>();

                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  //
                  theme: MyThemes.lightTheme,
                  darkTheme: MyThemes.darkTheme,
                  themeMode: themeProvider.selectedThemeMode,
                  //
                  onGenerateRoute: (RouteSettings routeSettings) {
                    return MaterialPageRoute<void>(
                      settings: routeSettings,
                      builder: (BuildContext context) {
                        switch (routeSettings.name) {
                          case AddWheelScreen.routeName:
                            return const AddWheelScreen();
                          case GlobalSettingsWheel.routeName:
                            return const GlobalSettingsWheel();
                          case SettingsOfChosenWheel.routeName:
                            return const SettingsOfChosenWheel();
                          case MainScreen.routeName:
                          default:
                            return const MainScreen();
                        }
                      },
                    );
                  },
                );
              },
              child: ChangeNotifierProvider<ListOfWheelsProviderPart2>(
                create: (context) => ListOfWheelsProviderPart2(),
              ),
            ),
            ChangeNotifierProvider<ListOfWheelsProvider>(
              create: (context) => ListOfWheelsProvider(),
            ),
          ],
        );
      },
    );
  }
}
