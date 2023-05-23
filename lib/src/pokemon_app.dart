import 'package:flutter/material.dart';
import 'package:pokemon/src/modules/details_pokemon/details_pokemon_module.dart';

import 'core/theme/app_theme.dart';
import 'modules/core/core_module.dart';
import 'modules/pokedex/pokedex_module.dart';

class PokemonApp extends StatelessWidget {
  const PokemonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CoreModule(
      child: MaterialApp(
        theme: AppTheme.theme,
        title: 'Pokedex',
        initialRoute: '/pokedex',
        routes: {
          '/pokedex': (_) => const PokedexModule(),
          '/details': (context) => DetailsPokemonModule(
              name: ModalRoute.of(context)!.settings.arguments as String),
        },
      ),
    );
  }
}
