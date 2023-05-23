import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/src/core/rest_client/rest_client_response.dart';
import 'package:pokemon/src/modules/details_pokemon/infra/datasources/details_pokemon_datasource.dart';
import 'package:pokemon/src/modules/details_pokemon/infra/repository/details_pokemon_impl.dart';

import 'mock/mock.dart';

class MockDetailsPokemonDatasource extends Mock implements DetailsPokemonDatasource {}

void main() {
  late DetailsPokemonRepositoryImpl detailsPokemonRepository;
  late MockDetailsPokemonDatasource mockDetailsPokemonDatasource;

  setUp(() {
    mockDetailsPokemonDatasource = MockDetailsPokemonDatasource();
    detailsPokemonRepository = DetailsPokemonRepositoryImpl(mockDetailsPokemonDatasource);
  });

  group('getDetailsPOkemon', () {
    test('should return DetailsInfoPokemonModel when datasource returns data', () async {
      // Arrange
      const name = 'pikachu';
      final response = RestClientResponse(
        statusCode: 200,
        data: mock,
      );
      when(()=>mockDetailsPokemonDatasource.getDetailsPokemon(name)).thenAnswer((_) async => response);

      // Act
      await detailsPokemonRepository.getDetailsPOkemon(name);

      // Assert
      verify(()=>mockDetailsPokemonDatasource.getDetailsPokemon(name)).called(1);
    });

    test('should throw an exception when datasource throws an error', () async {
      // Arrange
      const name = 'pikachu';
      final expectedError = Exception('Error getting Pokemon details');
      when(()=>mockDetailsPokemonDatasource.getDetailsPokemon(name)).thenThrow(expectedError);

      // Act
      Future<void> action() async {
        await detailsPokemonRepository.getDetailsPOkemon(name);
      }

      // Assert
      expect(action, throwsException);
      verify(()=>mockDetailsPokemonDatasource.getDetailsPokemon(name)).called(1);
    });
  });
}
