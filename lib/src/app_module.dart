import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon/src/modules/pokedex/pokedex_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute('/pokedex', module: PokedexModule())
  ];
}