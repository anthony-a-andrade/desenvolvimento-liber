import 'package:flutter/material.dart';
import 'package:liber/model/dto/http_response_dto.dart';
import 'package:liber/services/file_service.dart';
import 'package:liber/services/user_service.dart';
import 'package:liber/views/cadastro.dart';
import 'package:liber/views/home.dart';
import 'package:liber/views/recuperacao.dart';
import 'package:liber/widgets/icon_text_field.dart';
import 'package:liber/widgets/info/info_dialog.dart';
import 'package:liber/widgets/info/snackbar.dart';
import 'package:liber/widgets/redirect_label.dart';
import 'package:liber/widgets/rounded_text_button.dart';
import 'package:liber/widgets/top_gradient_panel.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  login() async {
    String email = emailController.text;
    String senha = senhaController.text;

    HttpResponseDTO response = await UserService.login(email, senha);
    if (!mounted) return;
    if (response.status == 200) {
      Snackbar.show(context, "Bem vindo, ${response.name}!");
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
      await LoginFileService.save(email, senha);
    } else {
      InfoDialog.show(context, response.message!, Icons.error_outline, const Color.fromARGB(255, 255, 17, 0), 50);
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          TopGradientPanel("Bem Vindo", Icons.person, 24, 80),
          Expanded(child: Container()),
          IconTextField("E-mail", Icons.email, emailController, 20),
          IconTextField.private("Senha", Icons.security, senhaController, 40),
          RoundedTextButton("ENTRAR", login, bottom: 15),
          RedirectLabel("Cadastrar-se", to: const Cadastro(), bottom: 5),
          RedirectLabel("Esqueceu sua senha?", to: const Recuperacao()),
          Expanded(child: Container())
        ]
      )
    );
  }
}