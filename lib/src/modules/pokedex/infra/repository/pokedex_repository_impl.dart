import '../../domain/infra/pokedex_repository.dart';
import '../../models/list_pokemons_models.dart';
import '../../models/pokemon_models.dart';

import '../datasources/pokedex_datasourece.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  final PokedexDatasource _pokedexDatasource;

  PokedexRepositoryImpl(this._pokedexDatasource);

  @override
  Future<ListPokemonsModels> getPokemons(String? next) async {
    try {
      final result = await _pokedexDatasource.getPokemons(next);
      return ListPokemonsModels.fromMap(result.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<PokemonModels> getImage(String url) async {
    try {
      final result = await _pokedexDatasource.getImage(url);
      return PokemonModels.fromMap(result.data);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<PokemonModels> search(String search) async {
    try {
      final result = await _pokedexDatasource.search(search);
      return PokemonModels.fromMap(result.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
