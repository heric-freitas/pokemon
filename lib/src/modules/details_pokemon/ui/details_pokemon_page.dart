import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokemon/src/core/extensions/size.dart';
import 'package:pokemon/src/core/extensions/stats.dart';
import 'package:pokemon/src/core/mixins/loader.dart';
import 'package:pokemon/src/core/styles/app_color.dart';
import 'package:pokemon/src/core/styles/app_text_styles.dart';
import 'package:pokemon/src/modules/details_pokemon/presenter/controllers/bloc/details_pokemon_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/components/app_bar_pokemon.dart';
import '../../../core/components/pokemon_type_widget.dart';
import '../model/details_info_pokemon_model.dart';
import 'widget/tile_info.dart';

class DetailsPokemonPage extends StatefulWidget {
  final String name;
  const DetailsPokemonPage({Key? key, required this.name}) : super(key: key);

  @override
  State<DetailsPokemonPage> createState() => _DetailsPokemonPageState();
}

class _DetailsPokemonPageState extends State<DetailsPokemonPage> with Loader {
  late final DetailsPokemonBloc controller;

  @override
  void initState() {
    super.initState();
    controller = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.add(GetDetailsPokemonEvent(widget.name));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsPokemonBloc, DetailsPokemonState>(
        listener: (context, state) {
          switch (state) {
            case DetailsPokemonInitial():
              return;
            case DetailsPokemonLoading():
              showLoader();
            case DetailsPokemonLoaded():
              hideLoader();
            case DetailsPokemonFailure():
              hideLoader();
          }
        },
        builder: (context, state) => switch (state) {
              DetailsPokemonInitial() => const SizedBox.shrink(),
              DetailsPokemonLoading() => const SizedBox.shrink(),
              DetailsPokemonLoaded(:final detailsInfoPokemonModel) =>
                _SuccessPage(
                  detailsInfoPokemonModel: detailsInfoPokemonModel,
                  name: widget.name,
                ),
              DetailsPokemonFailure() => const SizedBox.shrink(),
            });
  }
}

class _SuccessPage extends StatefulWidget {
  final String name;
  final DetailsInfoPokemonModel detailsInfoPokemonModel;
  const _SuccessPage(
      {super.key, required this.detailsInfoPokemonModel, required this.name});

  @override
  State<_SuccessPage> createState() => __SuccessPageState();
}

class __SuccessPageState extends State<_SuccessPage> {
  late String typePrincipal;
  late int order;
  late Color colorPrincipal;

  @override
  void initState() {
    super.initState();
    typePrincipal = widget.detailsInfoPokemonModel.types[0];
    colorPrincipal = context.appColorType.mapColors[typePrincipal]!;
    order = widget.detailsInfoPokemonModel.order;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrincipal,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AppBarPokemon(title: widget.name, index: order),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                margin: const EdgeInsets.only(
                    left: 4, right: 4, bottom: 4, top: 24),
                decoration: BoxDecoration(
                    color: context.appColor.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 56,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.detailsInfoPokemonModel.types
                          .map((e) => PokemonTypeWidget(
                                type: e,
                              ))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'About',
                      style: context.appTextStyles.subtitle1
                          .copyWith(color: colorPrincipal),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TileInfo(
                          info: 'Weight',
                          value: '${widget.detailsInfoPokemonModel.weight} kg',
                          image: 'assets/icons/weight.png',
                        ),
                        VerticalDivider(
                          color: context.appColor.light,
                          width: 1,
                        ),
                        TileInfo(
                          info: 'Height',
                          value: '${widget.detailsInfoPokemonModel.height}',
                          image: 'assets/icons/ruler.png',
                        ),
                        VerticalDivider(
                          color: context.appColor.light,
                          width: 1,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              children: widget.detailsInfoPokemonModel.abilities
                                  .map((e) => Text(
                                        e,
                                        style: context.appTextStyles.body3,
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Moves',
                              style: context.appTextStyles.caption
                                  .copyWith(color: context.appColor.medium),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.',
                      style: context.appTextStyles.body3,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Base Stats',
                      style: context.appTextStyles.subtitle1
                          .copyWith(color: colorPrincipal),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: widget.detailsInfoPokemonModel.stats
                          .map((e) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.stats.mapStats[e.name]!,
                                    style: context.appTextStyles.subtitle3
                                        .copyWith(color: colorPrincipal),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  const VerticalDivider(),
                                  LinearPercentIndicator(
                                    backgroundColor:
                                        colorPrincipal.withOpacity(.2),
                                    progressColor: colorPrincipal,
                                    lineHeight: 4,
                                    percent: e.convertNumberToPercent(
                                        context.screenWidth, e.baseStat),
                                    width: context.percentWidth(.7),
                                    leading: Text(
                                      e.baseStat.toString().padLeft(3, '0'),
                                      style: context.appTextStyles.body3,
                                    ),
                                  )
                                ],
                              ))
                          .toList(),
                    ),
                  ],
                )),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.only(top: 8, right: 10),
              height: 208,
              width: 205,
              child: Image.asset(
                'assets/icons/pokeball.png',
                color: context.appColor.white.withAlpha(35),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.only(top: 8, right: 10),
              height: 200,
              width: 200,
              child: Image.network(
                widget.detailsInfoPokemonModel.sprites,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
