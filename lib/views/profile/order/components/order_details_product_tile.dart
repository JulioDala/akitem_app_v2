import 'package:flutter/material.dart';
import '../../../../core/components/network_image.dart';

class OrderDetailsProductTile extends StatelessWidget {
  final Map<String, dynamic> data;
    final Map<String, dynamic> image;
   // Agora aceita um Map diretamente

  const OrderDetailsProductTile({
    super.key,
    required this.data, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 80,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: NetworkImageWithLoader(
              image['images'] != null && image['images'].isNotEmpty
                  ? image['images'][0]
                  : '', // Pega a primeira imagem, se disponível
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['name'] ?? 'Produto sem nome',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 8),
              // Text(
              //   data['description'] ?? 'Sem descrição',
              //   style: Theme.of(context).textTheme.bodySmall,
              // ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${(data['price'] ?? 0).toInt()} kz', // Converte o preço para inteiro
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '${data['quantity'] ?? 1}x', // Exibe a quantidade de produtos
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        )
      ],
    );
  }
}
