import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/src/core/rest_client/rest_client_response.dart';
import 'package:pokemon/src/modules/pokedex/infra/datasources/pokedex_datasourece.dart';
import 'package:pokemon/src/modules/pokedex/infra/repository/pokedex_repository_impl.dart';
import 'package:pokemon/src/modules/pokedex/models/list_pokemons_models.dart';
import 'package:pokemon/src/modules/pokedex/models/pokemon_models.dart';

class MockPokedexDatasource extends Mock implements PokedexDatasource {}

void main() {
  late PokedexRepositoryImpl pokedexRepository;
  late MockPokedexDatasource mockPokedexDatasource;

  setUp(() {
    mockPokedexDatasource = MockPokedexDatasource();
    pokedexRepository = PokedexRepositoryImpl(mockPokedexDatasource);
  });

  group('getPokemons', () {
    test('should return ListPokemonsModels when datasource returns data',
        () async {
      // Arrange
      const next = '/pokemon?limit=25&offset=0';
      const datasourceResponse = RestClientResponse(
          statusCode: 200,
          data: {'results': [], 'next': '/pokemon?limit=50&offset=25'});
      const expectedResponse =
          ListPokemonsModels('/pokemon?limit=50&offset=25', []);
      when(() => mockPokedexDatasource.getPokemons(next))
          .thenAnswer((_) async => datasourceResponse);

      // Act
      final result = await pokedexRepository.getPokemons(next);

      // Assert
      expect(result, equals(expectedResponse));
      verify(()=>mockPokedexDatasource.getPokemons(next)).called(1);
    });

    test('should throw an exception when datasource throws an error', () async {
      // Arrange
      const next = '/pokemon?limit=25&offset=0';
      final expectedError = Exception('Error fetching pokemons');
      when(()=>mockPokedexDatasource.getPokemons(next)).thenThrow(expectedError);

      // Act
      Future<void> action() async {
        await pokedexRepository.getPokemons(next);
      }

      // Assert
      expect(action, throwsException);
      verify(()=>mockPokedexDatasource.getPokemons(next)).called(1);
    });
  });

  group('getImage', () {
    test('should return PokemonModels when datasource returns data', () async {
      // Arrange
      const url = 'https://example.com/pokemon.png';
      const datasourceResponse = RestClientResponse(statusCode: 200, data: {'index': 1, 'name': 'Pikachu', 'image': 'https://example.com/pikachu.png'});
      const expectedResponse = PokemonModels(index: 1, name: 'Pikachu', image: 'https://example.com/pikachu.png');
      when(()=> mockPokedexDatasource.getImage(url)).thenAnswer((_) async => datasourceResponse);

      // Act
      final result = await pokedexRepository.getImage(url);

      // Assert
      expect(result, equals(expectedResponse));
      verify(()=> mockPokedexDatasource.getImage(url)).called(1);
    });

    test('should throw an exception when datasource throws an error', () async {
      // Arrange
      const url = 'https://example.com/pokemon.png';
      final expectedError = Exception('Error getting Pokemon image');
      when(()=> mockPokedexDatasource.getImage(url)).thenThrow(expectedError);

      // Act
      Future<void> action() async {
        await pokedexRepository.getImage(url);
      }

      // Assert
      expect(action, throwsException);
      verify(()=> mockPokedexDatasource.getImage(url)).called(1);
    });
  });

  group('search', () {
    test('should return PokemonModels when datasource returns data', () async {
      // Arrange
      const search = 'pikachu';
      const datasourceResponse = RestClientResponse(statusCode: 200, data: {'index': 25, 'name': 'Pikachu', 'image': 'https://example.com/pikachu.png'});
      const expectedResponse = PokemonModels(index: 25, name: 'Pikachu', image: 'https://example.com/pikachu.png');
      when(()=>mockPokedexDatasource.search(search)).thenAnswer((_) async => datasourceResponse);

      // Act
      final result = await pokedexRepository.search(search);

      // Assert
      expect(result, equals(expectedResponse));
      verify(()=>mockPokedexDatasource.search(search)).called(1);
    });

    test('should throw an exception when datasource throws an error', () async {
      // Arrange
      const search = 'pikachu';
      final expectedError = Exception('Error searching Pokemon');
      when(()=>mockPokedexDatasource.search(search)).thenThrow(expectedError);

      // Act
      Future<void> action() async {
        await pokedexRepository.search(search);
      }

      // Assert
      expect(action, throwsException);
      verify(()=>mockPokedexDatasource.search(search)).called(1);
    });
  });
}
