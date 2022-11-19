import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:liber/config/config.dart';
import 'package:liber/model/address.dart';

Future<dynamic> getAll(String userEmail) async {
  var uri = Uri.http(baseUrl, "/api/app_user/address/$userEmail");
  var response = await http.get(uri);
  var result = json.decode(response.body);
  return result;
}

Future<bool> save(String email, Address address, bool update) async {
  var uri = Uri.http(baseUrl, "/api/app_user/address");
  var body = json.encode(address.toJson(email));
  
  http.Response response;
  if (update) {
    response = await http.put(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );
  } else {
    response = await http.post(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );
  }

  return response.statusCode == 200;
}

Future<bool> delete(String id) async {
  var uri = Uri.http(baseUrl, "/api/app_user/address");
  var body = json.encode({ '_id': id });
  
  var response = await http.delete(uri, 
    body: body,
    headers: { "Content-Type": "application/json" }
  );

  return response.statusCode == 200;
}