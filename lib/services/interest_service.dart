import 'dart:math';

import 'package:flutter/material.dart';

class InterestService {
  static final _random = Random();

  static String _randomWord(int min, int max) {
    String alfa = "ABCDEFGHIJKLMNOPQRSTUVWXYZ", palavra = "";
    var tamanho = min + _random.nextInt(max - min);
    for (var i = 0; i < tamanho; i++) { palavra += alfa[_random.nextInt(26)]; }
    return palavra;
  }

  static Future<Iterable<MapEntry<String, Color>>> expand(int qntExpand) {
    Map<String, Color> items = {};
    for (int i = 0; i < qntExpand; i++) {
      String palavra = [_randomWord(5, 10), _randomWord(5, 10)].join(" ");
      Color cor = Color.fromRGBO(50 + _random.nextInt(206), 50 + _random.nextInt(206), 100 + _random.nextInt(156), 1);
      items[palavra] = cor;
    }
    return Future.value(items.entries);
  }
}