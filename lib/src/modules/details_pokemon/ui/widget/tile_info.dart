import 'package:flutter/material.dart';
import 'package:pokemon/src/core/styles/app_color.dart';
import 'package:pokemon/src/core/styles/app_text_styles.dart';

class TileInfo extends StatelessWidget {
  final String value;
  final String info;
  final String image;

  const TileInfo({Key? key, required this.value, required this.info, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(
              height: 12,
              width: 10,
              child: Image.asset(image),
            ),
            const SizedBox(
              width: 11,
            ),
            Text(
              value,
              style: context.appTextStyles.body3
                  .copyWith(color: context.appColor.dark),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          info,
          style: context.appTextStyles.caption
              .copyWith(color: context.appColor.medium),
        )
      ],
    );
  }
}
