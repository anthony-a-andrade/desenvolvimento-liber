import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';

class RoundedTextField extends StatelessWidget {
  final String text;
  final String hint;
  final TextEditingController controller;

  const RoundedTextField(this.text, this.hint, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    controller.text = text;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: Style.circularShadowBorder,
          height: 30
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
          child: SizedBox(
            height: 35,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint
              )
            ),
          )
        )
      ]
    );
  }
}