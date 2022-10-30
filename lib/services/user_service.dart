import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:liber/model/dto/http_response_dto.dart';

class UserService {
  static String baseUrl = "192.168.0.101:3000";

  static Future<HttpResponseDTO> register(String name, String email, String password, String confirmPass) async { 
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
    return HttpResponseDTO.register(result["token"], result["message"], response.statusCode);
  }

  static Future<HttpResponseDTO> validate(String email) async { 
    var uri = Uri.http(baseUrl, "/api/app_user/validate");
    var body = json.encode({ 'email': email });
    
    var response = await http.post(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );

    var result = json.decode(response.body);
    return HttpResponseDTO.validate(result["message"], response.statusCode);
  }
  
  static Future<HttpResponseDTO> login(String email, String password) async { 
    var uri = Uri.http(baseUrl, "/api/app_user/login");
    var body = json.encode({ 'email': email, 'password': password });
    
    var response = await http.post(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );

    var result = json.decode(response.body);
    return HttpResponseDTO.login(result["name"], result["message"], response.statusCode);
  }

  static Future<HttpResponseDTO> forgotPassword(String email) async { 
    var uri = Uri.http(baseUrl, "/api/app_user/forgotpassword");
    var body = json.encode({ 'email': email });
    
    var response = await http.post(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );

    var result = json.decode(response.body);
    return HttpResponseDTO.forgotPassword(result["token"], result["message"], response.statusCode);
  }

  static Future<HttpResponseDTO> changePassword(String email, String password) async { 
    var uri = Uri.http(baseUrl, "/api/app_user/changePass");
    var body = json.encode({ 'email': email, 'password': password });
    
    var response = await http.put(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );

    var result = json.decode(response.body);
    return HttpResponseDTO.changePassword(result["message"], response.statusCode);
  }
}