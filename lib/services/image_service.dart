import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:liber/config/config.dart';

class ImageService {
  static Future<bool> saveImage(File file, String name) async {
    var uri = Uri.http(baseUrl, "/image/$name");
    var body = json.encode({ 'image': file.readAsBytesSync() });
    var response = await http.post(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );
    return response.statusCode == 200 ? true : false;
  }
  
  static Future<bool> saveUser(File file, String email) async {
    var uri = Uri.http(baseUrl, "/user/$email");
    var body = json.encode({ 'image': file.readAsBytesSync() });
    var response = await http.post(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );
    return response.statusCode == 200 ? true : false;
  }
}