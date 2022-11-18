import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/model/dto/file_response.dart';
import 'package:liber/model/dto/user_response.dart';
import 'package:liber/services/file_service.dart';
import 'package:liber/services/image_service.dart';
import 'package:liber/services/user_service.dart';
import 'package:liber/views/login.dart';
import 'package:liber/widgets/control/overlayed_widget.dart';
import 'package:liber/widgets/control/redirect_label.dart';
import 'package:liber/widgets/info/info_dialog.dart';
import 'package:liber/widgets/info/snackbar.dart';
import 'package:liber/widgets/info/top_gradient_panel.dart';
import 'package:liber/widgets/input/icon_date_field.dart';
import 'package:liber/widgets/input/icon_text_field.dart';
import 'package:liber/widgets/input/image_picker.dart';
import 'package:liber/widgets/input/rounded_text_button.dart';

class Register extends StatefulWidget {
  final bool showOverlay;

  const Register({this.showOverlay = false, super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  void register() async {
    String name = nameController.text;
    String email = emailController.text;
    String senha = passwordController.text;
    String confirmarSenha = confirmPasswordController.text;
    // String data = dateController.text;

    File? file = ImagePicker.selectedFile;
    if (file != null) {
      var email_ = email.characters.where((c) => "abcdefghijklmnopqrstuvwxyz0123456789".contains(c.toLowerCase())).join(" ");
      await ImageService.saveImage(file, email_);
    }
    
    UserResponse response = await UserService.register(name, email, senha, confirmarSenha);
    if (!mounted) return;
    if (response.status == 201) {
      Snackbar.show(context, "Um código de verificação foi enviado para o e-mail fornecido.");
      OverlayedWidget.show();
      await RegisterFileService.save(response.token!, email, name);
    } else {
      InfoDialog.error(context, response.message!);
    }
  }

  void validate() async {
    String code = codeController.text;

    FileResponse register = (await RegisterFileService.get())!;
    String token = register.token!;
    String name = register.name!;
    String email = register.email!;
    
    if (!mounted) return;
    if (code == token) {
      UserResponse response = await UserService.validate(email);
      if (!mounted) return;
      if (response.status == 200) {
        Snackbar.show(context, "Seja bem vindo ao Liber, $name!");

        if (Navigator.canPop(context)) {
          Navigator.popUntil(context, (route) => route.isFirst);
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
        }
        
        await RegisterFileService.delete();
      } else {
        InfoDialog.error(context, response.message!);
      }
    } else {
      Snackbar.show(context, "Código de verificação incorreto.");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return OverlayedWidget(
      allowHide: false,
      showOverlay: widget.showOverlay,
      background: SingleChildScrollView(
        child: Column(
          children: [
            const TopGradientPanel("Cadastro", Icons.person_add, 24, 80),
            const SizedBox(height: 30),
            const ImagePicker(),
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Style.scaffoldPadding),
              child: Column(
                children: [
                  IconTextField("Nome", Icons.account_circle, nameController, 20),
                  IconTextField("E-mail", Icons.email, emailController, 20),
                  IconTextField("Senha", Icons.security, passwordController, 20, private: true),
                  IconTextField("Confirmação da senha", Icons.security, confirmPasswordController, 20, private: true),
                  IconDateField("Data de nascimento", dateController, 40),
                  RoundedTextButton("CADASTRAR", register, bottom: 15),
                ]
              ),
            ),
            const RedirectLabel("Voltar"),
            const SizedBox(height: 30)
          ]
        )
      ), 
      overlay: [
        Text("Ativação", style: Font.color(Colors.black).size(24).bold()),
        const SizedBox(height: 20),
        IconTextField("Código de verificação", Icons.mark_email_read_outlined, codeController, 25, private: true),
        RoundedTextButton("ATIVAR", validate)
      ]
    );
  }
}