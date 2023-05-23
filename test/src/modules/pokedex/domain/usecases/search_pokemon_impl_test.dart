import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/src/modules/pokedex/domain/infra/pokedex_repository.dart';
import 'package:pokemon/src/modules/pokedex/domain/usecases/search_pokemon_impl.dart';
import 'package:pokemon/src/modules/pokedex/models/pokemon_models.dart';

class MockPokedexRepository extends Mock implements PokedexRepository {}

void main() {
  late SearchPokemonImpl searchPokemon;
  late MockPokedexRepository mockPokedexRepository;

  setUp(() {
    mockPokedexRepository = MockPokedexRepository();
    searchPokemon = SearchPokemonImpl(mockPokedexRepository);
  });

  group('call', () {
    test('should return PokemonModels when repository returns data', () async {
      // Arrange
      const search = 'charizard';
      const expectedResponse = PokemonModels(
          index: 6,
          name: 'Charizard',
          image: 'https://example.com/charizard.png');
      when(() => mockPokedexRepository.search(search))
          .thenAnswer((_) async => expectedResponse);

      // Act
      final result = await searchPokemon.call(search);

      // Assert
      expect(result, equals(expectedResponse));
      verify(() => mockPokedexRepository.search(search)).called(1);
    });

    test('should throw an exception when repository throws an error', () async {
      // Arrange
      const search = 'charizard';
      final expectedError = Exception('Error searching Pokemon');
      when(() => mockPokedexRepository.search(search)).thenThrow(expectedError);

      // Act
      Future<void> action() async {
        await searchPokemon.call(search);
      }

      // Assert
      expect(action, throwsException);
      verify(() => mockPokedexRepository.search(search)).called(1);
    });
  });
}
