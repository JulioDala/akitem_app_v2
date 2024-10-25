import 'dart:convert';
import 'package:http/http.dart' as http;

class BrandStore {
  static const baseUrl = "https://api.akitem.ao/api/v1/";

  static Future<List<dynamic>> getBrands() async {
    var url = Uri.parse("${baseUrl}brand");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var jsonResponse = jsonDecode(res.body);
        List<dynamic> brand = jsonResponse['data']['data'];
        print(brand);
        return brand;
      } else {
        print("Failed to get response");
        return [];
      }
    } catch (e) {
      // print("Error: $e");
      return [];
    }
  }

  static Future<Map<String, dynamic>> getBrandById(String id) async {
    var url = Uri.parse("${baseUrl}brand/$id");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Map<String, dynamic> brand = jsonResponse['data'];
        print(brand);
        return brand; 
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
