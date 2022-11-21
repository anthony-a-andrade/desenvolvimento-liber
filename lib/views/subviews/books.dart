import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/model/ad.dart';
import 'package:liber/services/ad_service.dart';
import 'package:liber/services/book_service.dart';
import 'package:liber/views/ad_details.dart';
import 'package:liber/views/home.dart';
import 'package:liber/widgets/control/search_expand_menu_bar.dart';
import 'package:liber/widgets/info/ad_details_card.dart';
import 'package:liber/widgets/info/carousel_indicator.dart';
import 'package:liber/widgets/info/ad_carousel.dart';
import 'package:liber/widgets/input/icon_text_button.dart';

class Books extends StatefulWidget {
  // static late void Function() menuVisibility;
  
  final String userEmail;

  const Books(this.userEmail, {super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  Map<String, Ad> carrossel = {};
  Map<String, Ad> anuncios = {};

  expand() async {
    // var ads = await AdService.expand(5);
    // setState(() => anuncios.addAll(ads));
  }
  
  TextEditingController searchController = TextEditingController();

  void openAd(String id) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      // var anuncio = anuncios.where((anuncio) => anuncio.id == id).first;
      return AdDetails(anuncios[id]!);
    }));
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBooks(widget.userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          dynamic data = snapshot.data!;
          
          if (carrossel.isEmpty) {
            var premium = (data["premium"] as List).map((ad) => Ad.fromJson(ad)).toList();
            for (var element in premium) { 
              carrossel[element.id] = element;
            }
          }

          return Column(
            children: [
              SearchExpandMenuBar(() => Home.menuVisibility(), searchController),
              const SizedBox(height: 5),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text("Destaques da semana!", style: Font.size(20))
                            )
                          ),
                          AdCarousel(items: carrossel.values.toList()),
                          const SizedBox(height: 10),
                          CarouselIndicator(length: carrossel.length),
                          const SizedBox(height: 45),
                          Column(
                            children: List<Widget>.generate(anuncios.length, (index) {
                              var anuncio = anuncios[index];
                              return AdDetailsCard(anuncio!, onPressed: () => openAd(anuncio.id));
                            })
                          ),
                          IconTextButton("Mostrar mais", Icons.add, () => expand(), center: true)
                        ]
                      )
                    )
                  )
                )
              )
            ]
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}