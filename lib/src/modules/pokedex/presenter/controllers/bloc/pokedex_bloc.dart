import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon/src/modules/pokedex/presenter/usecases/search_pokemon.dart';
import '../../../../../core/components/dialog_filter.dart';
import '../../../models/list_pokemons_models.dart';
import '../../../models/pokemon_models.dart';
import '../../usecases/get_pokemons.dart';

import '../../usecases/get_image.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final GetPokemons _getPokemons;
  final GetImage _getImage;
  final SearchPokemon _searchPokemon;

  PokedexBloc(this._getPokemons, this._getImage, this._searchPokemon)
      : super(const PokedexState(
          PokedexStatus.initial,
          ListPokemonsModels(null, []),
          Filter.number,
          [],
        )) {
    on<GetPokemonsEvent>(_getPokemonsEvent);
    on<FilterListEvent>(_filterList);
    on<GetMorePokemonsEvent>(_getMorePokemonsEvent);
    on<SearchEvent>(_search);
  }

  void _getPokemonsEvent(
      GetPokemonsEvent event, Emitter<PokedexState> emit) async {
    try {
      emit(state.copyWith(
        status: PokedexStatus.loading,
        list: [],
        listPokemonsModels: const ListPokemonsModels(null, []),
      ));
      final list = await _getPokemons(state.listPokemonsModels.next);
      final pokemon = await _getInfoPokemon(list.results);
      emit(state.copyWith(
          status: PokedexStatus.success,
          list: pokemon,
          listPokemonsModels: list));
    } catch (e) {
      emit(state.copyWith(status: PokedexStatus.failure));
    }
  }

  void _getMorePokemonsEvent(
      GetMorePokemonsEvent event, Emitter<PokedexState> emit) async {
    try {
      emit(state.copyWith(status: PokedexStatus.loadingMorePokemon));
      final list = await _getPokemons(state.listPokemonsModels.next);
      final pokemon = await _getInfoPokemon(list.results);
      final newList = [...state.list, ...pokemon];
      emit(state.copyWith(
          status: PokedexStatus.success,
          list: newList,
          listPokemonsModels: list));
    } catch (e) {
      emit(state.copyWith(status: PokedexStatus.failure));
    }
  }

  void _filterList(FilterListEvent event, Emitter<PokedexState> emit) {
    switch (event.filter) {
      case Filter.name:
        state.list.sort((a, b) => a.name.compareTo(b.name));
      case Filter.number || null:
        state.list.sort((a, b) => a.index.compareTo(b.index));
    }
    emit(state.copyWith(
        status: PokedexStatus.filted, filter: event.filter, list: state.list));
  }

  void _search(SearchEvent event, Emitter<PokedexState> emit) async {
    try {
      final pokemon = await _searchPokemon(event.search.toLowerCase());
      emit(
          state.copyWith(status: PokedexStatus.successSearch, list: [pokemon]));
    } catch (e) {
      emit(state.copyWith(status: PokedexStatus.failure));
    }
  }

  Future<List<PokemonModels>> _getInfoPokemon(List<String> list) async {
    final futurePokemons = list.map((e) => _getImage(e));

    return await Future.wait(futurePokemons);
  }
}
