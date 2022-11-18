import 'package:flutter/material.dart';

class InfoDialog {
  static show(BuildContext context, String text, IconData icon, Color iconColor, double iconSize) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () => Navigator.pop(context)
    );

    AlertDialog alerta = AlertDialog(
      title: Icon(icon, color: iconColor, size: iconSize),
      content: Text(text),
      actions: [ okButton ]
    );

    showDialog(
      context: context,
      builder: (BuildContext context) { return alerta; }
    );
  }

  static info(BuildContext context, String text) {
    show(context, text, Icons.info_outline, Colors.black, 50);
  }

  static error(BuildContext context, String text) {
    show(context, text, Icons.error_outline, const Color.fromARGB(255, 255, 17, 0), 50);
  }
}