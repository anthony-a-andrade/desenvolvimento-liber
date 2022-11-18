import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/model/address.dart';
import 'package:liber/model/enums/screen_index.dart';
import 'package:liber/model/payment_card.dart';
import 'package:liber/model/user.dart';
import 'package:liber/widgets/control/search_expand_menu_bar.dart';
import 'package:liber/widgets/info/account_info_card.dart';
import 'package:liber/widgets/input/icon_text_field.dart';
import 'package:liber/widgets/input/image_picker.dart';

class EditAccount extends StatefulWidget {
  static late void Function() menuVisibility;

  final User account;
  
  const EditAccount(this.account, {super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  bool edit = false;

  Widget editAccountInfo() {
    return Column(
      children: [
        IconTextField("Nome", Icons.account_circle, nomeController, 15),
        Row(
          children: [
            Expanded(child: IconTextField("E-mail", Icons.mail, emailController, 0)),
            TextButton(onPressed: () => setState(() => edit = false), child: const Icon(Icons.save_sharp, color: Style.highlightColor,))
          ]
        )
      ]
    );
  }

  Widget showAccountInfo(User account) {
    return Column(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    var account = widget.account;

    Iterable<Address> primaryAddress_ = account.address.where((c) => c.main);
    Address? primaryAddress = primaryAddress_.isEmpty ? null : primaryAddress_.first;
    
    Iterable<PaymentCard> primaryCard_ = account.cards.where((c) => c.main);
    PaymentCard? primaryCard = primaryCard_.isEmpty ? null : primaryCard_.first;

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
                  ImagePicker(image: account.url),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (edit) editAccountInfo() else showAccountInfo(account),
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
  }
}