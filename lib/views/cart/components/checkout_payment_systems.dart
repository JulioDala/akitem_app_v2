import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import 'checkout_payment_card_tile.dart';

class PaymentSystem extends StatefulWidget {
  final String titleOfSection;
  final List<Map<String, dynamic>>
      paymentMethods; // Lista de métodos de pagamento a ser passada para reutilização
  final Function(String) onSelected;

  const PaymentSystem({
    super.key,
    required this.titleOfSection,
    required this.paymentMethods,
    required this.onSelected,
  });

  @override
  _PaymentSystemState createState() => _PaymentSystemState();
}

class _PaymentSystemState extends State<PaymentSystem> {
  String selectedMethod =
      ''; // Variável que guarda o método de pagamento selecionado

  // Função para selecionar um método de pagamento
  void selectMethod(String methodId) {
    setState(() {
      selectedMethod = methodId;
      print(selectedMethod);
    });
       widget.onSelected(methodId); 
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
            vertical: AppDefaults.padding / 2,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.titleOfSection,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black),
            ),
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.paymentMethods.map((method) {
              return PaymentCardTile(
                label: method['label'], // Rótulo do método
                icon: method['icon'], // Ícone do método
                isSelected: selectedMethod ==
                    method['id'], // Verifica se está selecionado
                onSelect: () => selectMethod(
                    method['id']), // Define como método selecionado
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
