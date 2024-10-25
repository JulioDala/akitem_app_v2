// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import '../../../core/components/network_image.dart';
// import '../../../core/constants/constants.dart';
// import '../../../core/models/product_in_cart_model.dart';
// import '../provider/cart_provider.dart';

// class SingleCartItemTile extends StatelessWidget {
//   final ProductInCart product;
//   final int quantity;
//   final bool showIncrement;
//   final bool showDecrement;
//   final bool showRemove;

//   const SingleCartItemTile({
//     super.key,
//     required this.product,
//     required this.quantity,
//     this.showIncrement = true, // Valor padrão é true
//     this.showDecrement = true, // Valor padrão é true
//     this.showRemove = true,    // Valor padrão é true
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context, listen: false);

//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: AppDefaults.padding,
//         vertical: AppDefaults.padding / 2,
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               /// Thumbnail
//               SizedBox(
//                 width: 70,
//                 child: AspectRatio(
//                   aspectRatio: 1 / 1,
//                   child: NetworkImageWithLoader(
//                     product.imageUrl, // Usando URL da imagem do produto
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),

//               /// Quantity and Name
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           product.name, // Nome do produto
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyLarge
//                               ?.copyWith(color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       /// Decrement Button
//                       if (showDecrement)
//                         IconButton(
//                           onPressed: () {
//                             if (quantity > 1) {
//                               cartProvider.decreaseItem(product.id); // Diminuir quantidade
//                             } else {
//                               cartProvider.removeItem(product.id); // Remover se quantidade <= 1
//                             }
//                           },
//                           icon: SvgPicture.asset(AppIcons.removeQuantity),
//                           constraints: const BoxConstraints(),
//                         ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           '$quantity', // Exibe a quantidade do item no carrinho
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyLarge
//                               ?.copyWith(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                         ),
//                       ),

//                       /// Increment Button
//                       if (showIncrement)
//                         IconButton(
//                           onPressed: () {
//                             cartProvider.addItem(product); // Aumentar quantidade
//                           },
//                           icon: SvgPicture.asset(AppIcons.addQuantity),
//                           constraints: const BoxConstraints(),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//               const Spacer(),

//               /// Price and Remove Button
//               Column(
//                 children: [
//                   if (showRemove)
//                     IconButton(
//                       constraints: const BoxConstraints(),
//                       onPressed: () {
//                         cartProvider.removeItem(product.id); // Remover item do carrinho
//                       },
//                       icon: SvgPicture.asset(AppIcons.delete),
//                     ),
//                   const SizedBox(height: 16),
//                   Text('\$${product.price}'), // Exibindo o preço do produto
//                 ],
//               ),
//             ],
//           ),
//           const Divider(thickness: 0.1),
//         ],
//       ),
//     );
//   }
// }
