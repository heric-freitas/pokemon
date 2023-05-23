// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PokemonModels extends Equatable {
  final String name;
  final int index;
  final String image;

  const PokemonModels({
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
      index: map['index'] as int,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonModels.fromJson(String source) =>
      PokemonModels.fromMap(json.decode(source) as Map<String, dynamic>);

  PokemonModels copyWith({
    String? name,
    int? index,
    String? image,
  }) {
    return PokemonModels(
      name: name ?? this.name,
      index: index ?? this.index,
      image: image ?? this.image,
    );
  }
  
  @override
  List<Object> get props => [name, index, image];

  @override
  bool get stringify => true;
}
