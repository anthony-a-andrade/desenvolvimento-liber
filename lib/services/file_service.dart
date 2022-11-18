import 'dart:convert';
import 'dart:io';
import 'package:liber/model/dto/file_response.dart';
import 'package:path_provider/path_provider.dart';

class RegisterFileService {
  static Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    var path = "${directory.path}/register.json";
    var file = File(path);
    await file.create();
    return file;
  }

  static Future<FileResponse?> get() async {
    try {
      final file = await getFile();
      String body_ = await file.readAsString();
      dynamic body = json.decode(body_);
      return FileResponse.register(body);
    } catch (e) { return null; }
  }

  static Future<File> save(String token, String email, String name) async {
    String data = json.encode({ 'token': token, 'name': name, 'email': email });
    final file = await getFile();
    return file.writeAsString(data);
  }

  static Future<void> delete() async {
    final file = await getFile();
    await file.delete();
  }
}

class RecoverFileService {
  static Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    var path = "${directory.path}/recover.json";
    var file = File(path);
    await file.create();
    return file;
  }

  static Future<FileResponse?> get() async {
    try {
      final file = await getFile();
      String body_ = await file.readAsString();
      dynamic body = json.decode(body_);
      return FileResponse.recover(body);
    } catch (e) { return null; }
  }

  static Future<File> save(String token, String email) async {
    String data = json.encode({ 'token': token, 'email': email });
    final file = await getFile();
    return file.writeAsString(data);
  }

  static Future<void> delete() async {
    final file = await getFile();
    await file.delete();
  }
}

class LoginFileService {
  static Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    var path = "${directory.path}/login.json";
    var file = File(path);
    await file.create();
    return file;
  }

  static Future<FileResponse?> get() async {
    try {
      final file = await getFile();
      String body_ = await file.readAsString();
      dynamic body = json.decode(body_);
      return FileResponse.login(body);
    } catch (e) { return null; }
  }

  static Future<File> save(String email, String password) async {
    String data = json.encode({ 'email': email, 'password': password });
    final file = await getFile();
    return file.writeAsString(data);
  }

  static Future<void> delete() async {
    final file = await getFile();
    await file.delete();
  }
}