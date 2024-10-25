import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:akitem/views/product/product_details_page.dart';
import '../../../core/constants/app_colors.dart';
import '../../../services/api.dart';
import '../../../core/models/product_in_cart_model.dart';
import '../../cart/provider/cart_provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  Widget _buildRating(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Colors.amber, size: 12);
        } else if (index < rating) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 12);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 12);
        }
      }),
    );
  }

  void _addToCart(BuildContext context, Map<String, dynamic> productData) {
    final product = ProductInCart(
      id: productData['_id'] ?? '',
      name: productData['name'] ?? '',
      price: double.tryParse(productData['price'].toString()) ?? 0,
      quantity: 1,
      imageUrl: productData['images'][0] ?? '',
    );

    Provider.of<CartProvider>(context, listen: false).addItem(product);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produto adicionado ao carrinho!')),
    );
  }

  Widget _buildProductCard(
      BuildContext context, Map<String, dynamic> productData) {
    int productRating = productData['averageStars'] ?? 0;
    String productName = productData['name'];
    String productPrice = '${productData['price']} Kz';
    String productImage = productData['images'][0];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              productId: productData['_id'],
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(productImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      productPrice,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    _buildRating(productRating),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.shopping_cart,
                              color: Colors.red, size: 22),
                          onPressed: () => _addToCart(context, productData),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.favorite_border, size: 22),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ... rest of the class remains the same ...

  Widget _buildSkeletonProductCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.grey[300],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 13,
                    width: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 12,
                    width: 50,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(5, (index) {
                      return const Icon(Icons.star_border,
                          color: Colors.grey, size: 12);
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        color: Colors.grey[300],
                      ),
                      Container(
                        width: 22,
                        height: 22,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FutureBuilder<List<dynamic>>(
        future: Api.fetchFilteredProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return _buildSkeletonProductCard();
              },
              itemCount: 6,
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar os produtos"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum produto encontrado"));
          }

          var products = snapshot.data!;

          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return _buildProductCard(context, products[index]);
            },
            itemCount: products.length,
          );
        },
      ),
    );
  }
}
