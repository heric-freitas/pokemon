// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';


class ListPokemonsModels extends Equatable{
  final String? next;
  final List<String> results;

  const ListPokemonsModels(this.next, this.results);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'next': next,
      'results': results,
    };
  }

  factory ListPokemonsModels.fromMap(Map<String, dynamic> map) {
    return ListPokemonsModels(
      map['next'] != null ? map['next'] as String : null,
      (map['results'] as List).map((e) => e['url'] as String).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListPokemonsModels.fromJson(String source) => ListPokemonsModels.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  List<Object?> get props => [next, results];
}
