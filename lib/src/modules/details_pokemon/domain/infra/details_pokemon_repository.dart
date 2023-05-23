import '../../model/details_info_pokemon_model.dart';

abstract interface class DetailsPokemonRepository {
  Future<DetailsInfoPokemonModel> getDetailsPOkemon(String name);
}