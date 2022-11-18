import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/model/ad.dart';

class LibraryDetailsCard extends StatelessWidget {
  final Ad ad;
  final int index;
  
  const LibraryDetailsCard(this.index, this.ad, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage(ad.book.url),
                fit: BoxFit.cover
              )
            ),
            width: 100,
            height: 150
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 130,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Livro ${index + 1}", style: Font.size(16)),
                      Expanded(child: Container()),
                      Text("R\$${ad.getPrice()}", style: Font.size(16))
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Status: "),
                      Text(ad.status, style: Font.bold())
                    ]
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Text(ad.book.synopsis, overflow: TextOverflow.ellipsis, softWrap: true, maxLines: 4)
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}