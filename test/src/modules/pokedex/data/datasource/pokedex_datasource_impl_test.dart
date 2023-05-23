import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/src/core/rest_client/dio_rest_client.dart';
import 'package:pokemon/src/core/rest_client/rest_client_response.dart';
import 'package:pokemon/src/modules/pokedex/data/datasource/pokedex_datasource_impl.dart';

class MockDioRestClient extends Mock implements DioRestClient {}

void main() {
  late PokedexDatasourceImpl datasource;
  late MockDioRestClient mockDioRestClient;

  setUp(() {
    mockDioRestClient = MockDioRestClient();
    datasource = PokedexDatasourceImpl(mockDioRestClient);
  });

  group('getPokemons', () {
    test(
        'should call DioRestClient.get with the correct endpoint when next is null',
        () async {
      // Arrange
      const expectedEndpoint = '/pokemon?limit=25&offset=0';
      const response = RestClientResponse(statusCode: 200, data: 'dummy data');
      when(() => mockDioRestClient.get(expectedEndpoint))
          .thenAnswer((_) async => response);

      // Act
      final result = await datasource.getPokemons(null);

      // Assert
      expect(result, equals(response));
      verify(() => mockDioRestClient.get(expectedEndpoint)).called(1);
    });

    test(
        'should call DioRestClient.get with the correct endpoint when next is not null',
        () async {
      // Arrange
      const next = '/pokemon?limit=50&offset=25';
      const response = RestClientResponse(statusCode: 200, data: 'dummy data');
      when(() => mockDioRestClient.get(next)).thenAnswer((_) async => response);

      // Act
      final result = await datasource.getPokemons(next);

      // Assert
      expect(result, equals(response));
      verify(() => mockDioRestClient.get(next)).called(1);
    });
  });

  group('getImage', () {
    test('should call DioRestClient.get with the correct URL', () async {
      // Arrange
      const url = 'https://example.com/image.png';
      const response = RestClientResponse(statusCode: 200, data: 'dummy data');
      when(() => mockDioRestClient.get(url)).thenAnswer((_) async => response);

      // Act
      final result = await datasource.getImage(url);

      // Assert
      expect(result, equals(response));
      verify(() => mockDioRestClient.get(url)).called(1);
    });
  });

  group('search', () {
    test('should call DioRestClient.get with the correct endpoint', () async {
      // Arrange
      const search = 'charizard';
      const expectedEndpoint = 'pokemon/$search';
      const response = RestClientResponse(statusCode: 200, data: 'dummy data');
      when(() => mockDioRestClient.get(expectedEndpoint))
          .thenAnswer((_) async => response);

      // Act
      final result = await datasource.search(search);

      // Assert
      expect(result, equals(response));
      verify(() => mockDioRestClient.get(expectedEndpoint)).called(1);
    });
  });
}
