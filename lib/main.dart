import 'package:demo_alternar_telas/home/home.dart';
import 'package:demo_alternar_telas/login/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LiberApp());
}

class LiberApp extends StatelessWidget {
  const LiberApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
