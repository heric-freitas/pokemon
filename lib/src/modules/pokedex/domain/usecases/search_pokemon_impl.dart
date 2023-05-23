import 'package:pokemon/src/modules/pokedex/models/pokemon_models.dart';
import 'package:pokemon/src/modules/pokedex/presenter/usecases/search_pokemon.dart';

import '../infra/pokedex_repository.dart';

class SearchPokemonImpl implements SearchPokemon{

  final PokedexRepository _pokedexRepository;

  SearchPokemonImpl(this._pokedexRepository);

  @override
  Future<PokemonModels> call(String search) async {
    return await _pokedexRepository.search(search);
  }
}