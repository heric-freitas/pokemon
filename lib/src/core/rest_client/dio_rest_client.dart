import 'package:dio/dio.dart';
import '../env/env.dart';
import 'rest_client.dart';
import 'rest_client_response.dart';

class DioRestClient implements RestClient {
  late final Dio _dio;

  final _defaultOptions = BaseOptions(
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    baseUrl: Env.instance.get('base_url'),
  );

  DioRestClient() {
    _dio = Dio(_defaultOptions);
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e, s) {
      return Error.throwWithStackTrace(Exception(e), s);
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter<T>(response);
    } on DioError catch (e, s) {
      return Error.throwWithStackTrace(Exception(e), s);
    }
  }

  RestClientResponse<T> _dioResponseConverter<T>(Response<T> response) =>
      RestClientResponse<T>(
        data: response.data as T,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
}
