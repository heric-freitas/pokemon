// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PokemonModels {
  final String name;
  final int index;
  final String image;

  PokemonModels({
    required this.name,
    required this.index,
    required this.image,
  });

  @override
  String toString() => 'PokemonModels(name: $name)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'index': index,
      'image': image,
    };
  }

  factory PokemonModels.fromMap(Map<String, dynamic> map) {
    return PokemonModels(
      name: map['name'] as String,
      index: map['order'] as int,
      image: map['sprites']['front_default'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonModels.fromJson(String source) =>
      PokemonModels.fromMap(json.decode(source) as Map<String, dynamic>);

  PokemonModels copyWith({
    String? name,
    String? url,
    int? index,
    String? image,
  }) {
    return PokemonModels(
      name: name ?? this.name,
      index: index ?? this.index,
      image: image ?? this.image,
    );
  }
}
