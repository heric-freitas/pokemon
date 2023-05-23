import '../../../../core/rest_client/rest_client_response.dart';

abstract interface class DetailsPokemonDatasource {
  Future<RestClientResponse> getDetailsPokemon(String name);
}