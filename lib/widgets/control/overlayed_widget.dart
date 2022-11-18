import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';

class OverlayedWidget extends StatefulWidget {
  static late void Function() show;
  
  final Widget background;
  final bool showOverlay;
  final List<Widget> overlay;
  final bool allowHide;

  const OverlayedWidget({required this.background, required this.overlay, this.showOverlay = false, this.allowHide = true, super.key});
  
  @override
  State<OverlayedWidget> createState() => _OverlayedWidgetState();
}

class _OverlayedWidgetState extends State<OverlayedWidget> {
  late bool showOverlay = widget.showOverlay;

  show() => setState(() => showOverlay = true);
  hide() => setState(() => showOverlay = false);

  @override
  Widget build(BuildContext context) {
    OverlayedWidget.show = show;

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: Style.width(context),
            height: Style.height(context),
            color: Colors.white, 
            child: widget.background
          )
        ),
        Visibility(
          visible: showOverlay,
          child: GestureDetector(
            onTap: () {
              if (widget.allowHide) hide();
            },
            child: Container(color: const Color.fromARGB(100, 0, 0, 0)),
          )
        ),
        Visibility(
          visible: showOverlay,
          child: Align(
            child: Card(
              color: Colors.white,
              child: Container(
                width: Style.width(context) * 0.9,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Color.fromARGB(255, 100, 100, 100), blurRadius: 10),
                    BoxShadow(color: Color.fromARGB(255, 100, 100, 100), blurRadius: 20)
                  ] 
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.overlay
                )
              )
            )
          )
        )
      ]
    );
  }
}