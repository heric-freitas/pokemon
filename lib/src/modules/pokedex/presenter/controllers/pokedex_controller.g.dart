// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokedexController on PokedexControllerBase, Store {
  late final _$_filterAtom =
      Atom(name: 'PokedexControllerBase._filter', context: context);

  Filter? get filter {
    _$_filterAtom.reportRead();
    return super._filter;
  }

  @override
  Filter? get _filter => filter;

  @override
  set _filter(Filter? value) {
    _$_filterAtom.reportWrite(value, super._filter, () {
      super._filter = value;
    });
  }

  late final _$_listPokemonAtom =
      Atom(name: 'PokedexControllerBase._listPokemon', context: context);

  List<PokemonModels> get listPokemon {
    _$_listPokemonAtom.reportRead();
    return super._listPokemon;
  }

  @override
  List<PokemonModels> get _listPokemon => listPokemon;

  @override
  set _listPokemon(List<PokemonModels> value) {
    _$_listPokemonAtom.reportWrite(value, super._listPokemon, () {
      super._listPokemon = value;
    });
  }

  late final _$_pokedexStateStatusAtom =
      Atom(name: 'PokedexControllerBase._pokedexStateStatus', context: context);

  PokedexStateStatus get pokedexStateStatus {
    _$_pokedexStateStatusAtom.reportRead();
    return super._pokedexStateStatus;
  }

  @override
  PokedexStateStatus get _pokedexStateStatus => pokedexStateStatus;

  @override
  set _pokedexStateStatus(PokedexStateStatus value) {
    _$_pokedexStateStatusAtom.reportWrite(value, super._pokedexStateStatus, () {
      super._pokedexStateStatus = value;
    });
  }

  late final _$getPokemonAsyncAction =
      AsyncAction('PokedexControllerBase.getPokemon', context: context);

  @override
  Future<void> getPokemon() {
    return _$getPokemonAsyncAction.run(() => super.getPokemon());
  }

  late final _$PokedexControllerBaseActionController =
      ActionController(name: 'PokedexControllerBase', context: context);

  @override
  void changeFilter(Filter? filter) {
    final _$actionInfo = _$PokedexControllerBaseActionController.startAction(
        name: 'PokedexControllerBase.changeFilter');
    try {
      return super.changeFilter(filter);
    } finally {
      _$PokedexControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sortListFilter() {
    final _$actionInfo = _$PokedexControllerBaseActionController.startAction(
        name: 'PokedexControllerBase.sortListFilter');
    try {
      return super.sortListFilter();
    } finally {
      _$PokedexControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
