import 'package:pokemon/src/modules/details_pokemon/model/details_info_pokemon_model.dart';

abstract interface class GetDetailsPokemon {
  Future<DetailsInfoPokemonModel> call(String name);
}