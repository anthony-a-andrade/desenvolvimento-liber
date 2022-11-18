import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
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
  static String baseUrl = "192.168.0.107:3000";

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

  static Future<UserResponse> get(String email) async {
    // return UserResponse.get(
    //   User.build(
    //     id: "1", 
    //     name: "Usuário Teste", 
    //     email: "teste@gmail.com", 
    //     password: "senhateste", 
    //     verified: true, 
    //     activated: true, 
    //     accountType: AccountType.premium, 
    //     genres: [
    //       Genre.build(id: "1", name: "Terror", tag: "terror"),
    //       Genre.build(id: "2", name: "Comédia", tag: "comedia"),
    //       Genre.build(id: "3", name: "Fotografia", tag: "fotografia"),
    //       Genre.build(id: "4", name: "Arquitetura", tag: "arquitetura")
    //     ], 
    //     address: [
    //       Address.build(
    //         id: "1", 
    //         name: "Casa", 
    //         cep: "00000-000", 
    //         road: "Rua Teste", 
    //         city: "Cidade Teste", 
    //         state: "SP", 
    //         number: "147", 
    //         complement: "Casa 1", 
    //         main: true
    //       )
    //     ], 
    //     cards: [
    //       PaymentCard.build(
    //         id: "1", 
    //         number: "0000111122223333", 
    //         expirationDate: "00/0000", 
    //         cvv: "123", 
    //         cardholder: "Usuário Teste", 
    //         cpf: "000.000.000-00", 
    //         nameCard: "Cartão Visa", 
    //         main: true
    //       )
    //     ]
    //   ),
    //   <Ad>[ AdService.randomAd(), AdService.randomAd(), AdService.randomAd() ], 
    //   <Solicitation>[ SolicitationService.randomSolicitation(), SolicitationService.randomSolicitation() ], 
    //   <Solicitation>[ SolicitationService.randomSolicitation() ], 
    //   200
    // );
    var uri = Uri.http(baseUrl, "/api/app_user/$email");
    var response = await http.get(uri);
    var result = json.decode(response.body);

    print(result);
    switch (response.statusCode) {
      case 200: return UserResponse.get(User.fromJson(result), [], [], [], 200);
      default: return UserResponse.error(result["message"], response.statusCode);
    }
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
      address: [ Address("", "", "", "", "", "", "", "", true) ], 
      cards: [ PaymentCard("", "", "", "", "", "", "", true) ]
    );
  }
}