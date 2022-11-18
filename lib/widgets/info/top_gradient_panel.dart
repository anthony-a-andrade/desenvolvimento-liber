import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';

class TopGradientPanel extends StatelessWidget {
  final IconData? icon;
  final double iconSize;
  final double fontSize;
  final String text;

  const TopGradientPanel(this.text, this.icon, this.fontSize, this.iconSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Style.width(context),
      height: Style.height(context) / 4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ Style.gradientColorFrom, Style.gradientColorTo ]
        ),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: iconSize, color: Style.gradientForeground),
          const SizedBox(height: 10),
          Text(text, style: Font.color(Style.gradientForeground).size(fontSize).bold())
        ]
      )
    );
  }
}