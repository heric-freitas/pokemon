import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon/src/modules/pokedex/presenter/controllers/pokedex_controller.dart';

import 'ui/pokedex_page.dart';

class PokedexModule extends Module {

   @override
   List<Bind> get binds => [
    Bind.lazySingleton((i) => PokedexController()),
   ];

   @override
   List<ModularRoute> get routes => [
      ChildRoute('/', child: (context, args) => const PokedexPage())
   ];

}