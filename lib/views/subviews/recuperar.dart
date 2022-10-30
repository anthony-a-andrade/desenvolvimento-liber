// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:liber/model/dto/file_response_dto.dart';
import 'package:liber/model/dto/http_response_dto.dart';
import 'package:liber/services/file_service.dart';
import 'package:liber/services/user_service.dart';
import 'package:liber/views/login.dart';
import 'package:liber/widgets/icon_text_field.dart';
import 'package:liber/widgets/info/info_dialog.dart';
import 'package:liber/widgets/info/snackbar.dart';
import 'package:liber/widgets/rounded_text_button.dart';
import 'package:liber/widgets/top_gradient_panel.dart';

class Recuperar extends StatefulWidget {
  const Recuperar({super.key});

  @override
  State<Recuperar> createState() => _RecuperarState();
}

class _RecuperarState extends State<Recuperar> {
  recuperar() async {
    String senha = senhaController.text;
    String codigo = codigoController.text;

    FileResponseDTO? recover = (await RecoverFileService.get())!;
    String token = recover.token!;
    String email = recover.email!;
    
    if (!mounted) return;
    if (codigo == token) {
      HttpResponseDTO response = await UserService.changePassword(email, senha);
      if (!mounted) return;
      if (response.status == 200) {
        Snackbar.show(context, "Senha redefinida!");
        await RecoverFileService.delete();

        if (!mounted) return;
        if (Navigator.canPop(context)) Navigator.popUntil(context, (route) => route.isFirst);
        else Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
      } else {
        InfoDialog.error(context, response.message!);
      }
    } else {
      Snackbar.show(context, "Código de verificação incorreto.");
    }
  }

  TextEditingController senhaController = TextEditingController();
  TextEditingController codigoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          TopGradientPanel("Recuperar", Icons.lock_person_sharp, 24, 80),
          Expanded(child: Container()),
          IconTextField("Nova senha", Icons.security, senhaController, 20),
          IconTextField("Código de verificação", Icons.lock_outlined, codigoController, 20),
          RoundedTextButton("RECUPERAR", recuperar),
          Expanded(child: Container())
        ]
      )
    );
  }
}