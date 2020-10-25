import 'package:epicture/models/screen.dart';
import 'package:epicture/screens/edit.dart';
import 'package:epicture/screens/root.dart';
import 'package:epicture/screens/splash.dart';
import 'package:epicture/screens/tag.dart';
import 'package:epicture/screens/upload.dart';
import 'package:epicture/screens/view.dart';

class ScreenRepository {
  final Map<String, ScreenModel> _screens = {
    "/": ScreenModel(
      builder: (_) => SplashScreenWidget(),
    ),
    "/home": ScreenModel(
      builder: (_) => RootScreenWidget(),
    ),
    "/edit": ScreenModel(
      builder: (_) => EditScreenWidget(),
    ),
    "/view": ScreenModel(
      builder: (_) => ViewScreenWidget(),
    ),
    "/upload": ScreenModel(
      builder: (_) => UploadScreenWidget(),
    ),
    "/tag": ScreenModel(
      builder: (_) => TagScreenWidget(),
    ),
  };

  Map<String, ScreenModel> get screens => _screens;
}
