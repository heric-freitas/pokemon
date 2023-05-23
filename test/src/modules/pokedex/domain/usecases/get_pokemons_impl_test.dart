import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/src/modules/pokedex/domain/infra/pokedex_repository.dart';
import 'package:pokemon/src/modules/pokedex/domain/usecases/get_pokemons_impl.dart';
import 'package:pokemon/src/modules/pokedex/models/list_pokemons_models.dart';

class MockPokedexRepository extends Mock implements PokedexRepository {}

void main() {
  late GetPokemonsImpl getPokemons;
  late MockPokedexRepository mockPokedexRepository;

  setUp(() {
    mockPokedexRepository = MockPokedexRepository();
    getPokemons = GetPokemonsImpl(mockPokedexRepository);
  });

  group('call', () {
    test('should return ListPokemonsModels when repository returns data',
        () async {
      // Arrange
      const next = '/pokemon?limit=25&offset=0';
      const expectedResponse =
          ListPokemonsModels('/pokemon?limit=50&offset=25', []);
      when(() => mockPokedexRepository.getPokemons(next))
          .thenAnswer((_) async => expectedResponse);

      // Act
      final result = await getPokemons.call(next);

      // Assert
      expect(result, equals(expectedResponse));
      verify(()=>mockPokedexRepository.getPokemons(next)).called(1);
    });

    test('should throw an exception when repository throws an error', () async {
      // Arrange
      const next = '/pokemon?limit=25&offset=0';
      final expectedError = Exception('Error fetching pokemons');
      when(()=>mockPokedexRepository.getPokemons(next)).thenThrow(expectedError);

      // Act
      Future<void> action() async {
        await getPokemons.call(next);
      }

      // Assert
      expect(action, throwsException);
      verify(()=>mockPokedexRepository.getPokemons(next)).called(1);
    });
  });
}
