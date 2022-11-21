import 'package:flutter/material.dart';
import 'package:liber/model/ad.dart';
import 'package:liber/model/dto/user_response.dart';
import 'package:liber/model/user.dart';
import 'package:liber/services/user_service.dart';
import 'package:liber/views/home.dart';
import 'package:liber/widgets/control/duo_selectable_button.dart';
import 'package:liber/widgets/control/search_expand_menu_bar.dart';
import 'package:liber/widgets/info/library_details_card.dart';

class Library extends StatefulWidget {
  final List<Ad> adsMade;
  final List<Ad> purchasesMade;
  final String userEmail;

  const Library(this.userEmail, {required this.adsMade, required this.purchasesMade, super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  TextEditingController searchController = TextEditingController();
  int selected = 0;
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: get(widget.userEmail),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var adsMade = widget.adsMade;
          var purchasesMade = widget.purchasesMade;
          var account = User.fromJson(snapshot.data);
          
          return Column(
            children: [
              SearchExpandMenuBar(() => Home.menuVisibility(), searchController),
              const SizedBox(height: 5),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        children: [
                          DuoSelectableButton(
                            left: "Meus anúncios", 
                            right: "Meus livros",
                            selectLeft: () => setState(() => selected = 0),
                            selectRight: () => setState(() => selected = 1),
                          ),
                          const SizedBox(height: 20),
                          Visibility(
                            visible: selected == 0, 
                            child: Column(
                              children: adsMade.isEmpty ? [] : List<Widget>.generate(adsMade.length, (index) => LibraryDetailsCard(index, adsMade[index]))
                            )
                          ),
                          Visibility(
                            visible: selected == 1, 
                            child: Column(
                              children: purchasesMade.isEmpty ? [] : List<Widget>.generate(purchasesMade.length, (index) => LibraryDetailsCard(index, purchasesMade[index]))
                            )
                          )
                        ]
                      ),
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