import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/components/dialog_filter.dart';
import '../../../models/pokemon_models.dart';
import '../../usecases/get_pokemons.dart';

import '../../usecases/get_image.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final GetPokemons _getPokemons;
  final GetImage _getImage;

  PokedexBloc(this._getPokemons, this._getImage) : super(PokedexInitial()) {
    on<GetPokemonsEvent>(_getPokemonsEvent);
    on<FilterListEvent>(_filterList);
    on<GetMorePokemonsEvent>(_getMorePokemonsEvent);
  }

  void _getPokemonsEvent(
      GetPokemonsEvent event, Emitter<PokedexState> emit) async {
    try {
      emit(PokedexLoading());
      final list = await _getPokemons(state.limit, state.offset);
      final pokemon = await _getInfoPokemon(list);
      var newOffset = state.offset + state.limit;
      emit(PokedexLoad(pokemon, state.filter, newOffset));
    } catch (e) {
      emit(PokedexFailure(e.toString()));
    }
  }

  void _getMorePokemonsEvent(
      GetMorePokemonsEvent event, Emitter<PokedexState> emit) async {
    try {
      final list = await _getPokemons(state.limit, state.offset);
      final pokemon = await _getInfoPokemon(list);
      state.list.addAll(pokemon);
      var newOffset = state.offset + state.limit;
      emit(PokedexLoad(state.list, state.filter, newOffset));
    } catch (e) {
      emit(PokedexFailure(e.toString()));
    }
  }

  void _filterList(FilterListEvent event, Emitter<PokedexState> emit) {
    switch (event.filter) {
      case Filter.name:
        state.list.sort((a, b) => a.name.compareTo(b.name));
      case Filter.number || null:
        state.list.sort((a, b) => a.index.compareTo(b.index));
    }
    emit(PokedexFilted(state.list, event.filter));
  }

  Future<List<PokemonModels>> _getInfoPokemon(List<String> list) async {
    final futurePokemons = list.map((e) => _getImage(e));

    return await Future.wait(futurePokemons);
  }
}
