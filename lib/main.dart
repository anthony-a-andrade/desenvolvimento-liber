import 'package:flutter/material.dart';
import 'package:liber/services/file_service.dart';
import 'package:liber/views/home.dart';
import 'package:liber/views/login.dart';
import 'package:liber/views/subviews/ativar.dart';
import 'package:liber/views/subviews/recuperar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
  
  /*
  var login = await LoginFileService.get();
  var register = await RegisterFileService.get();
  var recover = await RecoverFileService.get();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: 
      login != null ? const Home() : 
      register != null ? const Ativar() : 
      recover != null ? const Recuperar() : 
      const Login()
  ));
  */
}