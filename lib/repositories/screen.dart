import 'package:epicture/models/screen.dart';
import 'package:epicture/screens/root.dart';

class ScreenRepository {
  final Map<String, ScreenModel> _screens = {
    "/": ScreenModel(
      builder: (_) => RootScreen(),
    ),
  };

  Map<String, ScreenModel> get screens => _screens;
}
