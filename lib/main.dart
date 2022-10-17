import 'package:flutter/material.dart';
import 'package:liber_app/home/home.dart';
import 'package:liber_app/homepage.dart';


void main() {
  runApp( LiberApp());
}

class LiberApp extends StatelessWidget {
  LiberApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
