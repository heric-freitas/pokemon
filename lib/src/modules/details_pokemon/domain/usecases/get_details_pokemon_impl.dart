import 'package:pokemon/src/modules/details_pokemon/model/details_info_pokemon_model.dart';
import 'package:pokemon/src/modules/details_pokemon/presenter/usecases/get_details_pokemon.dart';

import '../infra/details_pokemon_repository.dart';

class GetDetailsPokemonImpl implements GetDetailsPokemon {

  final DetailsPokemonRepository _detailsPokemonRepository;

  GetDetailsPokemonImpl(this._detailsPokemonRepository);

  @override
  Future<DetailsInfoPokemonModel> call(String name) async {
    return await _detailsPokemonRepository.getDetailsPOkemon(name);
  }
}