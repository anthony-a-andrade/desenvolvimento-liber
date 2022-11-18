import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;
  final double size;
  final bool isSelected;

  const RoundedIconButton(this.icon, this.onPressed, {this.size = 30, this.isSelected = false, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed, 
      icon: Icon(icon, size: size, color: isSelected ? Colors.black : Colors.grey)
    );
  }
}