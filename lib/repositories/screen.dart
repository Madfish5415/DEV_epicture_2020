import 'package:epicture/models/screen.dart';
import 'package:epicture/screens/root.dart';
import 'package:epicture/screens/tag.dart';
import 'package:epicture/screens/view.dart';

class ScreenRepository {
  final Map<String, ScreenModel> _screens = {
    "/": ScreenModel(
      builder: (_) => RootScreen(),
    ),
    "/view": ScreenModel(
      builder: (_) => ViewScreen(),
    ),
    "/tag": ScreenModel(
      builder: (_) => TagScreen(),
    ),
  };

  Map<String, ScreenModel> get screens => _screens;
}
