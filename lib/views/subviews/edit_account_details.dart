import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/model/address.dart';
import 'package:liber/model/payment_card.dart';
import 'package:liber/views/subviews/edit_account.dart';
import 'package:liber/widgets/control/address_block_edit.dart';
import 'package:liber/widgets/control/payment_card_block_edit.dart';
import 'package:liber/widgets/control/search_expand_menu_bar.dart';
import 'package:liber/widgets/info/snackbar.dart';
import 'package:liber/widgets/input/squared_text_button.dart';

class EditAccountDetails extends StatefulWidget {
  final List<Address>? addresses;
  final List<PaymentCard>? cards;
  const EditAccountDetails({this.addresses, this.cards, super.key});

  @override
  State<EditAccountDetails> createState() => _EditAccountDetailsState();
}

class _EditAccountDetailsState extends State<EditAccountDetails> {
  late String main;
  late List<Address>? addresses = widget.addresses != null ? widget.addresses!.map((e) => Address.clone(e)).toList() : null;
  late List<PaymentCard>? cards = widget.cards != null ? widget.cards!.map((e) => PaymentCard.clone(e)).toList() : null;

  selectAddress(String id) {
    setState(() {
      if (main != "") addresses!.firstWhere((element) => element.id == main).main = false;
      addresses!.firstWhere((element) => element.id == id).main = true;
      main = id;
    });
  }

  deleteAddress(String id) {
    setState(() {
      if (addresses!.length == 1) { Snackbar.show(context, "É necessário ao menos um endereço!"); } 
      else { addresses!.removeWhere((element) => element.id == id); }
    });
  }

  selectCard(String id) {
    setState(() {
      if (main != "") cards!.firstWhere((element) => element.id == main).main = false;
      cards!.firstWhere((element) => element.id == id).main = true;
      main = id;
    });
  }

  deleteCard(String id) {
    setState(() {
      cards!.removeWhere((element) => element.id == id);
    });
  }
  
  create(bool isAddress) {
    setState(() {
      if (isAddress) { addresses!.add(Address.empty(DateTime.now().toString())); } 
      else { cards!.add(PaymentCard.empty(DateTime.now().toString())); }
    });
  }

  save() {
    setState(() {
      if (addresses != null) { widget.addresses!.clear(); widget.addresses!.addAll(addresses!); } 
      else { widget.cards!.clear(); widget.cards!.addAll(cards!); }
    });
  }

  @override
  void initState() {
    super.initState();
    
    try {
      if (addresses != null) { main = addresses!.firstWhere((i) => i.main).id; } 
      else { main = cards!.firstWhere((i) => i.main).id; }
    } catch (e) { main = ""; }
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var list = (addresses ?? cards)!;
    var isAddress = list is List<Address>;

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
                  Column(
                    children: list.isEmpty ? [ ] : List<Widget>.generate(list.length, (index) {
                      var item = list[index];
                      if (isAddress) {
                        return AddressBlockEdit(
                          index: index,
                          address: item as Address, 
                          mainAddress: main, 
                          select: selectAddress,
                          delete: deleteAddress
                        ); 
                      } 
                      else { 
                        return PaymentCardBlockEdit(
                          index: index,
                          paymentCard: item as PaymentCard,
                          mainCard: main,
                          select: selectCard,
                          delete: deleteCard
                        ); 
                      }
                    })
                  ),
                  SquaredTextButton("SALVAR ALTERAÇÕES", save, background: Colors.white, foreground: Style.highlightColor),
                  const SizedBox(height: 15),
                  SquaredTextButton("ADICIONAR ${isAddress ? 'ENDEREÇO' : 'CARTÃO'}", () => create(isAddress)),
                  const SizedBox(height: 15)
                ]
              )
            )
          )
        )
      ]
    );
  }
}