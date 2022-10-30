import 'package:flutter/material.dart';
import 'package:liber/model/dto/http_response_dto.dart';
import 'package:liber/services/file_service.dart';
import 'package:liber/services/user_service.dart';
import 'package:liber/views/subviews/recuperar.dart';
import 'package:liber/widgets/icon_text_field.dart';
import 'package:liber/widgets/info/info_dialog.dart';
import 'package:liber/widgets/info/snackbar.dart';
import 'package:liber/widgets/redirect_label.dart';
import 'package:liber/widgets/rounded_text_button.dart';
import 'package:liber/widgets/top_gradient_panel.dart';

class Recuperacao extends StatefulWidget {
  const Recuperacao({super.key});

  @override
  State<Recuperacao> createState() => _RecuperacaoState();
}

class _RecuperacaoState extends State<Recuperacao> {
  recuperar() async {
    String email = emailController.text;

    HttpResponseDTO response = await UserService.forgotPassword(email);
    if (!mounted) return;
    if (response.status == 201) {
      Snackbar.show(context, "Um código de verificação foi enviado para o e-mail fornecido.");
      RecoverFileService.save(response.token!, email);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Recuperar()));
    } else {
      InfoDialog.error(context, response.message!);
    }
  }

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          TopGradientPanel("Recuperação", Icons.lock_person_sharp, 24, 80),
          Expanded(child: Container()),
          IconTextField("E-mail", Icons.email, emailController, 20),
          RoundedTextButton("RECUPERAR", recuperar, bottom: 5),
          RedirectLabel("Voltar"),
          Expanded(child: Container())
        ]
      )
    );
  }
}