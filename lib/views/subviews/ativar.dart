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

class Ativar extends StatefulWidget {
  const Ativar({super.key});

  @override
  State<Ativar> createState() => _AtivarState();
}

class _AtivarState extends State<Ativar> {
  validar() async {
    String codigo = codigoController.text;

    FileResponseDTO register = (await RegisterFileService.get())!;
    String token = register.token!;
    String nome = register.name!;
    String email = register.email!;
    
    if (!mounted) return;
    if (codigo == token) {
      HttpResponseDTO response = await UserService.validate(email);
      if (!mounted) return;
      if (response.status == 200) {
        Snackbar.show(context, "Seja bem vindo ao Liber, $nome!");
        await RegisterFileService.delete();

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

  TextEditingController codigoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          TopGradientPanel("Ativação", Icons.mark_email_read_outlined, 24, 80),
          Expanded(child: Container()),
          IconTextField.private("Código de verificação", Icons.security, codigoController, 20),
          RoundedTextButton("VALIDAR", validar),
          Expanded(child: Container())
        ]
      )
    );
  }
}