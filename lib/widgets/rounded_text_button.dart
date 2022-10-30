// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';

class RoundedTextButton extends StatelessWidget {
  String text;
  void Function() onPressed;
  double bottom;

  RoundedTextButton(this.text, this.onPressed, {this.bottom = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: TextButton(
        onPressed: onPressed, 
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
            gradient: LinearGradient( colors: [ Style.gradientColorFrom, Style.gradientColorTo ] ),
            borderRadius: const BorderRadius.all(Radius.circular(50))
          ),
          child: Align(child: Text(text, style: Style.color(Style.gradientForeground).bold()))
        )
      ),
    );
  }
}