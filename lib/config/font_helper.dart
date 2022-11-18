import 'package:flutter/material.dart';

class Font {
  static TextStyle bold() => const TextStyle(fontWeight: FontWeight.bold);
  static TextStyle size(double size) => TextStyle(fontSize: size);
  static TextStyle color(Color color) => TextStyle(color: color);
}

extension FontExtensions on TextStyle {
  TextStyle bold() => merge(const TextStyle(fontWeight: FontWeight.bold));
  TextStyle italic() => merge(const TextStyle(fontStyle: FontStyle.italic));
  TextStyle size(double size) => merge(TextStyle(fontSize: size));
  TextStyle color(Color color) => merge(TextStyle(color: color));
}

extension ColorExtension on Color {
  TextStyle bold() => TextStyle(color: this, fontWeight: FontWeight.bold);
}