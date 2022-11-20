import 'package:flutter/material.dart';
import 'package:liber/views/home.dart';
import 'package:liber/views/login.dart';
import 'package:liber/views/user_interests.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // UserResponse userData = await UserService.get("");
  // runApp(MaterialApp(debugShowCheckedModeBanner: false, home: await entrar("")));
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: UserInterests("gamestthony@gmail.com")));
  
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