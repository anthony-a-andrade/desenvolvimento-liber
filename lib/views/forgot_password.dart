import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/model/dto/file_response.dart';
import 'package:liber/model/dto/user_response.dart';
import 'package:liber/services/file_service.dart';
import 'package:liber/services/user_service.dart';
import 'package:liber/views/login.dart';
import 'package:liber/widgets/control/overlayed_widget.dart';
import 'package:liber/widgets/control/redirect_label.dart';
import 'package:liber/widgets/info/info_dialog.dart';
import 'package:liber/widgets/info/snackbar.dart';
import 'package:liber/widgets/info/top_gradient_panel.dart';
import 'package:liber/widgets/input/icon_text_field.dart';
import 'package:liber/widgets/input/rounded_text_button.dart';

class ForgotPassword extends StatefulWidget {
  final bool showOverlay;

  const ForgotPassword({this.showOverlay = false, super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  recover() async {
    String email = emailController.text;

    UserResponse response = await UserService.forgotPassword(email);
    if (!mounted) return;
    if (response.status == 201) {
      Snackbar.show(context, "Um código de verificação foi enviado para o e-mail fornecido.");
      OverlayedWidget.show();
      await RecoverFileService.save(response.token!, email);
    } else {
      InfoDialog.error(context, response.message!);
    }
  }

  validate() async {
    String senha = passwordCrontroller.text;
    String codigo = codeController.text;

    FileResponse? recover = (await RecoverFileService.get())!;
    String token = recover.token!;
    String email = recover.email!;
    
    if (!mounted) return;
    if (codigo == token) {
      UserResponse response = await UserService.changePassword(email, senha);
      if (!mounted) return;
      if (response.status == 200) {
        Snackbar.show(context, "Senha redefinida!");

        if (Navigator.canPop(context)) {
          Navigator.popUntil(context, (route) => route.isFirst);
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
        }
        
        await RecoverFileService.delete();
      } else {
        InfoDialog.error(context, response.message!);
      }
    } else {
      Snackbar.show(context, "Código de verificação incorreto.");
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordCrontroller = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return OverlayedWidget(
      allowHide: false,
      showOverlay: widget.showOverlay,
      background: Column(
        children: [
          const TopGradientPanel("Recuperação", Icons.lock_person_sharp, 24, 80),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.all(Style.scaffoldPadding),
            child: Column(
              children: [
                IconTextField("E-mail", Icons.email, emailController, 20),
                RoundedTextButton("RECUPERAR", recover, bottom: 5)
              ]
            ),
          ),
          const RedirectLabel("Voltar"),
          Expanded(child: Container())
        ]
      ),
      overlay: [
        Text("Recuperação", style: Font.color(Colors.black).size(24).bold()),
        const SizedBox(height: 20),
        IconTextField("Nova senha", Icons.security, passwordCrontroller, 20),
        IconTextField("Código de verificação", Icons.lock_outlined, codeController, 20),
        RoundedTextButton("RECUPERAR", validate),
      ]
    );
  }
}