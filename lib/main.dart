import 'package:flutter/material.dart';

import 'src/core/env/env.dart';
import 'src/pokemon_app.dart';
// import 'src/core/env/env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.instance.load();
  return runApp(const PokemonApp());
}
