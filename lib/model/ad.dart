import 'package:liber/model/book.dart';
import 'package:liber/model/user.dart';
import 'package:liber/services/ad_service.dart';

class Ad {
  String id;
  String typeAd;
  User user;
  Book book;
  User? userBuy;
  String? price;
  String status;

  Ad(this.id, this.user, this.book, this.userBuy, this.price, this.typeAd, this.status);
  Ad.build({required this.id, required this.user, required this.book, required this.userBuy, required this.price, required this.typeAd, required this.status});

  static Ad fromJson(dynamic json) {
    try {
      
    User? userBuy;
    if (json["id_user_buy"] != null) userBuy = User.fromJson(json["id_user_buy"]);
    return Ad.build(
      id: json["_id"], 
      user: User.fromJson(json["user"]), 
      book: Book.fromJson(json["book"]), 
      userBuy: userBuy, 
      price: json["price"], 
      typeAd: json["type_ad"],
      status: json["status"]
    );
    } catch (e) {
      print("error at ad");
      print(json);
      print(e);
      return AdService.randomAd();
    }
  }

  static List<Ad> fromJsonList(dynamic json) {
    return (json as List).map((ad) => Ad.fromJson(ad)).toList();
  }

  String? getPrice() {
    try {
      return double.parse(price!).toStringAsFixed(2);
    } catch (e) {
      return null;
    }
  }
}