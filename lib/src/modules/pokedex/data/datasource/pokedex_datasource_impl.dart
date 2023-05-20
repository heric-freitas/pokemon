import '../../../../core/rest_client/rest_client_response.dart';
import '../../infra/datasources/pokedex_datasourece.dart';

import '../../../../core/rest_client/dio_rest_client.dart';

class PokedexDatasourceImpl implements PokedexDatasource {
  final DioRestClient _dioRestClient;

  PokedexDatasourceImpl(this._dioRestClient);

  @override
  Future<RestClientResponse> getPokemons(int limit, int offset) async {
    try {
      return await _dioRestClient.get('/pokemon?limit=$limit&offset=$offset');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<RestClientResponse> getImage(String url) async {
    try {
      return await _dioRestClient.get(url);
    } catch (e) {
      throw Exception(e);
    }
  }
}
