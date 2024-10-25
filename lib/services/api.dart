import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "https://api.akitem.ao/api/v1/";
  static Future<List<dynamic>> getProducts() async {
    var url = Uri.parse("${baseUrl}product");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var jsonResponse = jsonDecode(res.body);
        List<dynamic> products = jsonResponse['data']['data'];

        // print(products);
        return products;
      } else {
        // print("Failed to get response");
        return [];
      }
    } catch (e) {
      // print("Error: $e");
      return [];
    }
  }

  static Future<Map<String, dynamic>> getProductById(String id) async {
    var url = Uri.parse("${baseUrl}product/$id");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Map<String, dynamic> product = jsonResponse['data'];
        // print(product);
        return product; // Converte para o seu modelo usando a propriedade 'data'
      } else {
        // print("Failed to get response");
        return {};
      }
    } catch (e) {
      // print("Error: $e");
      return {};
    }
  }

  static Future<String> testConnection() async {
    var url = Uri.parse(baseUrl); // Rota que retorna a mensagem de sucesso

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        return data['message'] ?? 'Falha ao obter a mensagem';
      } else {
        return "Falha ao conectar com a API: ${res.statusCode}";
      }
    } catch (e) {
      return "Erro: $e";
    }
  }

  static Future<List<dynamic>> fetchFilteredProducts({
    int? page,
    int? size,
    int? sort,
    int? min,
    int? max,
    List<String>? category,
    List<String>? subcategories,
    List<String>? brand,
    String? name,
    List<String>? sizes,
    String? color,
    List<int>? stars,
  }) async {
    String url = "${baseUrl}product/search/filter?size=${size ?? 10}&page=${page ?? 1}";

    if (min != null) url += "&min=$min";
    if (max != null) url += "&max=$max";
    if (sort != null && sort != 0) url += "&sort=$sort";

    if (category != null && category.isNotEmpty) {
      for (var cat in category) {
        url += "&category=$cat";
      }
    }

    if (subcategories != null && subcategories.isNotEmpty) {
      for (var subcategory in subcategories) {
        url += "&subcategory=$subcategory";
      }
    }

    if (brand != null && brand.isNotEmpty) {
      for (var brands in brand) {
        url += "&brand=$brands";
      }
    }

    if (name != null) {
      url += "&name=$name";
    }

    if (sizes != null && sizes.isNotEmpty) {
      for (var size in sizes) {
        url += "&sizes=$size";
      }
    }

    if (color != null && color.isNotEmpty) {
      url += "&color=$color";
    }

    if (stars != null && stars.isNotEmpty) {
      for (var star in stars) {
        url += "&stars=$star";
      }
    }

    try {
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        var jsonResponse = jsonDecode(res.body);
        List<dynamic> products = jsonResponse['data']['data'];
        return products;
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}

class TestApiConnectionPage extends StatelessWidget {
  const TestApiConnectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testar Conexão e Obter Produtos'),
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: Api.getProducts(), // Chama o método getProducts
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Exibe um indicador de carregamento enquanto espera a resposta
            } else if (snapshot.hasError) {
              return Text("Erro: ${snapshot.error}"); // Exibe erros, se houver
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text(
                  'Nenhum produto encontrado.'); // Exibe uma mensagem se não houver dados
            }

            // Se a conexão for bem-sucedida e houver dados, exibe os produtos
            List<dynamic> products = snapshot.data!;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                // Acessa os detalhes de cada produto
                var product = products[index];
                return ListTile(
                  title: Text(product['name'] ?? 'Sem nome'), // Nome do produto
                  subtitle:
                      Text('Preço: ${product['price']}'), // Preço do produto
                );
              },
            );
          },
        ),
      ),
    );
  }
}
