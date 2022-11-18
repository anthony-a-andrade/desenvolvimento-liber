import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';

class RedirectLabel extends StatelessWidget {
  final String text;
  final Color color;
  final Widget? to;
  final double bottom;

  const RedirectLabel(this.text, {this.to, this.color = Colors.black, this.bottom = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: TextButton(
        child: Text(
          text,
          style: Font.color(color)
        ),
        onPressed: () {
          if (to != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => to!));
          } else {
            Navigator.pop(context);
          }
        }
      )
    );
  }
}