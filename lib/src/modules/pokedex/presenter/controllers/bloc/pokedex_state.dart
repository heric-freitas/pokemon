// ignore_for_file: must_be_immutable

part of 'pokedex_bloc.dart';

enum PokedexStatus {
  initial,
  loading,
  loadingMorePokemon,
  success,
  successSearch,
  filted,
  failure,
  loadingSearch,
}

final class PokedexState extends Equatable {
  final PokedexStatus status;
  final Filter filter;
  final List<PokemonModels> list;
  final ListPokemonsModels listPokemonsModels;

  const PokedexState(
      this.status, this.listPokemonsModels, this.filter, this.list);

  PokedexState copyWith({
    PokedexStatus? status,
    Filter? filter,
    List<PokemonModels>? list,
    ListPokemonsModels? listPokemonsModels,
  }) {
    return PokedexState(
        status ?? this.status,
        listPokemonsModels ?? this.listPokemonsModels,
        filter ?? this.filter,
        list ?? this.list);
  }

  @override
  List<Object?> get props => [list, filter, listPokemonsModels, status];
}
