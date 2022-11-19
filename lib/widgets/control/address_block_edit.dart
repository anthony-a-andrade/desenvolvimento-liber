import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/model/address.dart';
import 'package:liber/widgets/input/rounded_text_field.dart';
import 'package:liber/widgets/input/squared_text_button.dart';

class AddressBlockEdit extends StatefulWidget {
  final int index;
  final int? selectedAddress;
  final Address address;
  final void Function(int index) select;
  final void Function(int index) delete;
  final void Function(Address address) save;

  const AddressBlockEdit({
    required this.index,
    required this.selectedAddress, 
    required this.address, 
    required this.select, 
    required this.delete,
    required this.save,
    super.key
  });

  @override
  State<AddressBlockEdit> createState() => _AddressBlockEditState();
}

class _AddressBlockEditState extends State<AddressBlockEdit> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  save() {
    var address = Address.build(
      id: widget.address.id,
      name: nomeController.text, 
      cep: cepController.text, 
      road: ruaController.text, 
      city: cidadeController.text, 
      state: estadoController.text, 
      number: numeroController.text, 
      complement: "", 
      main: widget.index == widget.selectedAddress
    );
    widget.save(address);
  }

  @override
  Widget build(BuildContext context) {    
    nomeController.addListener(() => widget.address.name = nomeController.text);
    cepController.addListener(() => widget.address.cep = cepController.text);
    ruaController.addListener(() => widget.address.road = ruaController.text);
    cidadeController.addListener(() => widget.address.city = cidadeController.text);
    numeroController.addListener(() => widget.address.number = numeroController.text);
    estadoController.addListener(() => widget.address.state = estadoController.text);

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
                Text("Endereço ${widget.index + 1}", style: Font.size(18).bold()),
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
                Expanded(child: RoundedTextField(widget.address.name, "Nome", nomeController)),
                const SizedBox(width: 15),
                const Text("Principal: "),
                Radio<int>(
                  value: widget.index, 
                  groupValue: widget.selectedAddress, 
                  onChanged: (index) => widget.select(widget.index)
                )
              ]
            ),
            RoundedTextField(widget.address.cep, "CEP", cepController),
            RoundedTextField(widget.address.road, "Rua", ruaController),
            RoundedTextField(widget.address.city, "Cidade", cidadeController),
            Row(
              children: [
                Expanded(child: RoundedTextField(widget.address.number, "Número", numeroController)),
                const SizedBox(width: 15),
                Expanded(child: RoundedTextField(widget.address.state, "Estado", estadoController))
              ]
            ),
            SquaredTextButton("SALVAR ALTERAÇÕES", save, background: Colors.white, foreground: Style.highlightColor)
          ]
        )
      )
    );
  }
}