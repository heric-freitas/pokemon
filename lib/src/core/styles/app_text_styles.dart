import 'package:flutter/material.dart';

class AppTextStyles {
  static AppTextStyles? _instance;

  AppTextStyles._();
  static AppTextStyles get instance {
    _instance ??= AppTextStyles._();
    return _instance!;
  }

  TextStyle get textThin => const TextStyle(
        fontWeight: FontWeight.w100,
      );
  TextStyle get textExtraLight => const TextStyle(
        fontWeight: FontWeight.w200,
      );
  TextStyle get textLight => const TextStyle(
        fontWeight: FontWeight.w300,
      );
  TextStyle get textRegular => const TextStyle(
        fontWeight: FontWeight.normal,
      );
  TextStyle get textMedium => const TextStyle(
        fontWeight: FontWeight.w500,
      );
  TextStyle get textSemiBold => const TextStyle(
        fontWeight: FontWeight.w600,
      );
  TextStyle get textBold => const TextStyle(
        fontWeight: FontWeight.w700,
      );
  TextStyle get textExtraBold => const TextStyle(
        fontWeight: FontWeight.w800,
      );
  TextStyle get textBlack => const TextStyle(
        fontWeight: FontWeight.w900,
      );

  TextStyle get headlineBold => textBold.copyWith(fontSize: 24);
  TextStyle get subtitle3 => textBold.copyWith(fontSize: 10);
  TextStyle get subtitle2 => textBold.copyWith(fontSize: 12);
  TextStyle get subtitle1 => textBold.copyWith(fontSize: 14);
  TextStyle get body3 => textRegular.copyWith(fontSize: 10);
  TextStyle get body2 => textRegular.copyWith(fontSize: 12);
  TextStyle get body1 => textRegular.copyWith(fontSize: 14);
  TextStyle get caption => textRegular.copyWith(fontSize: 8);
}

extension AppTextStylesExtensions on BuildContext {
  AppTextStyles get appTextStyles => AppTextStyles.instance;
}
