import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';

class SelectableWord extends StatefulWidget {
  final String id;
  final dynamic entry;
  final bool selected;
  final void Function(String word) select;
  
  const SelectableWord(this.id, this.entry, this.selected, this.select, {super.key});

  @override
  State<SelectableWord> createState() => _SelectableWordState();
}

class _SelectableWordState extends State<SelectableWord> {
  @override
  Widget build(BuildContext context) {
    var selected = widget.selected;
    var entry = widget.entry;
    print(entry);

    var key = entry["palavra"] as String;
    var color = entry["cor"] as Color;

    Color foreground = selected ? (color.computeLuminance() > 0.5 ? Colors.black : Colors.white) : Colors.black;

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.select(widget.id),
        child: Container(
          height: 70,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: color),
            color: selected ? color : null
          ),
          child: Align(child: Text(key, softWrap: true, style: Font.color(foreground), textAlign: TextAlign.center))
        )
      )
    );
  }
}