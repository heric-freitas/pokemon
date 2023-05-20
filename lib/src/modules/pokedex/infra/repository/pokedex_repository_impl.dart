import '../../domain/infra/pokedex_repository.dart';
import '../../models/pokemon_models.dart';

import '../datasources/pokedex_datasourece.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  final PokedexDatasource _pokedexDatasource;

  PokedexRepositoryImpl(this._pokedexDatasource);

  @override
  Future<List<String>> getPokemons(int limit, int offset) async {
    try {
      final result = await _pokedexDatasource.getPokemons(limit, offset);
      final list = result.data['results'] as List;
      return list.map((e) => e['url'] as String).toList();
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
}
