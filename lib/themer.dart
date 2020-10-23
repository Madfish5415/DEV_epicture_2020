import 'package:flutter/material.dart';

class AppThemer {
  static final accentColor = Color(0xFFEE6002);
  static final primaryColor = Color(0xFFB42E00);

  static final ThemeData dark = ThemeData(
    accentColor: accentColor,
    primaryColor: primaryColor,
    backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    bottomAppBarColor: ThemeData.dark().bottomAppBarColor,
    bottomNavigationBarTheme: ThemeData.dark().bottomNavigationBarTheme.copyWith(
      selectedItemColor: Colors.white,
      backgroundColor: primaryColor,
    ),
    cardColor: ThemeData.dark().cardColor,
    iconTheme: ThemeData.dark().iconTheme.copyWith(
      color: accentColor,
    ),
    primaryTextTheme: ThemeData.dark().primaryTextTheme,
    textTheme: ThemeData.dark().textTheme,
  );
}
