import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/main.dart';
import 'package:liber/model/address.dart';
import 'package:liber/model/payment_card.dart';
import 'package:liber/services/user/address_service.dart';
import 'package:liber/services/user/card_service.dart';
import 'package:liber/views/subviews/edit_account.dart';
import 'package:liber/widgets/control/address_block_edit.dart';
import 'package:liber/widgets/control/payment_card_block_edit.dart';
import 'package:liber/widgets/control/search_expand_menu_bar.dart';
import 'package:liber/widgets/info/snackbar.dart';
import 'package:liber/widgets/input/squared_text_button.dart';

class EditAccountDetails extends StatefulWidget {
  final String userEmail;
  final bool editAddresses;
  final bool editCards;
  const EditAccountDetails(this.userEmail, {this.editAddresses = false, this.editCards = false, super.key});

  @override
  State<EditAccountDetails> createState() => _EditAccountDetailsState();
}

class _EditAccountDetailsState extends State<EditAccountDetails> {
  late int mainIndex;
  List<Address>? addresses;
  List<PaymentCard>? cards;
  bool createCall = false;

  selectAddress(int index) {
    setState(() {
      var old = addresses!.where((a) => a.main);
      if (old.isNotEmpty) old.first.main = false;

      addresses![index].main = true;
      mainIndex = index;
    });
  }

  selectCard(int index) {
    setState(() {
      var old = cards!.where((a) => a.main);
      if (old.isNotEmpty) old.first.main = false;

      cards![index].main = true;
      mainIndex = index;
    });
  }

  deleteAddress(int index) async {
    if (addresses!.length == 1) { Snackbar.show(context, "É necessário ao menos um endereço!"); } 
    else {
      var address = addresses![index];
      var status = true;

      if (address.id != "") status = await AddressService.delete(address.id);
      if (status) setState(() => addresses!.removeAt(index));
    }
  }

  deleteCard(int index) async {
    var card = cards![index];
    var status = true;
    
    if (card.id != "") status = await CardService.delete(card.id);
    if (status) setState(() => cards!.removeAt(index));
  }

  saveAddress(Address address) async => await AddressService.save(widget.userEmail, address);
  
  create() => setState(() => createCall = true);
  getItems() async {
    if (widget.editAddresses) {
      addresses = await AddressService.getAll(widget.userEmail);
      print(addresses);
      if (createCall) addresses!.add(Address.empty());
      mainIndex = addresses!.indexWhere((i) => i.main);
      return addresses!;
    }

    if (widget.editCards) {
      cards = await CardService.getAll(widget.userEmail);
      print(cards);
      if (createCall) cards!.add(PaymentCard.empty());
      mainIndex = cards!.indexWhere((i) => i.main);
      return cards!;
    }

    createCall = false;
    return [];
  }

  TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getItems(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var list = widget.editAddresses ? addresses! : cards!;

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
                          children: list.isEmpty ? [] : List<Widget>.generate(list.length, (index) {
                            var item = list[index];
                            if (widget.editAddresses) {
                              return AddressBlockEdit(
                                index: index,
                                address: item as Address, 
                                selectedAddress: mainIndex, 
                                select: selectAddress,
                                delete: deleteAddress,
                                save: saveAddress
                              ); 
                            } 
                            else { 
                              return PaymentCardBlockEdit(
                                index: index,
                                paymentCard: item as PaymentCard,
                                selectedCard: mainIndex,
                                select: selectCard,
                                delete: deleteCard,
                                // save: saveCard
                              ); 
                            }
                          })
                        ),
                        // SquaredTextButton("SALVAR ALTERAÇÕES", save, background: Colors.white, foreground: Style.highlightColor),
                        const SizedBox(height: 15),
                        SquaredTextButton("ADICIONAR ${widget.editAddresses ? 'ENDEREÇO' : 'CARTÃO'}", () => create()),
                        const SizedBox(height: 15)
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
      },
    );
  }
}