import '../../models/pokemon_models.dart';

abstract interface class PokedexRepository {
  Future<List<String>> getPokemons(int limit, int offset);
  Future<PokemonModels> getImage(String url);
}