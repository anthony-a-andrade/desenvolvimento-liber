// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';

class IconTextButton extends StatelessWidget {
  String text;
  IconData icon;
  void Function() onPressed;
  Color color;
  double iconSize;
  
  IconTextButton(this.text, this.icon, this.onPressed, {this.color = Colors.black, this.iconSize = 30, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: iconSize),
            const SizedBox(width: 5),
            Text(text, style: Style.color(color).bold()),
            Expanded(child: Container())
          ]
        )
      )
    );
  }
}