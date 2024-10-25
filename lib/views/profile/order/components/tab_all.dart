import 'package:flutter/material.dart';

import '../../../../core/utils/formate_date.dart';
import '../../../../services/store/cart_store.dart'; 
import '../../../../core/routes/app_routes.dart';
import 'order_preview_tile.dart';

class AllTab extends StatefulWidget {
  const AllTab({
    super.key,
  });

  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  List<dynamic> orders = []; // Inicializar como uma lista vazia
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrders(); // Chama a função para buscar os pedidos ao iniciar
  }

  Future<void> _fetchOrders() async {
    try {
      // Buscando pedidos com estado "confirmado" (por exemplo com state=1)
      var fetchedOrders = await CartStore.getOrdersOfUserByState();
      setState(() {
        orders = fetchedOrders; // Usa a lista de pedidos retornada pela API
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching orders: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator()); // Mostra carregamento enquanto busca dados
    }

    if (orders.isEmpty) {
      return const Center(child: Text('Nenhum pedido encontrado.')); // Caso não haja pedidos
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderPreviewTile(
          orderID: order['reference'], // Usa o ID da ordem como referência
          date: formatDate(order['createdAt']), // Formata a data do pedido
          status:OrderStatusExtension.fromInt(order['state']) , // Exibe o estado do pedido
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.orderDetails,
            arguments: order['_id']
          ),
        );
      },
    );
  }
}
