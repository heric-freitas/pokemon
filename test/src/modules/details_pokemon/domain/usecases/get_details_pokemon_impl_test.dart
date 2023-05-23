import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/src/modules/details_pokemon/domain/infra/details_pokemon_repository.dart';
import 'package:pokemon/src/modules/details_pokemon/domain/usecases/get_details_pokemon_impl.dart';
import 'package:pokemon/src/modules/details_pokemon/model/details_info_pokemon_model.dart';

class MockDetailsPokemonRepository extends Mock
    implements DetailsPokemonRepository {}

void main() {
  late GetDetailsPokemonImpl getDetailsPokemon;
  late MockDetailsPokemonRepository mockDetailsPokemonRepository;

  setUp(() {
    mockDetailsPokemonRepository = MockDetailsPokemonRepository();
    getDetailsPokemon = GetDetailsPokemonImpl(mockDetailsPokemonRepository);
  });

  group('call', () {
    test('should return DetailsInfoPokemonModel when repository returns data',
        () async {
      // Arrange
      final stats = [
        Stats(name: 'HP', baseStat: 80),
        Stats(name: 'Attack', baseStat: 100),
        Stats(name: 'Defense', baseStat: 70),
        // Adicione mais estatísticas se necessário
      ];
      const name = 'pikachu';
      final expectedResponse = DetailsInfoPokemonModel(
        height: 20,
        order: 1,
        sprites: 'https://example.com/pikachu.png',
        types: ['Electric'],
        weight: 60,
        stats: stats,
        abilities: ['Static', 'Lightning Rod'],
      );
      when(() => mockDetailsPokemonRepository.getDetailsPOkemon(name))
          .thenAnswer((_) async => expectedResponse);

      // Act
      final result = await getDetailsPokemon(name);

      // Assert
      expect(result, equals(expectedResponse));
      verify(() => mockDetailsPokemonRepository.getDetailsPOkemon(name))
          .called(1);
    });

    test('should throw an exception when repository throws an error', () async {
      // Arrange
      const name = 'pikachu';
      final expectedError = Exception('Error getting Pokemon details');
      when(() => mockDetailsPokemonRepository.getDetailsPOkemon(name))
          .thenThrow(expectedError);

      // Act
      Future<void> action() async {
        await getDetailsPokemon(name);
      }

      // Assert
      expect(action, throwsException);
      verify(() => mockDetailsPokemonRepository.getDetailsPOkemon(name))
          .called(1);
    });
  });
}
