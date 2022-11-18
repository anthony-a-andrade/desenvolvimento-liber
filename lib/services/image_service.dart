import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ImageService {
  static String baseUrl = "192.168.0.107:3000";

  static Future<bool> saveImage(File file, String name) async {
    var uri = Uri.http(baseUrl, "/image/$name");
    var body = json.encode({ 'image': file.readAsBytesSync() });
    var response = await http.post(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );
    return response.statusCode == 200 ? true : false;
  }

  static Future<File> getImage(String name) async {
    var uri = Uri.http(baseUrl, "/images/$name.jpeg");
    var response = await http.get(uri);
    
    var buffer = response.bodyBytes.buffer;
    var byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    return await File('${tempDir.path}/img')
      .writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
}