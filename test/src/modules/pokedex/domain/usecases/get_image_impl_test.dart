import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/src/modules/pokedex/domain/infra/pokedex_repository.dart';
import 'package:pokemon/src/modules/pokedex/domain/usecases/get_image_impl.dart';
import 'package:pokemon/src/modules/pokedex/models/pokemon_models.dart';

class MockPokedexRepository extends Mock implements PokedexRepository {}

void main() {
  late GetImageImpl getImage;
  late MockPokedexRepository mockPokedexRepository;

  setUp(() {
    mockPokedexRepository = MockPokedexRepository();
    getImage = GetImageImpl(mockPokedexRepository);
  });

  group('call', () {
    test('should return PokemonModels when repository returns data', () async {
      // Arrange
      const url = 'https://example.com/image.png';
      const expectedResponse =
          PokemonModels(name: 'Charizard', image: url, index: 1);
      when(() => mockPokedexRepository.getImage(url))
          .thenAnswer((_) async => expectedResponse);

      // Act
      final result = await getImage.call(url);

      // Assert
      expect(result, equals(expectedResponse));
      verify(() => mockPokedexRepository.getImage(url)).called(1);
    });

    test('should throw an exception when repository throws an error', () async {
      // Arrange
      const url = 'https://example.com/image.png';
      final expectedError = Exception('Error fetching image');
      when(() => mockPokedexRepository.getImage(url)).thenThrow(expectedError);

      // Act
      Future<void> action() async {
        await getImage.call(url);
      }

      // Assert
      expect(action, throwsException);
      verify(() => mockPokedexRepository.getImage(url)).called(1);
    });
  });
}
