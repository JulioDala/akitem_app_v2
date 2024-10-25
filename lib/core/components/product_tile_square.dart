import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../routes/app_routes.dart';
import 'network_image.dart';

class ProductTileSquare extends StatelessWidget {
  const ProductTileSquare({
    super.key,
    required this.data,
  });

  // O tipo do data contém os detalhes do produto, incluindo o ID
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding / 2),
      child: Material(
        borderRadius: AppDefaults.borderRadius,
        color: AppColors.scaffoldBackground,
        child: InkWell(
          borderRadius: AppDefaults.borderRadius,
          onTap: () {
            // Agora passando o ID do produto ao navegar para a página de detalhes
            Navigator.pushNamed(
              context, 
              AppRoutes.productDetailsWithId,
              arguments: data['_id'],  // Passando o ID do produto
            );
          },
          child: Container(
            width: 176,
            height: 296,
            padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: AppColors.placeholder),
              borderRadius: AppDefaults.borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding / 2),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: NetworkImageWithLoader(
                      data['images'][0], // Pegando a imagem do produto da API
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // const SizedBox(height: 8),
                Text(
                  data['name'], // Nome do produto
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // const Spacer(),
                // Text(
                //   '${data['quantity']} em stock', // Quantidade do produto
                // ),
                // const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${data['price'].toInt()} Kz', // Preço do produto
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(width: 8),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
