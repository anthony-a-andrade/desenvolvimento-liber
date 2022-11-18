import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';

class SelectableRoundedButton extends StatelessWidget {
  final String text;
  final bool selected;
  final void Function() onPressed;
  final double blRadius;
  final double tlRadius;
  final double brRadius;
  final double trRadius;
  final double marginLeft;
  final double marginRight;
  
  const SelectableRoundedButton.left(this.text, this.onPressed, this.selected, {
    this.blRadius = 50,
    this.tlRadius = 50,
    this.brRadius = 0,
    this.trRadius = 0,
    this.marginLeft = 25,
    this.marginRight = 0,
    super.key
  });

  const SelectableRoundedButton.right(this.text, this.onPressed, this.selected, {
    this.blRadius = 0,
    this.tlRadius = 0,
    this.brRadius = 50,
    this.trRadius = 50,
    this.marginLeft = 0,
    this.marginRight = 25,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var background = selected ? Style.highlightColor : const Color(0xffE7E7E7);
    var foreground = background.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(blRadius),
              bottomRight: Radius.circular(brRadius),
              topLeft: Radius.circular(tlRadius),
              topRight: Radius.circular(trRadius),
            )
          ),
          margin: EdgeInsets.only(left: marginLeft, right: marginRight),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
          child: Align(child: Text(text, style: Font.color(foreground)))
        )
      )
    );
  }
}