import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';

class IconDateField extends StatefulWidget {
  final double marginBottom;
  final String text;
  final TextEditingController controller;
  final Color iconColor;

  const IconDateField(this.text, this.controller, this.marginBottom, {this.iconColor = Colors.grey, super.key});

  @override
  State<IconDateField> createState() => _IconDateFieldState();
}

class _IconDateFieldState extends State<IconDateField> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.only(bottom: widget.marginBottom),
      padding: const EdgeInsets.only(left: 10),
      decoration: Style.circularShadowBorder,
      child: TextField(
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(1960, 8),
            lastDate: DateTime.now()
          );
          
          if (picked != null && picked != date) {
            setState(() {
              date = picked;
              widget.controller.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
            });
          }
        },
        readOnly: true,
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.calendar_month, color: widget.iconColor),
          hintText: widget.text
        )
      )
    );
  }
}