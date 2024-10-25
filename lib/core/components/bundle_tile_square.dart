import 'package:flutter/material.dart';

import '../constants/constants.dart';
// import '../models/dummy_bundle_model.dart';
import '../routes/app_routes.dart';
import 'network_image.dart';

class BundleTileSquare extends StatelessWidget {
  const BundleTileSquare({
    super.key,
    required this.data,
  });

  final dynamic data; // Modificado para aceitar dados dinâmicos da API

  @override
  Widget build(BuildContext context) {
    // Extraindo os campos do produto diretamente dos dados recebidos da API
    String name = data['name'] ?? 'Produto sem nome';
    double price = data['price']?.toDouble() ?? 0.0;
    String imageUrl = data['images'] != null && data['images'].isNotEmpty
        ? data['images'][0]
        : 'https://via.placeholder.com/150'; // Placeholder se não houver imagem

    return Material(
      color: AppColors.scaffoldBackground,
      borderRadius: AppDefaults.borderRadius,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.bundleProduct);
        },
        borderRadius: AppDefaults.borderRadius,
        child: Container(
          width: 176,
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1, color: AppColors.placeholder),
            borderRadius: AppDefaults.borderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: NetworkImageWithLoader(
                    imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Adicionando uma descrição ou qualquer outra informação relevante
                  const Text(
                    'Descrição do Produto',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '\$$price',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
