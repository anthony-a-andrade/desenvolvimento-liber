import 'package:flutter/material.dart';

class StatefulVisibility extends StatefulWidget {
  final bool visibility;
  final Widget child;

  const StatefulVisibility({required this.visibility, required this.child, super.key});

  @override
  State<StatefulVisibility> createState() => _StatefulVisibilityState();
}

class _StatefulVisibilityState extends State<StatefulVisibility> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visibility,
      child: widget.child,
    );
  }
}