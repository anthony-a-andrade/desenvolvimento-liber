import 'package:demo_alternar_telas/home/list.dart';
import 'package:flutter/material.dart';

class DemoHome extends StatefulWidget {
  const DemoHome({Key? key}) : super(key: key);

  @override
  State<DemoHome> createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  double horizontalPadding = 8, verticalPadding = 3;
  int? botaoSelecionado = 1;
  Widget? telaSelecionada = ListPage();
  Map<int, Widget> telas = {
    1: ListPage(),
    2: Column(children: const [
      Text("2"),
    ]),
    3: Column(children: const [
      Text("3"),
    ]),
    4: Column(children: const [
      Text("4"),
    ]),
  };
  ScrollController scrollController = ScrollController();

  Widget RoundedButton(int botaoSelecionado, IconData icon) {
    Function()? onPressed;
    Color iconColor = Colors.black;

    if (botaoSelecionado != this.botaoSelecionado) {
      onPressed = () {
        setState(() {
          this.botaoSelecionado = botaoSelecionado;
          telaSelecionada = telas[botaoSelecionado];
          scrollController.jumpTo(0);
        });
      };

      iconColor = const Color.fromARGB(255, 74, 74, 74);
    }

    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)))),
        child: Padding(
            padding: EdgeInsets.fromLTRB(horizontalPadding, verticalPadding,
                horizontalPadding, verticalPadding),
            child: Icon(icon, color: iconColor, size: 30)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 202, 202, 202),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Expanded(
                  child: Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: SizedBox.expand(
                    child: SingleChildScrollView(
                        controller: scrollController, child: telaSelecionada)),
              )),
              const Padding(padding: EdgeInsets.all(4)),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundedButton(1, Icons.home),
                            RoundedButton(2, Icons.shopping_basket),
                            RoundedButton(3, Icons.folder_open),
                            RoundedButton(4, Icons.chat_bubble)
                          ])))
            ])));
  }
}
