import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';

class IconTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final Color? iconColor;
  final double marginBottom;
  final bool private;
  final String? hint;

  const IconTextField(this.hint, this.icon, this.controller, this.marginBottom, {
    this.iconColor = Colors.grey, 
    this.private = false, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.only(bottom: marginBottom),
      padding: const EdgeInsets.only(left: 10),
      decoration: Style.circularShadowBorder,
      child: TextField(
        controller: controller,
        obscureText: private,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon, color: iconColor),
          hintText: hint
        )
      )
    );
  }
}