import 'package:flutter/material.dart';
import 'package:liber/config/config.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/widgets/input/icon_text_field.dart';
import 'package:liber/widgets/input/squared_text_button.dart';

class CreateAd extends StatefulWidget {
  static late void Function() menuVisibility;

  final String userEmail;

  const CreateAd(this.userEmail, {super.key});

  @override
  State<CreateAd> createState() => _CreateAdState();
}

class _CreateAdState extends State<CreateAd> {
  TextEditingController isbnController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  String? isbn;
  int tipoAnuncio = 0;

  carregarISBN() => setState(() => isbn = isbnController.text);

  criar() {

  }

  @override
  Widget build(BuildContext context) {
    isbnController.text = "9786555320329";
    precoController.addListener(() { setState(() { }); } );

    bool permitirCompletar = isbn != null;
    if (tipoAnuncio == 1) permitirCompletar &= double.tryParse(precoController.text) != null;

    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: IconTextField("ISBN", Icons.book, isbnController, 0)),
                        const SizedBox(width: 15),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.center
                          ),
                          onPressed: carregarISBN,
                          child: const Icon(Icons.search, color: Colors.black, size: 36),
                        )
                      ]
                    ),
                    const SizedBox(height: 15),
                    if (isbn != null) Image.network("http://$baseUrl/books/$isbn.png", fit: BoxFit.fitWidth),
                    // if (isbn != null) const SizedBox(height: 15),
                    Row(
                      children: [
                        Align(alignment: Alignment.centerLeft, child: Text("Tipo:", style: Font.bold().size(16))),
                        Expanded(child: Container()),
                        DropdownButton(
                          value: tipoAnuncio,
                          underline: const SizedBox(),
                          items: const [
                            DropdownMenuItem(value: 0, child: Text("Anúncio")),
                            DropdownMenuItem(value: 1, child: Text("Venda")),
                          ], 
                          onChanged: (value) => setState(() => tipoAnuncio = value!)
                        )
                      ]
                    ),
                    const SizedBox(height: 10),
                    if (tipoAnuncio == 1) IconTextField("Preço", Icons.attach_money, precoController, 15),
                    SquaredTextButton("CRIAR ANÚNCIO", criar, enabled: permitirCompletar)
                  ]
                )
              )
            )
          )
        )
      ]
    );
  }
}