import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon/src/modules/details_pokemon/presenter/usecases/get_details_pokemon.dart';

import '../../../model/details_info_pokemon_model.dart';

part 'details_pokemon_event.dart';
part 'details_pokemon_state.dart';

class DetailsPokemonBloc
    extends Bloc<DetailsPokemonEvent, DetailsPokemonState> {
  final GetDetailsPokemon _detailsPokemon;
  DetailsPokemonBloc(this._detailsPokemon) : super(DetailsPokemonInitial()) {
    on<DetailsPokemonEvent>((event, emit) {});
    on<GetDetailsPokemonEvent>(_getDetailsPokemon);
  }

  void _getDetailsPokemon(GetDetailsPokemonEvent event, Emitter<DetailsPokemonState> emit) async {
    try {
      emit(DetailsPokemonLoading());
      final pokemon = await _detailsPokemon(event.name);
      emit(DetailsPokemonLoaded(pokemon));
    } catch (e) {
      emit(DetailsPokemonFailure(e.toString()));
    }
  }
}
