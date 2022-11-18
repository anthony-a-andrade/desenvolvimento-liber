import 'dart:async';

import 'package:flutter/material.dart';

class ScrollableText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const ScrollableText({required this.text, required this.style, super.key});

  @override
  State<ScrollableText> createState() => _ScrollableTextState();
}

class _ScrollableTextState extends State<ScrollableText> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late Timer timer;
  
  _scroll() async {
    timer = Timer(const Duration(seconds: 3), () {
      if (_scrollController.hasClients) {
        double maxExtent = _scrollController.position.maxScrollExtent;
        double distanceDifference = maxExtent - _scrollController.offset;
        double durationDouble = distanceDifference / 40;

        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(seconds: durationDouble.toInt()),
          curve: Curves.linear).whenComplete(() {
            if (timer.isActive) timer.cancel();

            Timer(const Duration(seconds: 2), () {
              if (_scrollController.hasClients) _scrollController.jumpTo(0);
            });

            _scroll();
          }
        );
      }
    });
  }
  
  @override
  void initState() {
    super.initState();
    _scroll();
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Text(
        widget.text,
        style: widget.style,
        overflow: TextOverflow.clip,
        softWrap: false
      )
    );
  }
}