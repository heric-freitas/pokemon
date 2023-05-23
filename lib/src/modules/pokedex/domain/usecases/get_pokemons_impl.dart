import '../../models/list_pokemons_models.dart';
import '../../presenter/usecases/get_pokemons.dart';

import '../infra/pokedex_repository.dart';

class GetPokemonsImpl implements GetPokemons {

  final PokedexRepository _pokedexRepository;

  GetPokemonsImpl(this._pokedexRepository);

  @override
  Future<ListPokemonsModels> call(String? next) async {
    return await _pokedexRepository.getPokemons(next);
  }
}