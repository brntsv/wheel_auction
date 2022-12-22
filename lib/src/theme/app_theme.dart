import 'package:flutter/material.dart';
import 'package:wheel_auction/resources/app_fonts.dart';
import 'package:wheel_auction/src/theme/app_text_style.dart';

class AppTheme {
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
    dividerColor: AppColors.primaryLight,
    iconTheme: const IconThemeData(
      color: AppColors.backgroundLight,
      size: 30,
    ),
    fontFamily: AppFonts.helveticaNeue,
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
    dividerColor: AppColors.backgroundDark,
    iconTheme: const IconThemeData(
      color: AppColors.backgroundDark,
      size: 32,
    ),
    fontFamily: AppFonts.helveticaNeue,
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

/// Цвета для колеса
final colorsWheelExampl = <String>[
  '#00b6ac',
  '#4a91ae',
  '#63c575',
  '#f85842',
  '#5d60e2',
  '#e58221',
  '#966062',
  '#7daee8',
  '#6690ad',
  '#2a8bea',
  '#e385cf',
  '#e35182',
  '#36b5e9',
  '#355f56',
  '#375f4e',
  '#519cc0',
  '#d17175',
  '#b062e7',
  '#abcc9e',
  '#80c18b',
  '#717ff6',
  '#7c9f30',
  '#c3747f',
  '#ea5461',
  '#b87dc8',
  '#978fbc',
  '#df5f56',
  '#f3bf41',
  '#FFCE24',
  '#EA631D',
  '#E33055',
  '#0085CB',
  '#275483',
  '#3CB787',
  '#80A649',
  '#E3904C',
  '#C94D51',
  '#5B4749',
];
