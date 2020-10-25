import 'dart:ui';

import 'package:flutter/material.dart';

class AppThemer {
  static final accentColor = Color(0xFFEE6002);
  static final primaryColor = Color(0xFFB42E00);

  static final ThemeData dark = ThemeData(
    accentColor: accentColor,
    primaryColor: primaryColor,
    primaryColorLight: primaryColor,
    backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    appBarTheme: ThemeData.dark().appBarTheme.copyWith(
          color: primaryColor,
        ),
    bottomAppBarColor: ThemeData.dark().bottomAppBarColor,
    bottomNavigationBarTheme:
        ThemeData.dark().bottomNavigationBarTheme.copyWith(
              selectedItemColor: Colors.white,
              backgroundColor: primaryColor,
            ),
    buttonTheme: ThemeData.dark().buttonTheme.copyWith(
          buttonColor: accentColor,
          textTheme: ButtonTextTheme.primary,
        ),
    cardColor: ThemeData.dark().cardColor,
    dialogTheme: ThemeData.dark().dialogTheme,
    dialogBackgroundColor: ThemeData.dark().dialogBackgroundColor,
    iconTheme: ThemeData.dark().iconTheme.copyWith(
          color: accentColor,
        ),
    primaryTextTheme: ThemeData.dark().primaryTextTheme.copyWith(
          button: TextStyle(
            color: accentColor,
          ),
        ),
    textTheme: ThemeData.dark().textTheme.copyWith(
          button: TextStyle(
            color: accentColor,
          ),
        ),
    unselectedWidgetColor: ThemeData.dark().unselectedWidgetColor,
  );
}
