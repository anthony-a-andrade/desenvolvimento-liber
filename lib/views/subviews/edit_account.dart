import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/model/address.dart';
import 'package:liber/model/enums/screen_index.dart';
import 'package:liber/model/user.dart';
import 'package:liber/model/payment_card.dart';
import 'package:liber/services/user_service.dart' as user_service;
import 'package:liber/widgets/control/search_expand_menu_bar.dart';
import 'package:liber/widgets/info/account_info_card.dart';
import 'package:liber/widgets/input/image_picker.dart';

class EditAccount extends StatefulWidget {
  static late void Function() menuVisibility;

  final String userEmail;
  
  const EditAccount(this.userEmail, {super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  bool edit = false;
  late User account;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user_service.get(widget.userEmail),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          account = User.fromJson(snapshot.data);
          Address? primaryAddress = account.address;
          PaymentCard? primaryCard = account.card;
          
          return Column(
            children: [
              SearchExpandMenuBar(() => EditAccount.menuVisibility(), searchController),
              const SizedBox(height: 5),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ImagePicker(image: account.getImage()),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(account.name, style: Font.bold()),
                                      Text(account.accountType.toLowerCase(), style: Font.color(Style.highlightColor).bold())
                                    ]
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Text(account.email, softWrap: false, overflow: TextOverflow.clip)),
                                      TextButton(onPressed: () => setState(() => edit = true), child: const Icon(Icons.edit, color: Style.highlightColor))
                                    ]
                                  )
                                ]
                              ),
                              const SizedBox(height: 15),
                              AccountInfoCard(
                                title: "Endereço", 
                                text: primaryAddress == null ? "Não definido" : primaryAddress.name, 
                                subtext: primaryAddress == null ? "Não definido" : primaryAddress.toString(), 
                                icon: Icons.edit, 
                                to: ScreenIndex.editAddressDetails
                              ),
                              AccountInfoCard(
                                title: "Cartão", 
                                text: primaryCard == null ? "Não definido" : primaryCard.nameCard, 
                                subtext: primaryCard == null ? "Não definido" : primaryCard.toString(), 
                                icon: Icons.credit_card, 
                                to: ScreenIndex.editPaymentDetails
                              )
                            ]
                          )
                        )
                      ]
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