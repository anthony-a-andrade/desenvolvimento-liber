import 'package:flutter/material.dart';

class Style {
  static Color gradientColorFrom = const Color.fromRGBO(63, 131, 248, 1);
  static Color gradientColorTo = const Color.fromRGBO(6, 182, 212, 1);
  static Color gradientForeground = Colors.white;
  static const Color highlightColor = Color(0xff3DD5E4);
  static double scaffoldPadding = 24;


  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  
  static BoxDecoration circularShadowBorder = const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(20)),
    boxShadow: [ 
      BoxShadow(color: Color.fromARGB(255, 217, 217, 217), blurRadius: 9), 
      BoxShadow(color: Colors.transparent, blurRadius: 3) 
    ]
  );
  
  static BoxDecoration squaredShadowBorder = const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(5)),
    boxShadow: [ 
      BoxShadow(color: Color.fromARGB(255, 217, 217, 217), blurRadius: 9), 
      BoxShadow(color: Colors.transparent, blurRadius: 3) 
    ]
  );
}