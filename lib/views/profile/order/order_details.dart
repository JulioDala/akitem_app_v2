import 'package:flutter/material.dart';
import '../../../core/components/app_back_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_defaults.dart';
import '../../../services/store/cart_store.dart';
import 'components/order_details_statuses.dart';
import 'components/order_details_total_amount_and_paid.dart';
import 'components/order_details_total_order_product_details.dart';

class OrderDetailsPage extends StatefulWidget {
  final String orderId;
  const OrderDetailsPage({super.key, required this.orderId});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  dynamic orderData; // Alterado para armazenar um único objeto
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrderDetails();
  }

  Future<void> fetchOrderDetails() async {
    try {
      final data = await CartStore.getOrdersOfUserById(id: widget.orderId);
      setState(() {
        orderData = data; // Recebe o único objeto
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching order details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Detalhes da encomenda'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: orderData != null
                  ? Container(
                      margin: const EdgeInsets.all(AppDefaults.margin),
                      padding: const EdgeInsets.all(AppDefaults.padding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppDefaults.borderRadius,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Referência #${orderData['reference']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                          const SizedBox(height: AppDefaults.padding),
                          const OrderStatusColumn(),
                          TotalOrderProductDetails(
                            productsInfo: orderData['products'],
                             productImage: orderData['productsInfo'],
                          ),
                          TotalAmountAndPaidData(totalPrice: orderData['totalPrice']),
                        ],
                      ),
                    )
                  : const Center(
                      child: Text('Encomenda não encontrada'),
                    ),
            ),
    );
  }
}
