// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';

class TopGradientPanel extends StatelessWidget {
  IconData? icon;
  double iconSize;
  String text;
  double size;

  TopGradientPanel(this.text, this.icon, this.size, this.iconSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ Style.gradientColorFrom, Style.gradientColorTo ],
        ),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: Style.gradientForeground
          ),
          const SizedBox(height: 10),
          Text(text, style: Style.color(Style.gradientForeground).size(size).bold())
        ]
      )
    );
  }
}