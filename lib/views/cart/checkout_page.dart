// import 'dart:convert';
// import 'package:akitem/services/store/cart_store.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:provider/provider.dart';
// import '../../core/constants/constants.dart';
// import 'provider/cart_provider.dart';
// import '../../core/components/app_back_button.dart';

// import '../../core/routes/app_routes.dart';
// import 'components/checkout_address_selector.dart';
// import 'components/single_cart_item_tile.dart';
// import 'components/checkout_payment_systems.dart';

// class CheckoutPage extends StatefulWidget {
//   const CheckoutPage({super.key});

//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   String? selectedPaymentMethod;
//   String? selectedDeliveryMethod;
//   final _phoneController = TextEditingController();
//   final _addressController = TextEditingController();
//   final FlutterSecureStorage _storage = const FlutterSecureStorage(); // Armazenamento seguro

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }

//   // Função para buscar os dados do usuário do armazenamento seguro
//   Future<String?> _getUserId() async {
//     final userDataString = await _storage.read(key: 'user');
//     if (userDataString != null) {
//       final userData = jsonDecode(userDataString);
//       return userData['_id']; // A chave deve corresponder ao campo de ID do usuário
//     }
//     return null;
//   }

//   Future<void> finalizeEncomenda(BuildContext context) async {
//     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//     final cartItems = cartProvider.items.values.toList();
//     final totalPrice = cartProvider.totalAmount;

//     if (selectedPaymentMethod == null || selectedDeliveryMethod == null) {
//       _showErrorDialog("Escolha o método de pagamento e entrega.");
//       return;
//     }

//     try {
//       // Obtém o userId do armazenamento seguro
//       final userId = await _getUserId();
//       if (userId == null) {
//         _showErrorDialog("Erro ao obter ID do usuário.");
//         return;
//       }

//       // Simulação de chamada para API para processar a encomenda
//       final orderResponse = await CartStore.placeOrder(
//         paymentTypeId: selectedPaymentMethod!,
//         deliveryMethodId: selectedDeliveryMethod!,
//         totalPrice: totalPrice,
//         cartItems: cartItems
//       );

//         if (orderResponse['metadata'] != null && orderResponse['metadata']['status'] == 201) {
//         _showSuccessDialog("A sua encomenda foi feita com sucesso!");
//         // ignore: use_build_context_synchronously
//         Navigator.pushNamed(context, AppRoutes.myOrder);
//       } else {
//         _showErrorDialog("Erro ao finalizar encomenda.");
//       }
//     } catch (error) {
//       _showErrorDialog("Erro ao processar a encomenda. Tente novamente.");
//       print("esse é o erro $error" );
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text("Erro"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             child: const Text("Ok"),
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void _showSuccessDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text("Sucesso"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             child: const Text("Ok"),
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> paymentMethods = [
//       {
//         'id': '6622ebc25f9a21a0ea351e9a',
//         'label': 'Transferência',
//         'icon': AppIcons.masterCard,
//       },
//       {
//         'id': '6622ebeb5f9a21a0ea351e9e',
//         'label': 'Express',
//         'icon': AppIcons.paypal,
//       },
//       {
//         'id': '6622ebd15f9a21a0ea351e9c',
//         'label': 'TPA',
//         'icon': AppIcons.cashOnDelivery,
//       },
//     ];

//     final List<Map<String, dynamic>> deliveryMethods = [
//       {
//         'id': '6622ecde052d9cc02f50fafc',
//         'label': 'Normal',
//         'icon': AppIcons.dashboardIcon,
//       },
//       {
//         'id': '6622ecf0052d9cc02f50fafe',
//         'label': 'Expres',
//         'icon': AppIcons.voucher,
//       },
//       {
//         'id': '6622ecfc052d9cc02f50fb00',
//         'label': 'Na Loja',
//         'icon': AppIcons.cashOnDelivery,
//       },
//     ];
//     final cartProvider = Provider.of<CartProvider>(context);
//     final cartItems = cartProvider.items.values.toList();
//     return Scaffold(
//       appBar: AppBar(
//         leading: const AppBackButton(),
//         title: const Text('Finalizar encomenda'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const AddressSelector(),
//             PaymentSystem(
//               titleOfSection: "Método de pagamento",
//               paymentMethods: paymentMethods,
//               onSelected: (value) {
//                 setState(() {
//                   selectedPaymentMethod = value;
//                 });
//               },
//             ),
//             PaymentSystem(
//               titleOfSection: "Método de entrega",
//               paymentMethods: deliveryMethods,
//               onSelected: (value) {
//                 setState(() {
//                   selectedDeliveryMethod = value;
//                 });
//               },
//             ),
//             Column(
//               children: [
//                 ...cartItems.map((item) => SingleCartItemTile(
//                       product: item.product,
//                       quantity: item.quantity,
//                       showDecrement: false,
//                       showIncrement: false,
//                       showRemove: false,
//                     )),
//               ],
//             ),
//             PayNowButton(onPressed: () => finalizeEncomenda(context)),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PayNowButton extends StatelessWidget {
//   final VoidCallback onPressed;

//   const PayNowButton({
//     required this.onPressed,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Padding(
//         padding: const EdgeInsets.all(AppDefaults.padding),
//         child: ElevatedButton(
//           onPressed: onPressed,
//           child: const Text('Finalizar encomenda'),
//         ),
//       ),
//     );
//   }
// }
