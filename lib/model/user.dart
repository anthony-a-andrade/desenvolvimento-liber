import 'package:liber/model/address.dart';
import 'package:liber/model/enums/account_type.dart';
import 'package:liber/model/genre.dart';
import 'package:liber/model/payment_card.dart';

class User {
  String id;
  String url;
  String name;
  String email;
  String password;
  bool verified;
  bool activated;
  String accountType;
  List<Genre> genres;
  List<Address> address;
  List<PaymentCard> cards;

  User(this.id, this.name, this.email, this.password, this.verified, this.activated, this.accountType, this.genres, this.address, this.cards, [this.url = "https://png.pngtree.com/png-vector/20220622/ourlarge/pngtree-dismiss-or-invalid-settings-png-image_5257179.png"]);
  User.build({required this.id, required this.name, required this.email, required this.password, required this.verified, required this.activated, required this.accountType, required this.genres, required this.address, required this.cards, this.url = "https://png.pngtree.com/png-vector/20220622/ourlarge/pngtree-dismiss-or-invalid-settings-png-image_5257179.png"});

  static User fromJson(dynamic json) {
    return User.build(
      id: json["_id"], 
      name: json["name"], 
      email: json["email"], 
      url: "https://www.pngkey.com/png/full/121-1219231_user-default-profile.png",
      password: json["password"], 
      verified: json["verified"], 
      activated: json["activated"], 
      accountType: json["account_type"], 
      genres: Genre.fromJsonList(json["genres"]), 
      address: Address.fromJsonList(json["address"]), 
      cards: PaymentCard.fromJsonList(json["cards"])
    );
  }
}