import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:liber/config/config.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/services/interest_service.dart';
import 'package:liber/views/home.dart';
import 'package:liber/widgets/control/selectable_word.dart';
import 'package:liber/widgets/input/squared_text_button.dart';
import 'package:http/http.dart' as http;

class UserInterests extends StatefulWidget {
  final String email;
  const UserInterests(this.email, {super.key});

  @override
  State<UserInterests> createState() => _UserInterestsState();
}

class _UserInterestsState extends State<UserInterests> {
  bool enabled = false;
  var palavras = <String, dynamic>{};
  var selecionadas = <String>{};
  
  @override
  initState() {
    super.initState();
    expand();
  }

  expand() async {
    var entries = await InterestService.expand();
    setState(() => palavras.addEntries(entries));
  }

  saveGenres() async {
    var uri = Uri.http(baseUrl, "/api/app_user/");
    var body = json.encode({ 'email': widget.email, 'genres': selecionadas.toList() });
    
    var response = await http.put(uri, 
      body: body,
      headers: { "Content-Type": "application/json" }
    );

    int status = response.statusCode;
    if (status == 200) {
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(widget.email)));
    }
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
    var keys = palavras.keys.toList();

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
                  children: List<int>.generate(keys.length ~/ 2, (index) => index * 2).map((pos) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SelectableWord(keys[pos], palavras[keys[pos]], selecionadas.contains(keys[pos]), select),
                          const SizedBox(width: 15),
                          SelectableWord(keys[pos + 1], palavras[keys[pos + 1]], selecionadas.contains(keys[pos + 1]), select)
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
            SquaredTextButton("CONTINUAR", saveGenres, background: Colors.white, foreground: Style.highlightColor, enabled: enabled)
          ]
        )
      )
    );
  }
}