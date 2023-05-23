import '../../models/list_pokemons_models.dart';

abstract interface class GetPokemons {
  Future<ListPokemonsModels> call(String? next);
}