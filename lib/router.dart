import 'package:epicture/models/screen.dart';
import 'package:epicture/repositories/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static final ScreenRepository _repository = ScreenRepository();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final ScreenModel screen = _repository.screens[settings.name];

    return MaterialPageRoute(
      builder: screen.builder,
      settings: settings,
    );
  }

  static NavigatorState get navigator => navigatorKey.currentState;
}
