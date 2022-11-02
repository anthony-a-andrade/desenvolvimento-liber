// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/services/file_service.dart';
import 'package:liber/views/livros.dart';
import 'package:liber/views/login.dart';
import 'package:liber/widgets/icon_text_button.dart';
import 'package:liber/widgets/redirect_panel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late int index;
  late Widget screen;
  bool menuVisivel = false;
  late AnimationController controller;
  late Animation<Offset> offset;
  
  mudarTela(int index, Widget screen) {
    if (index != this.index) {
      setState(() {
        if (index == 1) (screen as Livros).exibirMenu = exibirMenu;

        this.index = index;
        this.screen = screen;
      });
    }
  }

  exibirMenu() {
    switch (controller.status) {
      case AnimationStatus.completed:
        menuVisivel = false;
        controller.reverse();
        break;
      case AnimationStatus.dismissed:
        menuVisivel = true;
        controller.forward();
        break;
      default:
    }
  }
  
  logout() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
    await LoginFileService.delete();
  }

  @override
  void initState() {
    super.initState();
    index = 1;
    screen = Livros();
    (screen as Livros).exibirMenu = exibirMenu;

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    offset = Tween<Offset>(end: Offset.zero, begin: const Offset(-1.0, 0)).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails drag) {
        if(drag.primaryVelocity == null) return;
        else if(drag.primaryVelocity! < 0 && menuVisivel) exibirMenu();
        else if(drag.primaryVelocity! > 0 && !menuVisivel) exibirMenu();
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [ Style.gradientColorFrom, Style.gradientColorTo ])
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Expanded(child: screen),
                  const SizedBox(height: 5),
                  RedirectPanel(current: index, switcher: mudarTela)
                ])
              )
            )
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SlideTransition(
              position: offset,
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(right: BorderSide(width: 1, color: Colors.black))
                    ),
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        IconTextButton("BOTAO 1", Icons.disabled_by_default, () { }),
                        Expanded(child: Container()),
                        IconTextButton("SAIR", Icons.logout, logout),
                        const SizedBox(height: 15)
                      ]
                    )   
                  ),
                  GestureDetector(
                    onTap: exibirMenu,
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}