import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/src/core/extensions/navigator.dart';
import '../../../core/extensions/size.dart';
import '../../../core/helper/debouncer.dart';
import '../../../core/mixins/loader.dart';
import '../../../core/mixins/messages.dart';

import '../../../core/components/app_bar_pokemon.dart';
import '../../../core/components/card_pokemon.dart';
import '../../../core/components/dialog_filter.dart';
import '../../../core/components/filter_pokemon.dart';
import '../../../core/components/search_widget.dart';
import '../../../core/styles/app_color.dart';
import '../presenter/controllers/bloc/pokedex_bloc.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> with Loader, Messages {
  late final PokedexBloc controller;
  final debouncer = Debouncer(500);

  @override
  void initState() {
    super.initState();
    controller = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.add(GetPokemonsEvent());
    });
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
                    Flexible(
                      flex: 3,
                      child: SearchWidget(
                        searchChange: (value) {
                          debouncer.call(() {
                            if (value.isEmpty) {
                              controller.add(GetPokemonsEvent());
                            } else {
                              controller.add(SearchEvent(value));
                            }
                          });
                        },
                      ),
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
                    switch (state.status) {
                      case PokedexStatus.loading:
                        showLoader();
                      case PokedexStatus.successSearch:
                      case PokedexStatus.loadingSearch:
                      case PokedexStatus.failure:
                        hideLoader();
                      case PokedexStatus.initial:
                      case PokedexStatus.filted:
                      case PokedexStatus.loadingMorePokemon:
                        hideLoader();
                      case PokedexStatus.success:
                        controller
                            .add(FilterListEvent(controller.state.filter));
                    }
                  },
                  builder: (context, state) => switch (state.status) {
                    PokedexStatus.success =>
                      SizedBox(width: context.screenWidth),
                    PokedexStatus.failure => _FailurePage(message: 'DEU RUIM'),
                    PokedexStatus.loading =>
                      SizedBox(width: context.screenWidth),
                    PokedexStatus.initial =>
                      SizedBox(width: context.screenWidth),
                    PokedexStatus.successSearch =>
                      _FiltedPage(controller: controller),
                    PokedexStatus.loadingSearch ||
                    PokedexStatus.filted ||
                    PokedexStatus.loadingMorePokemon =>
                      _SuccessPage(controller: controller),
                  },
                )),
          )
        ],
      ),
    );
  }
}

class _FiltedPage extends StatefulWidget {
  final PokedexBloc controller;
  const _FiltedPage({super.key, required this.controller});

  @override
  State<_FiltedPage> createState() => __FiltedPageState();
}

class __FiltedPageState extends State<_FiltedPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.controller.state.list.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: 104,
        mainAxisSpacing: 20,
        maxCrossAxisExtent: 108,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final pokemon = widget.controller.state.list[index];

        return CardPokemon(
          onPressed: () => context.pushNamedDetails(pokemon.name),
          index: pokemon.index,
          name: pokemon.name,
          image: pokemon.image,
        );
      },
    );
  }
}

class _SuccessPage extends StatefulWidget {
  final PokedexBloc controller;
  const _SuccessPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<_SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<_SuccessPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    final state = widget.controller.state;
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        !(state == PokedexStatus.loadingSearch) &&
        !(state == PokedexStatus.loadingMorePokemon)) {
      widget.controller.add(GetMorePokemonsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      itemCount: widget.controller.state == PokedexStatus.successSearch
          ? widget.controller.state.list.length - 1
          : widget.controller.state.list.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: 104,
        mainAxisSpacing: 20,
        maxCrossAxisExtent: 108,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final pokemon = widget.controller.state.list[index];
        if (index >= widget.controller.state.list.length) {
          return const FittedBox(child: CircularProgressIndicator());
        }

        return CardPokemon(
          onPressed: () => context.pushNamedDetails(pokemon.name),
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
