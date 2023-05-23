import 'package:flutter/material.dart';

import '../styles/app_color.dart';
import '../styles/app_text_styles.dart';

class AppBarPokemon extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final int? index;
  const AppBarPokemon({super.key, required this.title, this.index});

  @override
  State<AppBarPokemon> createState() => _AppBarPokemonState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
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
        leading: InkWell(
          onTap: Navigator.canPop(context)
              ? () {
                  Navigator.of(context).pop();
                }
              : null,
          child: Image.asset(
            Navigator.canPop(context)
                ? 'assets/icons/arrow_left.png'
                : 'assets/icons/pokeball.png',
                color: context.appColor.white,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: context.appTextStyles.headlineBold
                  .copyWith(color: context.appColor.white),
            ),
            Visibility(
              visible: widget.index != null,
              child: Text(
                '#${widget.index.toString().padLeft(3, '0')}',
                style: context.appTextStyles.subtitle2
                    .copyWith(color: context.appColor.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
