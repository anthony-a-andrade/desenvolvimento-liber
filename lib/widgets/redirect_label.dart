// ignore_for_file: curly_braces_in_flow_control_structures, must_be_immutable

import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';

class RedirectLabel extends StatelessWidget {
  String text;
  Color color;
  Widget? to;
  double bottom;

  RedirectLabel(this.text, {this.to, this.color = Colors.black, this.bottom = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: TextButton(
        child: Text(
          text,
          style: Style.color(color)
        ),
        onPressed: () {
          if (to != null) Navigator.push(context, MaterialPageRoute(builder: (context) => to!));
          else Navigator.pop(context);
        }
      )
    );
  }
}