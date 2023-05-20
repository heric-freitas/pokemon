import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/extensions/size.dart';
import '../../../core/mixins/loader.dart';
import '../../../core/mixins/messages.dart';

import '../../../core/components/app_bar_pokemon.dart';
import '../../../core/components/card_pokemon.dart';
import '../../../core/components/dialog_filter.dart';
import '../../../core/components/filter_pokemon.dart';
import '../../../core/components/search_widget.dart';
import '../../../core/styles/app_color.dart';
import '../models/pokemon_models.dart';
import '../presenter/controllers/bloc/pokedex_bloc.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> with Loader, Messages {
  late final PokedexBloc controller;

  @override
  void initState() {
    super.initState();
    controller = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.add(GetPokemonsEvent());
    });
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPokemon(title: 'Pokédex'),
      body: Column(
        children: [
          BlocBuilder<PokedexBloc, PokedexState>(
            builder: (context, state) {
              return Padding(
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
                    FilterPokemon(
                      filterByNumber: controller.state.filter,
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => DialogFilter(
                            onPressed: (value) {
                              controller.add(FilterListEvent(value));
                            },
                            value: controller.state.filter,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                margin: const EdgeInsets.only(
                    left: 4, right: 4, bottom: 4, top: 24),
                decoration: BoxDecoration(
                    color: context.appColor.white,
                    borderRadius: BorderRadius.circular(8)),
                child: BlocConsumer<PokedexBloc, PokedexState>(
                  listener: (context, state) {
                    switch (state) {
                      case PokedexFilted():
                        hideLoader();
                      case PokedexInitial():
                      case PokedexLoading():
                        showLoader();
                      case PokedexLoad():
                        controller
                            .add(FilterListEvent(controller.state.filter));

                      case PokedexFailure():
                        hideLoader();
                    }
                  },
                  builder: (context, state) => switch (state) {
                    PokedexInitial() => SizedBox(width: context.screenWidth),
                    PokedexLoading() => SizedBox(width: context.screenWidth),
                    PokedexFilted(:final list) =>
                      _SuccessPage(list: list, controller: controller),
                    PokedexLoad() => SizedBox(width: context.screenWidth),
                    PokedexFailure(:final message) =>
                      _FailurePage(message: message),
                  },
                )),
          )
        ],
      ),
    );
  }
}

class _SuccessPage extends StatefulWidget {
  final List<PokemonModels> list;
  final PokedexBloc controller;
  _SuccessPage({Key? key, required this.list, required this.controller})
      : super(key: key);

  @override
  State<_SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<_SuccessPage> {
  late final _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      widget.controller.add(GetMorePokemonsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      itemCount: widget.list.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: 104,
        mainAxisSpacing: 20,
        maxCrossAxisExtent: 108,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final pokemon = widget.list[index];

        return CardPokemon(
          index: pokemon.index,
          name: pokemon.name,
          image: pokemon.image,
        );
      },
    );
  }
}

class _FailurePage extends StatelessWidget {
  final String message;
  const _FailurePage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(message);
  }
}
