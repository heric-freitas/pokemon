part of 'pokedex_bloc.dart';

@immutable
abstract class PokedexEvent {}

class GetPokemonsEvent extends PokedexEvent {}

class GetMorePokemonsEvent extends PokedexEvent {}

class FilterListEvent extends PokedexEvent {
  final Filter? filter;

  FilterListEvent(this.filter);
}