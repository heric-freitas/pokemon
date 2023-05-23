// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DetailsInfoPokemonModel {
  final int height;
  final int order;
  final String sprites;
  final List<String> types;
  final int weight;
  final List<Stats> stats;
  final List<String> abilities;

  DetailsInfoPokemonModel({
    required this.height,
    required this.order,
    required this.sprites,
    required this.types,
    required this.weight,
    required this.stats,
    required this.abilities,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'height': height,
      'order': order,
      'sprites': {
        'front_default' : sprites
      },
      'types': types,
      'weight': weight,
      'stats': stats.map((x) => x.toMap()).toList(),
      'abilities': abilities,
    };
  }

  factory DetailsInfoPokemonModel.fromMap(Map<String, dynamic> map) {
    return DetailsInfoPokemonModel(
      height: map['height'] as int,
      order: map['order'] as int,
      sprites: map['sprites']['front_default'] as String,
      types: List<String>.from((map['types'] as List).map((e) => e['type']['name'])).toList(),
      weight: map['weight'] as int,
      stats: List<Stats>.from(
        (map['stats']).map<Stats>(
          (x) => Stats.fromMap(x as Map<String, dynamic>),
        ),
      ),
      abilities: List<String>.from((map['abilities'] as List).map((e) => e['ability']['name'])).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailsInfoPokemonModel.fromJson(String source) =>
      DetailsInfoPokemonModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class Stats {
  final int baseStat;
  final String name;

  Stats({
    required this.baseStat,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'base_stat': baseStat,
      'name': name,
    };
  }

  factory Stats.fromMap(Map<String, dynamic> map) {
    return Stats(
      baseStat: map['base_stat'] as int,
      name: map['stat']['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Stats.fromJson(String source) =>
      Stats.fromMap(json.decode(source) as Map<String, dynamic>);

  double convertNumberToPercent(double screen, int stat) {
    return (100 * stat) / (100 * screen);
  }
}
