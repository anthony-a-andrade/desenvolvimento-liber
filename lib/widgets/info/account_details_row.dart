import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';

class AccountDetailsRow extends StatelessWidget {
  final dynamic start;
  final dynamic end;
  final bool boldStart;
  final bool boldEnd;
  
  const AccountDetailsRow(this.start, this.end, {this.boldStart = false, this.boldEnd = false, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 14, color: Colors.black),
      child: Row(
        children: [
          Text(start.toString(), style: boldStart ? Font.bold() : null),
          const SizedBox(width: 4),
          Text(end.toString(), style: boldEnd ? Font.bold() : null)
        ]
      )
    );
  }
}