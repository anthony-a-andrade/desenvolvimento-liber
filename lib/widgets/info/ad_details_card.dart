import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/model/ad.dart';

class AdDetailsCard extends StatelessWidget {
  final Ad anuncio;
  final void Function() onPressed;
  
  const AdDetailsCard(this.anuncio, {required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [ BoxShadow(color: Color.fromARGB(255, 185, 185, 185), blurRadius: 5) ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(anuncio.book.url)
                        )
                      )
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(anuncio.book.title, style: Font.size(14).bold(), overflow: TextOverflow.ellipsis, softWrap: false),
                          const SizedBox(height: 5),
                          Text("R\$${anuncio.getPrice()}", style: Font.size(18)),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text("Vendido por: "),
                              Expanded(
                                child: Text(
                                  anuncio.user.name ?? "", 
                                  style: Font.color(const Color(0xffE265D8)), 
                                  overflow: TextOverflow.ellipsis, 
                                  softWrap: false
                                )
                              )
                            ]
                          )
                        ]
                      )
                    )
                  ]
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 20,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      String genre = anuncio.book.genre[index].name;
                      var random = Random();
                      Color background = Color.fromRGBO(50 + random.nextInt(206), 50 + random.nextInt(206), 100 + random.nextInt(156), 1);
                      Color foreground = background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
                      
                      return Container(
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          color: background,
                          borderRadius: const BorderRadius.all(Radius.circular(50))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(genre, style: Font.color(foreground).size(10))
                        )
                      );
                    },
                    itemCount: anuncio.book.genre.length,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}