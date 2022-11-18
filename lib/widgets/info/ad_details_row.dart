import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';

class AdDetailsRow extends StatefulWidget {
  final IconData icon;
  final String name;
  final Color color;
  final Color iconColor;
  final double size;
  final String value;
  
  const AdDetailsRow(this.icon, this.name, this.value, {this.size = 36, this.color = const Color(0xFFC9C9C9), this.iconColor = Colors.white, super.key});

  @override
  State<AdDetailsRow> createState() => _AdDetailsRowState();
}

class _AdDetailsRowState extends State<AdDetailsRow> {
  bool isWrapped = false;

  void wrapText() => setState(() => isWrapped = !isWrapped);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: wrapText,
      child: Row(
        children: [
          Container(
            width: widget.size,
            height: widget.size,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              boxShadow: const [ BoxShadow(color: Colors.black, blurRadius: 2) ]
            ),
            child: Icon(widget.icon, color: widget.iconColor)
          ),
          Expanded(
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: Font.size(16).bold()),
                    Text(widget.value, style: Font.size(14), overflow: isWrapped ? null : TextOverflow.ellipsis)
                  ]
                ),
              ]
            ),
          )
        ]
      ),
    );
  }
}