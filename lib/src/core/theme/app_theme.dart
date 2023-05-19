import 'package:flutter/material.dart';

import '../styles/app_color.dart';

class AppTheme {
  AppTheme._();

  static final theme = ThemeData(
    scaffoldBackgroundColor: AppColor.instance.primary,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.instance.primary,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColor.instance.white),
    ),
    iconTheme: IconThemeData(
      color: AppColor.instance.primary,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.instance.primary,
      primary: AppColor.instance.primary,
      secondary: AppColor.instance.white,
    ),
    
  );
}
