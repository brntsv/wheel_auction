import 'package:flutter/material.dart';
import 'package:wheel_auction/resources/app_fonts.dart';
import 'package:wheel_auction/src/theme/app_theme.dart';

abstract class AppTextStyle {
  static const listWheelsHeader = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.robotoLight,
    height: 1.25,
    letterSpacing: 1,
  );

  static const cardListWheel = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontFamily: AppFonts.robotoLight,
    height: 1.25,
    letterSpacing: 0.5,
  );

  static const listWheelsButtonDark = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
    // fontFamily: AppFonts.basisGrotesqueProRegular,
    height: 1.33,
    letterSpacing: 1,
  );

  static const listWheelsButtonLight = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.normal,
    // fontFamily: AppFonts.basisGrotesqueProRegular,
    height: 1.33,
    letterSpacing: 1,
  );

  static const cardSettingsWheel = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
    // fontFamily: AppFonts.basisGrotesqueProRegular,
    height: 1.25,
    letterSpacing: 1,
  );

  static const buttonText = TextStyle(
    color: AppColors.primaryLight,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    // fontFamily: AppFonts.basisGrotesqueProRegular,
    height: 1.25,
    letterSpacing: 2,
  );

  static const hintInputText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
    // fontFamily: AppFonts.basisGrotesqueProRegular,
    height: 1.25,
    letterSpacing: 1,
  );

  static const headlineText = TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
    // fontFamily: AppFonts.basisGrotesqueProRegular,
    height: 1.25,
    letterSpacing: 1,
  );
}
