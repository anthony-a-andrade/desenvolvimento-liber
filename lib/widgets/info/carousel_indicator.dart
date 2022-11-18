import 'package:flutter/material.dart';

class CarouselIndicator extends StatefulWidget {
  static late void Function(int current) switchCurrent;

  final int length;
  
  const CarouselIndicator({required this.length, super.key});

  @override
  State<CarouselIndicator> createState() => _CarouselIndicatorState();
}

class _CarouselIndicatorState extends State<CarouselIndicator> {
  int page = 0;

  switchCurrent(int current) => setState(() => page = current);

  @override
  Widget build(BuildContext context) {
    CarouselIndicator.switchCurrent = switchCurrent;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(widget.length, (index) {
        int atual = ((widget.length ~/ 2) + (index + 1)) % widget.length;
        Color color = atual == page 
          ? const Color.fromARGB(255, 130, 130, 130) 
          : const Color.fromARGB(255, 199, 199, 199);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: Icon(Icons.circle, size: 10, color: color)
        );
      })
    );
  }
}