import 'package:liber/model/ad.dart';
import 'package:liber/model/solicitation.dart';
import 'package:liber/model/user.dart';

class UserResponse {
  String? token;
  String? message;
  String? name;
  User? user;
  List<Ad>? publishedAds;
  List<Solicitation>? trades;
  List<Solicitation>? sells;
  int status;

  UserResponse.register(this.token, this.message, this.status);
  UserResponse.validate(this.message, this.status);
  UserResponse.login(this.name, this.message, this.user, this.status);
  UserResponse.forgotPassword(this.token, this.message, this.status);
  UserResponse.changePassword(this.message, this.status);
  UserResponse.error(this.message, this.status);
  UserResponse.get(this.user, this.publishedAds, this.trades, this.sells, this.status);
}