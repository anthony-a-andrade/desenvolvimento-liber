import 'package:liber/config/config.dart';
import 'package:liber/model/address.dart';
import 'package:liber/model/enums/account_type.dart';
import 'package:liber/model/genre.dart';
import 'package:liber/model/payment_card.dart';

class User {
  String id;
  String name;
  String email;
  String password;
  bool verified;
  bool activated;
  String accountType;
  List<Genre> genres;
  Address? address;
  PaymentCard? card;

  User(this.id, this.name, this.email, this.password, this.verified, this.activated, this.accountType, this.genres, this.address, this.card);
  User.build({required this.id, required this.name, required this.email, required this.password, required this.verified, required this.activated, required this.accountType, required this.genres, required this.address, required this.card});

  static User fromJson(dynamic json) {
    return User.build(
      id: json["_id"], 
      name: json["name"], 
      email: json["email"], 
      password: json["password"], 
      verified: json["verified"], 
      activated: json["activated"], 
      accountType: json["account_type"], 
      genres: Genre.fromJsonList(json["genres"]), 
      address: Address.fromJson(json["address"]), 
      card: PaymentCard.fromJson(json["cards"])
    );
  }

  String getImage() {
    var name = email.runes
      .map((e) => String.fromCharCode(e))
      .where((e) => "abcdefghijklmnopqrstuvwxyz0123456789".contains(e.toLowerCase()))
      .join();

    return "http://$baseUrl/users/$name";
  }
}