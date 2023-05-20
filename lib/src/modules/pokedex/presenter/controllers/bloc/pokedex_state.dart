part of 'pokedex_bloc.dart';

@Immutable()
sealed class PokedexState {
  int limit = 30;
  int offset = 0;
  Filter? filter = Filter.name;
  List<PokemonModels> list = [];
}

class PokedexInitial extends PokedexState {}

class PokedexLoading extends PokedexState {}

class PokedexLoad extends PokedexState {
  int offset;
  Filter? filter;
  List<PokemonModels> list;
  PokedexLoad(this.list, this.filter, this.offset);
}

class PokedexFailure extends PokedexState {
  final String message;

  PokedexFailure(this.message);
}

class PokedexFilted extends PokedexState {
  @override
  final Filter? filter;
  @override
  final List<PokemonModels> list;
  PokedexFilted(this.list, this.filter);
}
