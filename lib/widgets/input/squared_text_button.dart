import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';

class SquaredTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double horizontal;
  final double height;
  final bool enabled;
  final IconData? icon;
  final Color background;
  final Color foreground;

  const SquaredTextButton(this.text, this.onPressed, {
    this.icon, 
    this.background = Style.highlightColor, 
    this.foreground = Colors.white, 
    this.horizontal = 0, 
    this.height = 34, 
    this.enabled = true, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    void Function()? onPressed = enabled ? this.onPressed : null;
    Color foreground = enabled ? this.foreground : const Color.fromARGB(255, 76, 76, 76);
    Color background = enabled ? this.background : const Color.fromARGB(255, 179, 179, 179);
    
    return TextButton(
      onPressed: onPressed, 
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: horizontal),
        decoration: BoxDecoration(
          color: background,
          boxShadow: [ BoxShadow(color: const Color.fromARGB(40, 0, 0, 0), offset: Offset.fromDirection(1.6, 4)) ],
          borderRadius: const BorderRadius.all(Radius.circular(5))
        ),
        child: Stack(
          children: [
            Positioned(left: 30, top: 0, bottom: 0, child: Icon(icon, color: foreground)),
            Align(child: Text(text, style: Font.color(foreground)))
          ]
        )
      )
    );
  }
}