import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:liber/config/config.dart';
import 'package:liber/model/address.dart';

class AddressService {
  static Future<List<Address>> getAll(String userEmail) async {
    var uri = Uri.http(baseUrl, "/api/app_user/address/$userEmail");
    var response = await http.get(uri);
    var result = json.decode(response.body);
    return Address.fromJsonList(result);
  }

  static Future<bool> save(String email, Address address) async {
    var uri = Uri.http(baseUrl, "/api/app_user/address");
    var body = json.encode({ 'email': email, 'address': address.toJson() });
    
    var response = await http.post(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );
    print(response.body);
    print(response.statusCode);
    return response.statusCode == 200;
  }

  static Future<bool> delete(String id) async {
    var uri = Uri.http(baseUrl, "/api/app_user/address");
    var body = json.encode({ '_id': id });
    
    var response = await http.delete(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );

    return response.statusCode == 200;
  }
}