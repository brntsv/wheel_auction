import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'models/list_of_wheels_model.dart';
import 'screens/add_wheel_screen.dart';
import 'screens/global_settings_screen.dart';
import 'screens/main_screen_wheel.dart';
import 'screens/settings_of_chosen_wheel.dart';
import 'settings/settings_controller.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({
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
                final themeProvider = Provider.of<ThemeProvider>(context);
                return MaterialApp(
                  restorationScopeId: 'app',
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', ''),
                  ],
                  onGenerateTitle: (BuildContext context) =>
                      AppLocalizations.of(context)!.appTitle,
                  debugShowCheckedModeBanner: false,
                  //
                  theme: MyThemes.lightTheme,
                  darkTheme: MyThemes.darkTheme,
                  themeMode: themeProvider.selectedThemeMode,
                  //
                  home: child,
                  onGenerateRoute: (RouteSettings routeSettings) {
                    return MaterialPageRoute<void>(
                      settings: routeSettings,
                      builder: (BuildContext context) {
                        switch (routeSettings.name) {
                          case AddWheelScreen.routeName:
                            return AddWheelScreen(
                                controller: settingsController);
                          case GlobalSettingsWheel.routeName:
                            return GlobalSettingsWheel();
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
            ChangeNotifierProvider(create: (_) => ListOfWheelsModel()),
          ],
          child: child,
        );
      },
    );
  }
}
