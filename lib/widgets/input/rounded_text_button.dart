import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';

class RoundedTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double bottom;

  const RoundedTextButton(this.text, this.onPressed, {this.bottom = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: TextButton(
        onPressed: onPressed, 
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient( colors: [ Style.gradientColorFrom, Style.gradientColorTo ] ),
            borderRadius: const BorderRadius.all(Radius.circular(50))
          ),
          child: Align(child: Text(text, style: Font.color(Style.gradientForeground).bold()))
        )
      ),
    );
  }
}