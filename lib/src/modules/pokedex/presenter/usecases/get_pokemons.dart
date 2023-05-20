import '../../models/pokemon_models.dart';

abstract interface class GetPokemons {
  Future<List<String>> call(int limit, int offset);
}