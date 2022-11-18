import 'package:flutter/material.dart';
import 'package:liber/widgets/input/rounded_icon_button.dart';

class SearchExpandMenuBar extends StatelessWidget {
  final void Function() menuVisibility;
  final TextEditingController searchController;
  
  const SearchExpandMenuBar(this.menuVisibility, this.searchController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            RoundedIconButton(Icons.menu, size: 24, () => menuVisibility()),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 0),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Pesquisar...",
                    isDense: true,
                    contentPadding: EdgeInsets.all(0)
                  )
                )
              )
            ),
            RoundedIconButton(Icons.search, size: 24, () { })
          ]
        )
      )
    );
  }
}