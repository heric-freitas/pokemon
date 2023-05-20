import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/src/modules/pokedex/presenter/usecases/get_image.dart';
import 'domain/usecases/get_image.dart';
import 'presenter/controllers/bloc/pokedex_bloc.dart';
import 'ui/pokedex_page.dart';
import 'package:provider/provider.dart';

import 'data/datasource/pokedex_datasource_impl.dart';
import 'domain/infra/pokedex_repository.dart';
import 'domain/usecases/get_pokemons_impl.dart';
import 'infra/datasources/pokedex_datasourece.dart';
import 'infra/repository/pokedex_repository_impl.dart';
import 'presenter/usecases/get_pokemons.dart';

class PokedexModule extends StatelessWidget {
  const PokedexModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider<PokedexDatasource>(
          create: (context) => PokedexDatasourceImpl(
            context.read(),
          ),
        ),
        RepositoryProvider<PokedexRepository>(
          create: (context) => PokedexRepositoryImpl(
            context.read(),
          ),
        ),
        RepositoryProvider<GetPokemons>(
          create: (context) => GetPokemonsImpl(
            context.read(),
          ),
        ),
        RepositoryProvider<GetImage>(
          create: (context) => GetImageImpl(
            context.read(),
          ),
        ),
        BlocProvider(
          create: (context) => PokedexBloc(
            context.read(),
            context.read(),
          ),
        )
      ],
      child: const PokedexPage(),
    );
  }
}
