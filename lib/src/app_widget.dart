import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  Widget build(BuildContext context) {
    Modular.setInitialRoute('/pokedex');

    return MaterialApp.router(
      title: 'Pokémon',
      theme: AppTheme.theme,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
