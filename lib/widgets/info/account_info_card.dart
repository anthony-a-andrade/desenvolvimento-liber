import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/model/enums/screen_index.dart';
import 'package:liber/views/home.dart';

class AccountInfoCard extends StatelessWidget {
  final String title;
  final String text;
  final String subtext;
  final IconData icon;
  final ScreenIndex to;

  const AccountInfoCard({required this.title, required this.text, required this.subtext, required this.icon, required this.to, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Home.switchScreen(to),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: Style.squaredShadowBorder,
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Font.size(16).bold()),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text, style: Font.bold()),
                  Text(subtext)
                ]
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Style.highlightColor),
                  const SizedBox(width: 10),
                  const Text("Clique para editar")
                ]
              )
            ]
          )
        ),
      ),
    );
  }
}