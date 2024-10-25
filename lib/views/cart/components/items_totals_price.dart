import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/components/dotted_divider.dart';
import '../../../core/constants/constants.dart';
import 'item_row.dart';
import '../provider/cart_provider.dart';

class ItemTotalsAndPrice extends StatelessWidget {
  const ItemTotalsAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    // Calcula o total de itens e o preço total
    final totalItems = cartProvider.itemCount; // Número total de itens no carrinho
    final totalPrice = cartProvider.totalAmount; // Preço total dos itens no carrinho

    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        children: [
          ItemRow(
            title: 'Total de itens no carrinho',
            value: '$totalItems', // Exibe a contagem total de itens
          ),
          const DottedDivider(),
          ItemRow(
            title: 'Preço Total',
            value: '\$${totalPrice.toStringAsFixed(2)}', // Exibe o preço total formatado
          ),
        ],
      ),
    );
  }
}
