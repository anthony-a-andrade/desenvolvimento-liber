// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:liber/views/livros.dart';
import 'package:liber/widgets/rounded_icon_button.dart';

class RedirectPanel extends StatelessWidget {
  int current;
  void Function(int index, Widget to) switcher;
  
  RedirectPanel({required this.current, required this.switcher, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedIconButton(Icons.home, () => switcher(1, Livros()), isSelected: current == 1),
            RoundedIconButton(Icons.shopping_basket_outlined, () => switcher(2, const Text("b")), isSelected: current == 2),
          ]
        )
      )
    );
  }
}