import 'rest_client_response.dart';

abstract interface class RestClient {
  Future<RestClientResponse<T>> post<T>(
    String path, {
    Object data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}
