import '../../models/pokemon_models.dart';
import '../../presenter/usecases/get_pokemons.dart';

import '../infra/pokedex_repository.dart';

class GetPokemonsImpl implements GetPokemons {

  final PokedexRepository _pokedexRepository;

  GetPokemonsImpl(this._pokedexRepository);

  @override
  Future<List<String>> call(int limit, int offset) async {
    return await _pokedexRepository.getPokemons(limit, offset);
  }
}