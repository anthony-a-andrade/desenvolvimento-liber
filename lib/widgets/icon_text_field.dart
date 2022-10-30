// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class IconTextField extends StatefulWidget {
  TextEditingController controller;
  IconData? icon;
  Color? iconColor;
  double marginBottom;
  bool private = false;
  String? hint;

  IconTextField(this.hint, this.icon, this.controller, this.marginBottom, {this.iconColor = Colors.grey, super.key});
  IconTextField.private(this.hint, this.icon, this.controller, this.marginBottom, {this.iconColor = Colors.grey, this.private = true, super.key});

  @override
  State<IconTextField> createState() => _IconTextFieldState();
}

class _IconTextFieldState extends State<IconTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 50,
      margin: EdgeInsets.only(bottom: widget.marginBottom),
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [ BoxShadow(color: Colors.black, blurRadius: 2) ]
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.private,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(widget.icon, color: widget.iconColor),
          hintText: widget.hint
        )
      )
    );
  }
}