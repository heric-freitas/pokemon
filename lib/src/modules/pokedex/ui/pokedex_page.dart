import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pokemon/src/core/mixins/loader.dart';
import 'package:pokemon/src/core/mixins/messages.dart';

import '../../../core/components/app_bar_pokemon.dart';
import '../../../core/components/card_pokemon.dart';
import '../../../core/components/dialog_filter.dart';
import '../../../core/components/filter_pokemon.dart';
import '../../../core/components/search_widget.dart';
import '../../../core/styles/app_color.dart';
import '../presenter/controllers/pokedex_controller.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> with Loader, Messages {
  late final ReactionDisposer statusReactionDisposer;
  late final PokedexController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<PokedexController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      statusReactionDisposer =
          reaction((_) => controller.pokedexStateStatus, (status) {
        switch (status) {
          case PokedexStateStatus.initial:
          case PokedexStateStatus.error:
            hideLoader();
            showError('Erro ao buscar os pokemons');
          case PokedexStateStatus.loading:
            showLoader();
          case PokedexStateStatus.success:
            controller.sortListFilter();
            hideLoader();
        
        }
      });
      controller.getPokemon();
    });
  }

  @override
  void dispose() {
    statusReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPokemon(title: 'Pokédex'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Row(
              children: [
                const Flexible(
                  flex: 3,
                  child: SearchWidget(),
                ),
                const SizedBox(
                  width: 16,
                ),
                Observer(
                  builder: (_) {
                    return FilterPokemon(
                      filterByNumber: controller.filter,
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => DialogFilter(
                            onPressed: (value) {
                              controller.changeFilter(value);
                            },
                            value: controller.filter,
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
          Observer(
            builder: (_) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 4, right: 4, bottom: 4, top: 24),
                  decoration: BoxDecoration(
                      color: context.appColor.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 24),
                    child: GridView.builder(
                      itemCount: controller.listPokemon.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisExtent: 104,
                        mainAxisSpacing: 20,
                        maxCrossAxisExtent: 108,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final pokemon = controller.listPokemon[index];
                        return CardPokemon(
                          index: pokemon.index,
                          name: pokemon.name,
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
