import 'package:flutter/material.dart';
import 'package:liber/services/file_service.dart';
import 'package:liber/views/login.dart';
import 'package:liber/views/subviews/ativar.dart';
import 'package:liber/views/subviews/recuperar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var register = await RegisterFileService.get();
  var recover = await RecoverFileService.get();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: register != null ? const Ativar() : recover != null ? const Recuperar() : const Login()
  ));
}