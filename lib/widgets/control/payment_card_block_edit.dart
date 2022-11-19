import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/model/payment_card.dart';
import 'package:liber/widgets/input/rounded_text_field.dart';
import 'package:liber/widgets/input/squared_text_button.dart';

class PaymentCardBlockEdit extends StatefulWidget {
  final int index;
  final int? selectedCard;
  final PaymentCard paymentCard;
  final void Function(int index) select;
  final void Function(int index) delete;
  final void Function(PaymentCard card) save;

  const PaymentCardBlockEdit({
    required this.index,
    required this.selectedCard,
    required this.paymentCard, 
    required this.select, 
    required this.delete,
    required this.save,
    super.key
  });

  @override
  State<PaymentCardBlockEdit> createState() => _PaymentCardBlockEditState();
}

class _PaymentCardBlockEditState extends State<PaymentCardBlockEdit> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController titularController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expiracaoController = TextEditingController();

  save() {
    var card = PaymentCard.build(
      id: widget.paymentCard.id, 
      number: numeroController.text, 
      expirationDate: expiracaoController.text, 
      cvv: cvvController.text, 
      cardholder: titularController.text, 
      cpf: cpfController.text, 
      nameCard: nomeController.text, 
      main: widget.index == widget.selectedCard
    );
    widget.save(card);
  }

  @override
  Widget build(BuildContext context) {
    nomeController.addListener(() => widget.paymentCard.nameCard = nomeController.text);
    numeroController.addListener(() => widget.paymentCard.number = numeroController.text);
    titularController.addListener(() => widget.paymentCard.cardholder = titularController.text);
    cpfController.addListener(() => widget.paymentCard.cpf = cpfController.text);
    cvvController.addListener(() => widget.paymentCard.cvv = cvvController.text);
    expiracaoController.addListener(() => widget.paymentCard.expirationDate = expiracaoController.text);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: Style.squaredShadowBorder,
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Cartão ${widget.index + 1}", style: Font.size(18).bold()),
                Expanded(child: Container()),
                TextButton(
                  onPressed: () => widget.delete(widget.index), 
                  style: ButtonStyle(alignment: Alignment.centerRight, padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero)),
                  child: const Icon(Icons.delete_outline_sharp, color: Colors.red)
                )
              ]
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: RoundedTextField(widget.paymentCard.nameCard, "Nome", nomeController)),
                const SizedBox(width: 15),
                const Text("Principal: "),
                Radio<int>(
                  value: widget.index, 
                  groupValue: widget.selectedCard, 
                  onChanged: (index) => widget.select(widget.index)
                )
              ]
            ),
            RoundedTextField(widget.paymentCard.number, "Número", numeroController),
            RoundedTextField(widget.paymentCard.cardholder, "Titular", titularController),
            RoundedTextField(widget.paymentCard.cpf, "CPF", cpfController),
            Row(
              children: [
                Expanded(child: RoundedTextField(widget.paymentCard.cvv, "CVV", cvvController)),
                const SizedBox(width: 15),
                Expanded(flex: 2, child: RoundedTextField(widget.paymentCard.expirationDate, "Data de Expiração", expiracaoController))
              ]
            ),
            SquaredTextButton("SALVAR ALTERAÇÕES", save, background: Colors.white, foreground: Style.highlightColor)
          ]
        )
      )
    );
  }
}