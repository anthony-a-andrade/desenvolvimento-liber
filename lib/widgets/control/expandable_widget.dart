import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/widgets/control/stateful_visibility.dart';

class ExpandableWidget extends StatefulWidget {
  final String text;
  final Widget child;

  const ExpandableWidget({required this.text, required this.child, super.key});

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  bool isExpanded = false;
  
  void expand() => setState(() => isExpanded = !isExpanded);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: expand,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.text, style: Font.size(20).bold()),
              Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down, size: 35)
            ]
          ),
          StatefulVisibility(visibility: isExpanded, child: widget.child)
        ]
      )
    );
  }
}