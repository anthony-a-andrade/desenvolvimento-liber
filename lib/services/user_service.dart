import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:liber/config/config.dart';
import 'package:liber/model/ad.dart';
import 'package:liber/model/address.dart';
import 'package:liber/model/dto/user_response.dart';
import 'package:liber/model/enums/account_type.dart';
import 'package:liber/model/genre.dart';
import 'package:liber/model/payment_card.dart';
import 'package:liber/model/solicitation.dart';
import 'package:liber/model/user.dart';
import 'package:liber/services/ad_service.dart';
import 'package:liber/services/solicitation_service.dart';

class UserService {
  static Future<UserResponse> register(String name, String email, String password, String confirmPass) async {
    var uri = Uri.http(baseUrl, "/api/app_user");
    
    var body = json.encode({ 
      'name': name, 
      'email': email, 
      'password': password, 
      'confirmPass': confirmPass
    });
    
    var response = await http.post(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );

    var result = json.decode(response.body);
    return UserResponse.register(result["token"], result["message"], response.statusCode);
  }

  static Future<UserResponse> validate(String email) async { 
    var uri = Uri.http(baseUrl, "/api/app_user/validate");
    var body = json.encode({ 'email': email });
    
    var response = await http.post(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );

    var result = json.decode(response.body);
    return UserResponse.validate(result["message"], response.statusCode);
  }
  
  static Future<UserResponse> login(String email, String password) async { 
    var uri = Uri.http(baseUrl, "/api/app_user/login");
    var body = json.encode({ 'email': email, 'password': password });
    
    var response = await http.post(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );

    var result = json.decode(response.body);
    
    return UserResponse.login(result["name"], result["message"], User.fromJson(result["user"]), response.statusCode);
  }

  static Future<UserResponse> forgotPassword(String email) async { 
    return UserResponse.forgotPassword("token", "message", 201);

    var uri = Uri.http(baseUrl, "/api/app_user/forgotpassword");
    var body = json.encode({ 'email': email });
    
    var response = await http.post(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );

    var result = json.decode(response.body);
    return UserResponse.forgotPassword(result["token"], result["message"], response.statusCode);
  }

  static Future<UserResponse> changePassword(String email, String password) async { 
    var uri = Uri.http(baseUrl, "/api/app_user/changePass");
    var body = json.encode({ 'email': email, 'password': password });
    
    var response = await http.put(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );

    var result = json.decode(response.body);
    return UserResponse.changePassword(result["message"], response.statusCode);
  }

  static int amount = 0;
  static final _random = Random();
  static String randomWord(int min, int max) {
    String alfa = "ABCDEFGHIJKLMNOPQRSTUVWXYZ", palavra = "";
    var tamanho = min;
    if (min != max) tamanho += _random.nextInt(max - min);
    for (var i = 0; i < tamanho; i++) { palavra += alfa[_random.nextInt(26)]; }
    return palavra;
  }
  static List<String> randomWords(int min, int max, int de, int ate) {
    var result = <String>[];
    var tamanho = min;
    if (min != max) tamanho += _random.nextInt(max - min);
    for (int i = 0; i < tamanho; i++) { result.add(randomWord(de, ate)); }
    return result;
  } 
  static User randomUser() {
    return User.build(
      id: DateTime.now().toString(), 
      name: randomWords(2, 3, 8, 10).join(" "), 
      email: "mail@mail.com",
      password: "teste", 
      verified: true, 
      activated: true, 
      accountType: "standard", 
      genres: [Genre("1", "Terror", "terror")], 
      address: Address("", "", "", "", "", "", "", "", true), 
      card: PaymentCard("", "", "", "", "", "", "", true)
    );
  }
}

Future<dynamic> get(String email) async {
  var uri = Uri.http(baseUrl, "/api/app_user/$email");
  var response = await http.get(uri);
  var result = json.decode(response.body);
  switch (response.statusCode) {
    case 200: return result;
    default: return null;
  }
}