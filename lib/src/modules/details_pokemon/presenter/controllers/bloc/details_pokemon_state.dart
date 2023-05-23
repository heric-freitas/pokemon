part of 'details_pokemon_bloc.dart';

sealed class DetailsPokemonState extends Equatable {
  const DetailsPokemonState();
  
  @override
  List<Object> get props => [];
}

class DetailsPokemonInitial extends DetailsPokemonState {}

class DetailsPokemonLoading extends DetailsPokemonState {}

class DetailsPokemonLoaded extends DetailsPokemonState {
  final DetailsInfoPokemonModel detailsInfoPokemonModel;

  const DetailsPokemonLoaded(this.detailsInfoPokemonModel);

  @override
  List<Object> get props => [detailsInfoPokemonModel];
}

class DetailsPokemonFailure extends DetailsPokemonState {
  final String message;

  const DetailsPokemonFailure(this.message);

  @override
  List<Object> get props => [message];
}
