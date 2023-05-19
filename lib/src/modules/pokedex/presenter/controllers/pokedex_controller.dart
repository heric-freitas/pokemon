import 'package:mobx/mobx.dart';

import '../../../../core/components/dialog_filter.dart';
import '../../models/pokemon_models.dart';

part 'pokedex_controller.g.dart';

enum PokedexStateStatus {
  initial,
  loading,
  success,
  error,
  
}

class PokedexController = PokedexControllerBase with _$PokedexController;

abstract class PokedexControllerBase with Store {
  @readonly
  Filter? _filter = Filter.name;

  @readonly
  List<PokemonModels> _listPokemon = [];

  @readonly
  PokedexStateStatus _pokedexStateStatus = PokedexStateStatus.initial;

  @action
  Future<void> getPokemon() async {
    try {
      _pokedexStateStatus = PokedexStateStatus.loading;
      await Future.delayed(Duration(seconds: 2));
      _listPokemon = [
        PokemonModels('A', 3),
        PokemonModels('B', 1),
        PokemonModels('C', 2),
      ] ;
      _pokedexStateStatus = PokedexStateStatus.success;
    } catch (e) {
      _pokedexStateStatus = PokedexStateStatus.error;
    }
  }

  @action
  void changeFilter(Filter? filter) {
    _filter = filter;
    sortListFilter();
  }

  @action
  void sortListFilter() {
    switch (_filter) {
      case Filter.name:
        _listPokemon.sort((a, b) => a.name.compareTo(b.name));
      case Filter.number || null:
        _listPokemon.sort((a, b) => a.index.compareTo(b.index));
    }
  }
}
