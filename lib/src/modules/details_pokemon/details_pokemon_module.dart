import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/src/modules/details_pokemon/domain/usecases/get_details_pokemon_impl.dart';
import 'package:pokemon/src/modules/details_pokemon/infra/repository/details_pokemon_impl.dart';
import 'package:pokemon/src/modules/details_pokemon/ui/details_pokemon_page.dart';
import 'package:provider/provider.dart';

import 'data/datasource/details_pokemon_datasource_impl.dart';
import 'domain/infra/details_pokemon_repository.dart';
import 'infra/datasources/details_pokemon_datasource.dart';
import 'presenter/controllers/bloc/details_pokemon_bloc.dart';
import 'presenter/usecases/get_details_pokemon.dart';

class DetailsPokemonModule extends StatelessWidget {
  final String name;
  const DetailsPokemonModule({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider<DetailsPokemonDatasource>(
            create: (context) => DetailsPokemonDatasourceImpl(context.read())),
        RepositoryProvider<DetailsPokemonRepository>(
            create: (context) => DetailsPokemonRepositoryImpl(context.read())),
        RepositoryProvider<GetDetailsPokemon>(
            create: (context) => GetDetailsPokemonImpl(context.read())),
        BlocProvider(create: (context) => DetailsPokemonBloc(context.read()))
      ],
      child: DetailsPokemonPage(name: name),
    );
  }
}
