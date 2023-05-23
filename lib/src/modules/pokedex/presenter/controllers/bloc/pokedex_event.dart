part of 'pokedex_bloc.dart';

sealed class PokedexEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetPokemonsEvent extends PokedexEvent {}

final class GetMorePokemonsEvent extends PokedexEvent {
}

final class FilterListEvent extends PokedexEvent {
  final Filter? filter;

  FilterListEvent(this.filter);
}

final class SearchEvent extends PokedexEvent {
  final String search;

  SearchEvent(this.search);
}