import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';

class SelectableWord extends StatefulWidget {
  final MapEntry<String, Color> entry;
  final bool selected;
  final void Function(String word) select;
  
  const SelectableWord(this.entry, this.selected, this.select, {super.key});

  @override
  State<SelectableWord> createState() => _SelectableWordState();
}

class _SelectableWordState extends State<SelectableWord> {
  @override
  Widget build(BuildContext context) {
    var selected = widget.selected;
    var entry = widget.entry;
    Color foreground = selected ? (entry.value.computeLuminance() > 0.5 ? Colors.black : Colors.white) : Colors.black;

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.select(entry.key),
        child: Container(
          height: 70,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: entry.value),
            color: selected ? entry.value : null
          ),
          child: Align(child: Text(entry.key, softWrap: true, style: Font.color(foreground), textAlign: TextAlign.center))
        )
      )
    );
  }
}