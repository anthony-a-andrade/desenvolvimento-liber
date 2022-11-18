import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/model/ad.dart';
import 'package:liber/widgets/control/expandable_widget.dart';
import 'package:liber/widgets/info/ad_details_row.dart';
import 'package:liber/widgets/info/expandable_image.dart';
import 'package:liber/widgets/input/squared_text_button.dart';

class AdDetails extends StatefulWidget {
  final Ad anuncio;

  const AdDetails(this.anuncio, {super.key});

  @override
  State<AdDetails> createState() => _AdDetailsState();
}

class _AdDetailsState extends State<AdDetails> {
  @override
  Widget build(BuildContext context) {
    Ad anuncio = widget.anuncio;

    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                ExpandableImage(anuncio.book.url),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: Style.width(context),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("R\$${anuncio.getPrice()}", style: Font.size(24).bold()),
                          TextButton(
                            child: Text("Ver meios de pagamento", style: Font.color(Style.highlightColor).size(14)),
                            onPressed: () {}
                          )
                        ]
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(anuncio.book.title, softWrap: false, overflow: TextOverflow.ellipsis, style: Font.size(16).bold())
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SquaredTextButton("TROCAR", () { }, horizontal: 25),
                          SquaredTextButton("COMPRAR", () { }, horizontal: 25),
                        ]
                      ),
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Sobre o livro", style: Font.size(16).bold())
                      ),
                      const SizedBox(height: 15),
                      AdDetailsRow(Icons.app_registration, "ISBN", anuncio.book.isbn),
                      const SizedBox(height: 15),
                      AdDetailsRow(Icons.account_circle, "Autores", anuncio.book.authors.join(", ")),
                      const SizedBox(height: 15),
                      AdDetailsRow(Icons.more, "Descrição", anuncio.book.synopsis),
                      const SizedBox(height: 30),
                      ExpandableWidget(
                        text: "Ficha Técnica", 
                        child: Wrap(
                          children: const [ 
                            Text("Ficha tecnica com wrap no texto só pra ficar maior e mostrar que é expansivo") 
                          ]
                        )
                      )
                    ]
                  )
                )
              ]
            )
          )
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            color: const Color.fromARGB(100, 0, 0, 0),
            width: Style.width(context),
            height: 50,
            child: Row(
              children: [
                TextButton(
                  child: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context)
                ),
                Expanded(child: Container())
              ]
            )
          )
        )
      ]
    );
  }
}