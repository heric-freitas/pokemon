import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/src/core/rest_client/dio_rest_client.dart';
import 'package:pokemon/src/core/rest_client/rest_client_response.dart';
import 'package:pokemon/src/modules/details_pokemon/data/datasource/details_pokemon_datasource_impl.dart';

class MockDioRestClient extends Mock implements DioRestClient {}

void main() {
  late DetailsPokemonDatasourceImpl detailsPokemonDatasource;
  late MockDioRestClient mockDioRestClient;

  setUp(() {
    mockDioRestClient = MockDioRestClient();
    detailsPokemonDatasource = DetailsPokemonDatasourceImpl(mockDioRestClient);
  });

  group('getDetailsPokemon', () {
    test('should return RestClientResponse when DioRestClient succeeds', () async {
      // Arrange
      const name = 'pikachu';
      final expectedResponse = RestClientResponse(statusCode: 200, data: {'id': 25, 'name': 'Pikachu'});
      when(()=>mockDioRestClient.get('/pokemon/$name')).thenAnswer((_) async => expectedResponse);

      // Act
      final result = await detailsPokemonDatasource.getDetailsPokemon(name);

      // Assert
      expect(result, equals(expectedResponse));
      verify(()=>mockDioRestClient.get('/pokemon/$name')).called(1);
    });

    test('should throw an exception when DioRestClient throws an error', () async {
      // Arrange
      const name = 'pikachu';
      final expectedError = Exception('Error getting Pokemon details');
      when(()=>mockDioRestClient.get('/pokemon/$name')).thenThrow(expectedError);

      // Act
      Future<void> action() async {
        await detailsPokemonDatasource.getDetailsPokemon(name);
      }

      // Assert
      expect(action, throwsException);
      verify(()=>mockDioRestClient.get('/pokemon/$name')).called(1);
    });
  });
}
