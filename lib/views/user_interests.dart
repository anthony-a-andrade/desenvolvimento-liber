import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/services/interest_service.dart';
import 'package:liber/widgets/control/selectable_word.dart';
import 'package:liber/widgets/input/squared_text_button.dart';

class UserInterests extends StatefulWidget {
  const UserInterests({super.key});

  @override
  State<UserInterests> createState() => _UserInterestsState();
}

class _UserInterestsState extends State<UserInterests> {
  bool enabled = false;
  var palavras = <String, Color>{};
  var selecionadas = <String>{};
  
  @override
  initState() {
    super.initState();
    expand();
  }

  expand() async {
    var entries = await InterestService.expand(8);
    setState(() => palavras.addEntries(entries));
  }

  select(String palavra) {
    setState(() {
      bool status = !selecionadas.add(palavra);
      if (status) selecionadas.remove(palavra);
      enabled = [3, 4, 5].contains(selecionadas.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    var palavras = this.palavras.entries.toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text("Escolha ao menos 3 itens que você mais se identifica!", softWrap: true, style: Font.size(16)),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: List<int>.generate(palavras.length ~/ 2, (index) => index * 2).map((pos) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SelectableWord(palavras[pos], selecionadas.contains(palavras[pos].key), select),
                          const SizedBox(width: 15),
                          SelectableWord(palavras[pos + 1], selecionadas.contains(palavras[pos + 1].key), select)
                        ]
                      )
                    );
                  }).toList()
                )
              )
            ),
            const SizedBox(height: 30),
            SquaredTextButton("CARREGAR MAIS", expand),
            const SizedBox(height: 15),
            SquaredTextButton("CONTINUAR", () { }, background: Colors.white, foreground: Style.highlightColor, enabled: enabled)
          ]
        )
      )
    );
  }
}