import 'package:flutter/material.dart';
import 'package:liber/model/enums/screen_index.dart';
import 'package:liber/views/home.dart';
import 'package:liber/widgets/input/rounded_icon_button.dart';

class RedirectPanel extends StatelessWidget {
  final ScreenIndex current;

  const RedirectPanel({required this.current, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedIconButton(Icons.home, size: 24, () => Home.switchScreen(ScreenIndex.books), isSelected: current == ScreenIndex.books),
            RoundedIconButton(Icons.layers, size: 24, () => Home.switchScreen(ScreenIndex.library), isSelected: current == ScreenIndex.library)
          ]
        )
      )
    );
  }
}