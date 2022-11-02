// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:liber/widgets/rounded_icon_button.dart';

class Livros extends StatefulWidget {
  late void Function() exibirMenu;

  Livros({super.key});

  @override
  State<Livros> createState() => _LivrosState();
}

class _LivrosState extends State<Livros> {
  TextEditingController filtroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                RoundedIconButton(Icons.menu, () => widget.exibirMenu()),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 6),
                    child: TextField(
                      controller: filtroController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Pesquisar...",
                        isDense: true,
                        contentPadding: EdgeInsets.all(0)
                      )
                    )
                  )
                ),
                RoundedIconButton(Icons.search, () { })
              ]
            )
          )
        ),
        const SizedBox(height: 5),
        Expanded(
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(children: const [])
              )
            )
          )
        )
      ]
    );
  }
}