import 'package:epicture/models/screen.dart';
import 'package:epicture/screens/root.dart';
import 'package:epicture/screens/view.dart';

class ScreenRepository {
  final Map<String, ScreenModel> _screens = {
    "/": ScreenModel(
      builder: (_) => RootScreenWidget(),
    ),
    "/view": ScreenModel(
      builder: (_) => ViewScreenWidget(),
    ),
  };

  Map<String, ScreenModel> get screens => _screens;
}
