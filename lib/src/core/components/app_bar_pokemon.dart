import 'package:flutter/material.dart';

import '../styles/app_color.dart';
import '../styles/app_text_styles.dart';

class AppBarPokemon extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const AppBarPokemon({super.key, required this.title});

  @override
  State<AppBarPokemon> createState() => _AppBarPokemonState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _AppBarPokemonState extends State<AppBarPokemon> {
  bool canPop() {
    return Navigator.canPop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: widget.preferredSize.height,
        elevation: 0,
        leading: Visibility(
          visible: canPop(),
          replacement: Image.asset(
            'assets/icons/pokeball.png',
            color: context.appColor.white,
          ),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Image.asset(
              'assets/icons/arrow_left.png',
              color: context.appColor.white,
            ),
          ),
        ),
        title: Text(
          widget.title,
          style: context.appTextStyles.headlineBold
              .copyWith(color: context.appColor.white),
        ),
      ),
    );
  }
}
