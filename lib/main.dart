import 'package:demo_alternar_telas/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LiberApp());
}

class LiberApp extends StatelessWidget {
  const LiberApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoHome(),
    );
  }
}
