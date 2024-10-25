import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryStore {
  static const baseUrl = "https://api.akitem.ao/api/v1/";

  static Future<List<dynamic>> getCategorys() async {
    var url = Uri.parse("${baseUrl}category");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var jsonResponse = jsonDecode(res.body);
        List<dynamic> products = jsonResponse['data']['data'];
        print(products);
        return products;
      } else {
        print("Failed to get response");
        return [];
      }
    } catch (e) {
       print("Error: $e");
      return [];
    }
  }

  static Future<Map<String, dynamic>> getCategoryById(String id) async {
    var url = Uri.parse("${baseUrl}category/$id");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Map<String, dynamic> product = jsonResponse['data'];
        print(product);
        return product; // Converte para o seu modelo usando a propriedade 'data'
      } else {
        print("Failed to get response");
        return {};
      }
    } catch (e) {
      print("Error: $e");
      return {};
    }
  }
}
