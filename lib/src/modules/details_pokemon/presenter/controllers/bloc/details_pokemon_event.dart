part of 'details_pokemon_bloc.dart';

abstract class DetailsPokemonEvent extends Equatable {
  const DetailsPokemonEvent();

  @override
  List<Object> get props => [];
}

class GetDetailsPokemonEvent extends DetailsPokemonEvent {
  final String name;

  GetDetailsPokemonEvent(this.name);
}
