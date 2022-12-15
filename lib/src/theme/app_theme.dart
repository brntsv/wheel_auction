import 'package:flutter/material.dart';
import 'package:wheel_auction/src/theme/app_text_style.dart';

class AppTheme {
  static const _defaultFontFamily = 'Roboto';

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
    brightness: Brightness.dark,
    primaryColor: AppColors.purpleDominant,
    primaryColorLight: AppColors.primaryDark,
    primaryColorDark: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    cardColor: AppColors.cardDark,
    toggleableActiveColor: AppColors.purplePastelTone,
    focusColor: AppColors.purplePastelTone,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: AppColors.purpleDominant,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.backgroundLight,
      size: 30,
    ),
    fontFamily: _defaultFontFamily,
    textTheme: const TextTheme(
      button: AppTextStyle.buttonText,
      bodyText2: AppTextStyle.listWheelsButtonDark,
      headline6: AppTextStyle.headlineText,
    ),
  );

  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(),
    brightness: Brightness.light,
    primaryColor: AppColors.purpleDominant,
    primaryColorLight: AppColors.primaryLight,
    primaryColorDark: AppColors.backgroundLight,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    cardColor: AppColors.cardLight,
    toggleableActiveColor: AppColors.purplePastelTone,
    focusColor: AppColors.purplePastelTone,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: AppColors.purpleDominant,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.backgroundDark,
      size: 32,
    ),
    fontFamily: _defaultFontFamily,
    textTheme: const TextTheme(
      button: AppTextStyle.buttonText,
      bodyText2: AppTextStyle.listWheelsButtonLight,
      headline6: AppTextStyle.headlineText,
    ),
  );
}

abstract class AppColors {
  static const transparent = Color(0x00000000);
  static const purpleDominant = Color(0xFF6441A5);
  static const purplePastelTone = Color(0xFF846DAD);

  static const backgroundDark = Color(0xFF212121);
  static const primaryDark = Color(0xFF424242);
  static const cardDark = Color(0x3CFFFFFF);

  static const backgroundLight = Color(0xFFE0E0E0);
  static const primaryLight = Color(0xFFEEEEEE);
  static const cardLight = Color(0xFFEEEEEE);
}
