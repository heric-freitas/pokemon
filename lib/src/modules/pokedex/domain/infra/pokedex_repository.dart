import '../../models/list_pokemons_models.dart';
import '../../models/pokemon_models.dart';

abstract interface class PokedexRepository {
  Future<ListPokemonsModels> getPokemons(String? next);
  Future<PokemonModels> getImage(String url);
  Future<PokemonModels> search(String search);
}