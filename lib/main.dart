import 'package:flutter/material.dart';
import 'package:liber/model/dto/user_response.dart';
import 'package:liber/services/user_service.dart';
import 'package:liber/views/home.dart';
import 'package:liber/views/login.dart';
import 'package:liber/views/register.dart';

Future<Widget> entrar(String email) async {
  var data = await UserService.get(email);
  return Home(data.user!, data.publishedAds!, data.trades!, data.sells!);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // UserResponse userData = await UserService.get("");
  // runApp(MaterialApp(debugShowCheckedModeBanner: false, home: await entrar("")));
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Login()));
  
  /*
  flutter run -d chrome --web-renderer html
  
  var login = await LoginFileService.get();
  var register = await RegisterFileService.get();
  var recover = await RecoverFileService.get();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: 
      login != null ? await entrar(login.email!) : 
      register != null ? const Register(showOverlay: true) : 
      recover != null ? const ForgotPassword(showOverlay: true) : 
      const Login()
  ));
  */
}