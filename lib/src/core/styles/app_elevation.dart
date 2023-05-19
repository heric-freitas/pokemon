import 'package:flutter/material.dart';

class AppElevation {
  static AppElevation? _instance;

  AppElevation._();
  static AppElevation get instance {
    _instance ??= AppElevation._();
    return _instance!;
  }

  double get dropShadowTwo => 2.0;
  double get dropShadowSix => 6.0;
  double get innerShadowTwo => 2.0;
}

extension AppElevationExtensions on BuildContext {
  AppElevation get appElevation => AppElevation.instance;
}
