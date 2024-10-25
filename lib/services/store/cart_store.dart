import 'dart:convert';
import 'package:akitem/core/models/product_in_cart_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CartStore {
  static const baseUrl = "https://api.akitem.ao/api/v1/";
  static const storage = FlutterSecureStorage();
  static Future<List<dynamic>> getOrdersOfUserByState({int? state}) async {
    var url = Uri.parse("${baseUrl}cart/get/all/user?state=$state");
    try {
      String? token = await storage.read(key: 'token');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> ordersOfUsers = jsonResponse['data']['data'];
        return ordersOfUsers; // Converte para o seu modelo usando a propriedade 'data'
      } else {
        print("Failed to get response");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  static Future<dynamic> placeOrder({
    String? paymentTypeId,
    String? deliveryMethodId,
    double? totalPrice,
    List<CartItem>? cartItems,
    int? quantity,
  }) async {
    try {
      String? token = await storage.read(key: 'token');
      var url = Uri.parse("${baseUrl}cart");

      List<Map<String, dynamic>> products = cartItems?.map((item) {
            return {
              'productId': item.product.id, // id do produto
              'quantity': item.quantity, // quantidade
              'name': item.product.name, // nome
              'description': item.product
                  .description, // descrição fixa (pode ser obtida se disponível)
              'price': item.product.price, // preço
              'images': item.product.imageUrl, // URL da imagem
            };
          }).toList() ??
          [];

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'paymentType': paymentTypeId,
          'deliverymethod': deliveryMethodId,
          'totalPrice': totalPrice,
          'products': products,
          'quantity': quantity,
        }),
      );
      final responseBody = jsonDecode(response.body);

      if (responseBody['metadata'] != null &&
          responseBody['metadata']['status'] == 201) {
        return responseBody;
      } else {
        throw Exception(
            'Erro ao realizar encomenda: ${responseBody['message']}');
      }
    } catch (error) {
      print('Erro ao realizar encomenda: $error');
      rethrow;
    }
  }

  static Future<dynamic> getOrdersOfUserById({String? id}) async {
    var url = Uri.parse("${baseUrl}cart/$id");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> ordersOfUsers = jsonResponse['data']['data'];

        if (ordersOfUsers.isNotEmpty) {
          print(ordersOfUsers[0]);
          return ordersOfUsers[0]; // Retorna apenas o primeiro objeto do array
        } else {
          return null; // Caso o array esteja vazio
        }
      } else {
        print("Failed to get response");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
