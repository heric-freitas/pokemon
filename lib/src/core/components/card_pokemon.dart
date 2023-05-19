import 'package:flutter/material.dart';
import '../styles/app_color.dart';
import '../styles/app_text_styles.dart';

class CardPokemon extends StatelessWidget {
  final String name;
  final int index;
  const CardPokemon({Key? key, required this.name, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: context.appColor.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 4),
                child: Text(
                  '$index',
                  style: context.appTextStyles.caption
                      .copyWith(color: context.appColor.medium),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: context.appColor.background,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset('assets/icons/pokeball.png'),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
                child: Text(
                  name,
                  style: context.appTextStyles.caption
                      .copyWith(color: context.appColor.medium),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
