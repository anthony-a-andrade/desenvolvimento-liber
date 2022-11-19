import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:liber/config/config.dart';

class InterestService {
  static final _random = Random();

  static Future getAllGenres() async {
    var uri = Uri.http(baseUrl, "/api/app_genre/");
      
    var response = await http.get(uri, 
      headers: { "Content-Type": "application/json" }
    );

    var result = json.decode(response.body);
    return result;
  }

  static Future<Iterable<MapEntry<String, dynamic>>> expand() async {
    Map<String, dynamic> items = {};
    var words = await getAllGenres();
    var qntExpand = (words as List).length;
    for (int i = 0; i < qntExpand; i++) {
      String palavra = words[i]['name'];
      Color cor = Color.fromRGBO(50 + _random.nextInt(206), 50 + _random.nextInt(206), 100 + _random.nextInt(156), 1);
      
      String id = words[i]['_id'];
      items[id] = { 'palavra': palavra, 'cor': cor };

    }
    return Future.value(items.entries);
  }
}