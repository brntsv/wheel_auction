import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/src/screens/add_wheel_screen/add_wheel_screen.dart';
import 'package:wheel_auction/src/screens/add_wheel_screen/model/list_of_wheels_model.dart';
import 'package:wheel_auction/src/screens/global_settings_screen/global_settings_screen.dart';
import 'package:wheel_auction/src/screens/main_screen/main_screen.dart';
import 'package:wheel_auction/src/screens/main_screen/widgets/change_theme_button/theme_provider.dart';
import 'package:wheel_auction/src/screens/settings_of_chosen_screen/settings_of_chosen_wheel.dart';
import 'package:wheel_auction/src/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListOfWheelsModel>(
          create: (_) => ListOfWheelsModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          builder: (context, _) {
            final themeProvider = context.watch<ThemeProvider>();
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.selectedThemeMode,
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
        ),
      ],
    );
  }
}
