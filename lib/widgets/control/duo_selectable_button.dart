import 'package:flutter/material.dart';
import 'package:liber/widgets/input/selectable_rounded_button.dart';

class DuoSelectableButton extends StatefulWidget {
  final String left;
  final String right;
  final void Function() selectLeft;
  final void Function() selectRight;
  
  const DuoSelectableButton({
    required this.left, 
    required this.right, 
    required this.selectLeft, 
    required this.selectRight, 
    super.key
  });

  @override
  State<DuoSelectableButton> createState() => _DuoSelectableButtonState();
}

class _DuoSelectableButtonState extends State<DuoSelectableButton> {
  int selected = 0;

  select(int index) {
    if (index != selected) setState(() => selected = index);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SelectableRoundedButton.left(widget.left, () { widget.selectLeft(); select(0); }, selected == 0),
        SelectableRoundedButton.right(widget.right, () { widget.selectRight(); select(1); }, selected == 1)
      ]
    );
  }
}