import 'package:liber/model/ad.dart';
import 'package:liber/model/user.dart';

class Solicitation {
  String id;
  User user;
  Ad ad;
  User userSolicitation;
  Ad adSolicitation;
  String status;

  Solicitation(this.id, this.user, this.ad, this.userSolicitation, this.adSolicitation, this.status);
  Solicitation.build({required this.id, required this.user, required this.ad, required this.userSolicitation, required this.adSolicitation, required this.status});

  static Solicitation fromJson(dynamic json) {
    return Solicitation.build(
      id: json["_id"],
      user: User.fromJson(json["id_user"]),
      ad: Ad.fromJson(json["id_ad"]),
      userSolicitation: User.fromJson(json["id_user_solicitation"]),
      adSolicitation: Ad.fromJson(json["id_ad_solicitation"]),
      status: json["status"]
    );
  }
}