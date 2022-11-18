import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';

class ExpandableImage extends StatefulWidget {
  final String src;

  const ExpandableImage(this.src, {super.key});

  @override
  State<ExpandableImage> createState() => _ExpandableImageState();
}

class _ExpandableImageState extends State<ExpandableImage> {
  bool isExpanded = false;
  void expand() => setState(() => isExpanded = !isExpanded);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: expand,
      child: Container(
        width: Style.width(context),
        height: isExpanded ? null : 210,
        color: Colors.black,
        child: Image.network(widget.src, height: isExpanded ? null : 210, fit: BoxFit.fitWidth)
      )
    );
  }
}