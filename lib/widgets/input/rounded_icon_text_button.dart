import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';

class RoundedIconTextButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;
  final double marginBottom;
  final Color background;
  final Color foreground;
  final double iconSize;
  final Color iconColor;

  const RoundedIconTextButton(this.text, this.icon, this.onPressed, this.marginBottom, {
    this.iconSize = 20, 
    this.iconColor = Colors.white, 
    this.background = Style.highlightColor, 
    this.foreground = Colors.black, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 
      child: Container(
        margin: EdgeInsets.only(bottom: marginBottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(50)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(icon, color: iconColor, size: iconSize)
              )
            ),
            const SizedBox(width: 15),
            Text(text, style: Font.color(foreground).size(14).bold())
          ]
        )
      )
    );
  }
}