import 'package:flutter/material.dart';

class AppColor {
  static AppColor? _instance;

  AppColor._();
  static AppColor get instance {
    _instance ??= AppColor._();
    return _instance!;
  }

  Color get primary => const Color(0xFFDC0A2D);
  Color get dark => const Color(0xFF212121);
  Color get medium => const Color(0xFF666666);
  Color get light => const Color(0xFFE0E0E0);
  Color get background => const Color(0xFFEFEFEF);
  Color get white => const Color(0xFFFFFFFF);
}

class ColorType {
  static ColorType? _instance;

  ColorType._();
  static ColorType get instance {
    _instance ??= ColorType._();
    return _instance!;
  }

  Color get bug => const Color(0xFFA7B723);
  Color get dark => const Color(0xFF75574C);
  Color get dragon => const Color(0xFF7037FF);
  Color get eletrick => const Color(0xFFF9CF30);
  Color get fairy => const Color(0xFFE69EAC);
  Color get fighting => const Color(0xFFC12239);
  Color get fire => const Color(0xFFF57D31);
  Color get flying => const Color(0xFFA891EC);
  Color get ghost => const Color(0xFF70559B);
  Color get normal => const Color(0xFFAAA67F);
  Color get grass => const Color(0xFF74CB48);
  Color get ground => const Color(0xFFDEC16B);
  Color get ice => const Color(0xFF9AD6DF);
  Color get poison => const Color(0xFFA43E9E);
  Color get psychic => const Color(0xFFFB5584);
  Color get rock => const Color(0xFFB69E31);
  Color get steel => const Color(0xFFB7B9D0);
  Color get water => const Color(0xFF6493EB);

  Map<String, Color> mapColors = {
    'bug' : const Color(0xFFA7B723),
    'dark' : const Color(0xFF75574C),
    'dragon' : const Color(0xFF7037FF),
    'electric' : const Color(0xFFF9CF30),
    'fairy' : const Color(0xFFE69EAC),
    'fighting' : const Color(0xFFC12239),
    'fire' : const Color(0xFFF57D31),
    'flying' : const Color(0xFFA891EC),
    'ghost' : const Color(0xFF70559B),
    'normal' : const Color(0xFFAAA67F),
    'grass' : const Color(0xFF74CB48),
    'ground' : const Color(0xFFDEC16B),
    'ice' : const Color(0xFF9AD6DF),
    'poison' : const Color(0xFFA43E9E),
    'psychic' : const Color(0xFFFB5584),
    'rock' : const Color(0xFFB69E31),
    'steel' : const Color(0xFFB7B9D0),
    'water' : const Color(0xFF6493EB),
  };
}

extension AppColorExtensions on BuildContext {
  ColorType get appColorType => ColorType.instance;
  AppColor get appColor => AppColor.instance;
}