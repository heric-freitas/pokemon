import '../../../../core/rest_client/rest_client_response.dart';

abstract interface class PokedexDatasource {
  Future<RestClientResponse> getPokemons(int limit, int offset);
  Future<RestClientResponse> getImage(String url);
}