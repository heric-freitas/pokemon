import 'package:pokemon/src/core/rest_client/rest_client_response.dart';
import 'package:pokemon/src/modules/details_pokemon/infra/datasources/details_pokemon_datasource.dart';

import '../../../../core/rest_client/dio_rest_client.dart';

class DetailsPokemonDatasourceImpl implements DetailsPokemonDatasource {
  final DioRestClient _dioRestClient;

  DetailsPokemonDatasourceImpl(this._dioRestClient);

  @override
  Future<RestClientResponse> getDetailsPokemon(String name) async {
    try {
      return await _dioRestClient.get('/pokemon/$name');
    } catch (e) {
      throw Exception(e);
    }
  }
}
