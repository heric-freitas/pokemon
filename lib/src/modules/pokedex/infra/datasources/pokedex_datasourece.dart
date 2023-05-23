import '../../../../core/rest_client/rest_client_response.dart';

abstract interface class PokedexDatasource {
  Future<RestClientResponse> getPokemons(String? next);
  Future<RestClientResponse> getImage(String url);
  Future<RestClientResponse> search(String search);
}