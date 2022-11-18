import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';

class IconTextButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;
  final Color color;
  final double iconSize;
  final bool center;

  const IconTextButton(this.text, this.icon, this.onPressed, {this.color = Colors.black, this.iconSize = 30, this.center = false, super.key});

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
            Text(text, style: Font.color(color).bold()),
            if (!center) Expanded(child: Container())
          ]
        )
      )
    );
  }
}