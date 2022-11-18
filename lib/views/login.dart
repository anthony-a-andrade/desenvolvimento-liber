import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/model/dto/user_response.dart';
import 'package:liber/services/file_service.dart';
import 'package:liber/services/user_service.dart';
import 'package:liber/views/forgot_password.dart';
import 'package:liber/views/home.dart';
import 'package:liber/views/register.dart';
import 'package:liber/views/user_interests.dart';
import 'package:liber/widgets/control/redirect_label.dart';
import 'package:liber/widgets/info/info_dialog.dart';
import 'package:liber/widgets/info/snackbar.dart';
import 'package:liber/widgets/info/top_gradient_panel.dart';
import 'package:liber/widgets/input/icon_text_field.dart';
import 'package:liber/widgets/input/rounded_text_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void login() async {
    String email = emailController.text;
    String senha = passwordController.text;

    UserResponse response = await UserService.login(email, senha);
    if (!mounted) return;
    if (response.status == 200) {
      var user = response.user!;
      Snackbar.show(context, "Bem vindo de volta, ${response.name}!");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user, [], [], [])));
      await LoginFileService.save(email, senha);
      // if (user.genres.isEmpty) {
      //   Snackbar.show(context, "Bem vindo ao Liber, ${response.name}!");
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => const UserInterests()));
      // } else {
      //   Snackbar.show(context, "Bem vindo de volta, ${response.name}!");
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user, [], [], [])));
      //   await LoginFileService.save(email, senha);
      // }
    } else {
      InfoDialog.error(context, response.message!);
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const TopGradientPanel("Bem Vindo", Icons.person, 24, 80),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Style.scaffoldPadding),
            child: Column(
              children: [
                IconTextField("E-mail", Icons.email, emailController, 20),
                IconTextField("Senha", Icons.security, passwordController, 40, private: true),
                RoundedTextButton("ENTRAR", login, bottom: 15)
              ]
            )
          ),
          const RedirectLabel("Cadastrar-se", to: Register(), bottom: 5),
          const RedirectLabel("Esqueceu sua senha?", to: ForgotPassword()),
          Expanded(child: Container())
        ]
      )
    );
  }
}