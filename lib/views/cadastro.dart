import 'package:flutter/material.dart';
import 'package:liber/model/dto/http_response_dto.dart';
import 'package:liber/services/file_service.dart';
import 'package:liber/services/user_service.dart';
import 'package:liber/views/subviews/ativar.dart';
import 'package:liber/widgets/icon_text_field.dart';
import 'package:liber/widgets/info/info_dialog.dart';
import 'package:liber/widgets/info/snackbar.dart';
import 'package:liber/widgets/redirect_label.dart';
import 'package:liber/widgets/rounded_text_button.dart';
import 'package:liber/widgets/top_gradient_panel.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  cadastrar() async {
    String nome = nomeController.text;
    String email = emailController.text;
    String senha = senhaController.text;
    String confirmarSenha = confirmarSenhaController.text;
    
    HttpResponseDTO response = await UserService.register(nome, email, senha, confirmarSenha);
    if (!mounted) return;
    if (response.status == 201) {
      Snackbar.show(context, "Um código de verificação foi enviado para o e-mail fornecido.");
      RegisterFileService.save(response.token!, email, nome);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Ativar()));
    } else {
      InfoDialog.error(context, response.message!);
    }
  }

  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          TopGradientPanel("Cadastro", Icons.person_add, 24, 80),
          Expanded(child: Container()),
          IconTextField("Nome", Icons.account_circle, nomeController, 20),
          IconTextField("E-mail", Icons.email, emailController, 20),
          IconTextField.private("Senha", Icons.security, senhaController, 20),
          IconTextField.private("Confirmação da senha", Icons.security, confirmarSenhaController, 40),
          RoundedTextButton("CADASTRAR", cadastrar, bottom: 15),
          RedirectLabel("Voltar"),
          Expanded(child: Container())
        ]
      )
    );
  }
}