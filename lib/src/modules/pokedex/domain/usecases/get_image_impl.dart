import '../../models/pokemon_models.dart';
import '../../presenter/usecases/get_image.dart';
import '../infra/pokedex_repository.dart';

class GetImageImpl implements GetImage {
  final PokedexRepository _pokedexRepository;

  GetImageImpl(this._pokedexRepository);

  @override
  Future<PokemonModels> call(String url) async {
    try {
      return await _pokedexRepository.getImage(url);
    } catch (e) {
      throw Exception(e);
    }
  }
}
