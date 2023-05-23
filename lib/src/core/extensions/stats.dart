import 'package:flutter/material.dart';

class Stats {
  static Stats? _instance;

  Stats._();
  static Stats get instance {
    _instance ??= Stats._();
    return _instance!;
  }

  Map<String, String> mapStats = {
    'hp' : 'HP',
    'attack' : 'ATK',
    'defense' : 'DEF',
    'special-attack' : 'SATK',
    'special-defense' : 'SDEF',
    'speed' : 'SPD',
  };
}

extension StatsExtension on BuildContext {
  Stats get stats => Stats.instance;
}
