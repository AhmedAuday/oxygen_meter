// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

abstract class MyThemeData {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static MyThemeData of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? DarkModeTheme()
          : LightModeTheme();

  Color? primaryColor;
  Color? secondaryColor;
  Color? tertiaryColor;
  Color? alternate;
  Color? primaryBackground;
  Color? secondaryBackground;
  Color? primaryText;
  Color? secondaryText;
  Color? iconColor;

  TextStyle get title1 => GoogleFonts.getFont(
        'Poppins',
        color: primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  TextStyle get title2 => GoogleFonts.getFont(
        'Poppins',
        color: primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      );
  TextStyle get title3 => GoogleFonts.getFont(
        'Lexend Deca',
        color: primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Poppins',
        color: primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Poppins',
        color: secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Poppins',
        color: primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
}

class LightModeTheme extends MyThemeData {
  Color? primaryColor = Color(0xFF090F13);
  Color? secondaryColor = Color.fromARGB(255, 22, 22, 22);
  Color? tertiaryColor = Color.fromARGB(255, 156, 49, 3);
  Color? alternate = const Color(0xFFFF5963);
  Color? primaryBackground = const Color(0xFFFFFFFF);
  Color? secondaryBackground = const Color(0xFFF1F4F8);
  Color? primaryText = Color.fromARGB(255, 255, 255, 255);
  Color? secondaryText = const Color(0xFF57636C);
  Color? borderColor = Colors.transparent;
  Color? iconColor = const Color(0xFFFFFFFF);
}

class DarkModeTheme extends MyThemeData {
  Color? primaryColor = Color.fromARGB(255, 250, 1, 1);
  Color? secondaryColor = const Color(0xFF39D2C0);
  Color? tertiaryColor = const Color(0xFFEE8B60);
  Color? alternate = const Color(0xFFFF5963);
  Color? primaryBackground = const Color(0xFF1D2429);
  Color? secondaryBackground = const Color(0xFF1D2429);
  Color? primaryText = const Color(0xFFFFFFFF);
  Color? secondaryText = const Color(0xFF95A1AC);
  Color? borderColor = Colors.transparent;
  Color? iconColor = const Color(0xFFFFFFFF);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              height: lineHeight,
            );
}
