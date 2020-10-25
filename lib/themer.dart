import 'dart:ui';

import 'package:flutter/material.dart';

class AppThemer {
  static final accentColor = Color(0xFFEE6002);
  static final primaryColor = Color(0xFFB42E00);

  static final ThemeData dark = ThemeData.dark().copyWith(
    accentColor: accentColor,
    primaryColor: primaryColor,
    primaryColorLight: primaryColor,
    primaryColorDark: primaryColor,
    appBarTheme: ThemeData.dark().appBarTheme.copyWith(
      color: primaryColor,
    ),
    bottomNavigationBarTheme:
    ThemeData.dark().bottomNavigationBarTheme.copyWith(
      selectedItemColor: Colors.white,
      backgroundColor: primaryColor,
    ),
    buttonTheme: ThemeData.dark().buttonTheme.copyWith(
      buttonColor: accentColor,
      textTheme: ButtonTextTheme.primary,
    ),
    cursorColor: Colors.white,
    floatingActionButtonTheme: ThemeData.dark().floatingActionButtonTheme.copyWith(
      backgroundColor: accentColor,
      foregroundColor: Colors.white,
    ),
    iconTheme: ThemeData.dark().iconTheme.copyWith(
      color: accentColor,
    ),
    tabBarTheme: ThemeData.dark().tabBarTheme.copyWith(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: accentColor,
          width: 3.0,
        ),
      ),
    ),
    toggleableActiveColor: accentColor,
  );
}
