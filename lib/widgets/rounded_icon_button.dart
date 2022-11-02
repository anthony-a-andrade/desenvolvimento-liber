// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  void Function() onPressed;
  IconData icon;
  bool isSelected;

  RoundedIconButton(this.icon, this.onPressed, {this.isSelected = false, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed, 
      icon: Icon(icon, size: 30, color: isSelected ? Colors.black : Colors.grey)
    );
  }
}