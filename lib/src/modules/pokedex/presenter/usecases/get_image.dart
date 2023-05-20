import '../../models/pokemon_models.dart';

abstract interface class GetImage {
  Future<PokemonModels> call(String url);
}