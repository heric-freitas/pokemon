import 'package:flutter/material.dart';

import '../styles/app_color.dart';
import '../styles/app_text_styles.dart';

class PokemonTypeWidget extends StatelessWidget {
  final String type;
  const PokemonTypeWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.appColorType.mapColors[type.toLowerCase()],
        ),
        child: Text(
          type,
          style: context.appTextStyles.subtitle3
              .copyWith(color: context.appColor.white),
        ),
      ),
    );
  }
}
