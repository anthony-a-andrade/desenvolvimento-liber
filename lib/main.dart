import 'package:demo_alternar_telas/tela_teste.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DemoHome(),
    debugShowCheckedModeBanner: false,
  ));
}

class DemoHome extends StatefulWidget {
  const DemoHome({ Key? key }) : super(key: key);

  @override
  State<DemoHome> createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  double horizontalPadding = 8, verticalPadding = 3;
  int? botaoSelecionado;
  Widget? telaSelecionada;
  Map<int, Widget> telas = {
    1: TelaTeste(),
    2: Column(children: const [ Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("aaa"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("aaaaaa"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("aaaaaaaaaaaaaaa"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("2"), Text("aaaaaa")]),
    3: Column(children: const [ Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("aaa"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("aaaaaa"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("aaaaaaaaaaaaaaa"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("3"), Text("aaaaaa")]),
    4: Column(children: const [ Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("aaa"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("aaaaaa"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("aaaaaaaaaaaaaaa"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("4"), Text("aaaaaa")]),
  };
  ScrollController scrollController = ScrollController();

  Widget RoundedButton(int botaoSelecionado, IconData icon) {
    Function()? onPressed = null;
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
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))
        )
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(horizontalPadding, verticalPadding, horizontalPadding, verticalPadding),
        child: Icon(icon, color: iconColor, size: 30)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 202, 202),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: SizedBox.expand(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: telaSelecionada
                  )
                ),
              )
            ),
            const Padding(padding: EdgeInsets.all(4)),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButton(1, Icons.home),
                    RoundedButton(2, Icons.shopping_basket),
                    RoundedButton(3, Icons.folder_open),
                    RoundedButton(4, Icons.chat_bubble)
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}