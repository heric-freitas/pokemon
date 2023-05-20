import 'package:flutter/material.dart';

import '../styles/app_color.dart';
import 'dialog_filter.dart';

class FilterPokemon extends StatelessWidget {
  final Filter? filterByNumber;
  final VoidCallback onPressed;
  const FilterPokemon(
      {Key? key, required this.filterByNumber, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: context.appColor.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            'assets/icons/${filterByNumber == Filter.number ? 'numer_filter.png' : 'name_filter.png'}',
            color: context.appColor.primary,
          ),
        ),
      ),
    );
  }
}
