import 'package:pokemon/src/modules/pokedex/models/pokemon_models.dart';

abstract interface class SearchPokemon {
  Future<PokemonModels> call(String search);
}