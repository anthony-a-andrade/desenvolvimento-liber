import 'package:flutter/material.dart';
import 'package:liber/model/address.dart';
import 'package:liber/model/payment_card.dart';
import 'package:liber/services/user/address_service.dart' as address_service;
import 'package:liber/services/user/card_service.dart' as card_service;
import 'package:liber/views/home.dart';
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
  int? mainIndex;
  late List<Address?> addresses;
  late List<PaymentCard?> cards;
  
  selectAddress(int index) async {
    var old = addresses.where((a) => a!.main);
    if (old.isNotEmpty) {
      var first = old.first!;
      first.main = false;
      await address_service.save(widget.userEmail, first, true);
    }

    addresses[index]!.main = true;
    await address_service.save(widget.userEmail, addresses[index]!, true);
    
    setState(() => mainIndex = index);
  }

  selectCard(int index) async {
    var old = cards.where((a) => a!.main);
    if (old.isNotEmpty) {
      var first = old.first!;
      first.main = false;
      await card_service.save(widget.userEmail, first, true);
    }

    cards[index]!.main = true;
    await card_service.save(widget.userEmail, cards[index]!, true);
    
    setState(() => mainIndex = index);
  }

  deleteAddress(int index) async {
    if (addresses.length == 1) { Snackbar.show(context, "É necessário ao menos um endereço!"); } 
    else {
      var address = addresses[index];
      var status = true;

      if (address!.id != "") status = await address_service.delete(address.id);
      if (status) setState(() => addresses.removeAt(index));
    }
  }

  deleteCard(int index) async {
    var card = cards[index];
    var status = true;
    
    if (card!.id != "") status = await card_service.delete(card.id);
    if (status) setState(() => cards.removeAt(index));
  }

  saveAddress(Address address) async => await address_service.save(widget.userEmail, address, true);
  saveCard(PaymentCard card) async => await card_service.save(widget.userEmail, card, true);
  
  create() async {
    if (widget.editAddresses) { 
      await address_service.save(widget.userEmail, Address.empty(main: addresses.isEmpty), false);
    } else if (widget.editCards) { 
      await card_service.save(widget.userEmail, PaymentCard.empty(main: cards.isEmpty), false);
    }

    setState(() { });
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.editAddresses ? address_service.getAll(widget.userEmail) : card_service.getAll(widget.userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data!;
          var list = widget.editAddresses ? Address.fromJsonList(data) : PaymentCard.fromJsonList(data);
          list.sort((dynamic a, b) => a.main ? 0 : 1);

          if (widget.editAddresses) { addresses = list as List<Address?>; mainIndex = addresses.indexWhere((e) => e!.main); }
          else { cards = list as List<PaymentCard?>; mainIndex = cards.indexWhere((e) => e!.main); }

          mainIndex ??= 0;

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
                                save: saveCard
                              ); 
                            }
                          })
                        ),
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