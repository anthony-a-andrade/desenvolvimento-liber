import 'dart:math';

import 'package:liber/model/ad.dart';
import 'package:liber/services/book_service.dart';
import 'package:liber/services/user_service.dart';

class AdService {
  static int amount = 0;
  static final _random = Random();

  static Ad randomAd() {
    amount++;
    var ad = Ad.build(
      id: amount.toString(), 
      user: UserService.randomUser(), 
      book: BookService.randomBook(), 
      userBuy: UserService.randomUser(), 
      price: (20 + _random.nextDouble() * 30).toString(), 
      typeAd: ["troca", "venda"][_random.nextInt(2)],
      status: ["troca", "venda"][_random.nextInt(2)]
    );
    return ad;
  }

  static List<Ad> randomAds(int qntExpand) {
    List<Ad> items = [];
    for (int i = 0; i < qntExpand; i++) { items.add(randomAd()); }
    return items;
  }

  static Future<List<Ad>> expand(int qntExpand) => Future.value(randomAds(qntExpand));
}