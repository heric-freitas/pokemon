import 'dart:developer';

import 'package:pokemon/src/modules/details_pokemon/domain/infra/details_pokemon_repository.dart';
import 'package:pokemon/src/modules/details_pokemon/model/details_info_pokemon_model.dart';

import '../datasources/details_pokemon_datasource.dart';

class DetailsPokemonRepositoryImpl implements DetailsPokemonRepository {

  final DetailsPokemonDatasource _detailsPokemonDatasource;

  DetailsPokemonRepositoryImpl(this._detailsPokemonDatasource);

  @override
  Future<DetailsInfoPokemonModel> getDetailsPOkemon(String name) async {
    try {
      final result = await _detailsPokemonDatasource.getDetailsPokemon(name);
      return DetailsInfoPokemonModel.fromMap(result.data);
    } catch (e, s) {
      log('deu ruim', error: e, stackTrace: s);
      throw Exception(e);
    }
  }
}