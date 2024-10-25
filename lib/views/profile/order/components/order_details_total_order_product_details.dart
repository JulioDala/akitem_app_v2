import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import 'order_details_product_tile.dart';

class TotalOrderProductDetails extends StatelessWidget {
  final List<dynamic> productsInfo; // Recebe a lista de produtos
final List<dynamic> productImage;
  const TotalOrderProductDetails({
    super.key,
    required this.productsInfo, required this.productImage, // Define como obrigatório
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Detalhes dos produtos',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          ListView.separated(
            itemBuilder: (context, index) {
              return OrderDetailsProductTile(data: productsInfo[index], image: productImage[index],); // Usa os dados corretos
            },
            separatorBuilder: (context, index) => const Divider(
              thickness: 0.2,
            ),
            itemCount: productsInfo.length, // Define a quantidade correta de produtos
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}
