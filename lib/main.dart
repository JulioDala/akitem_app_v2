import 'package:akitem/views/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/home/home_page.dart';
import 'views/menu/menu_page.dart';
import 'views/profile/profile_page.dart';
import 'views/promotion/promotion_page.dart';
import 'views/shop/shop_page.dart';
import 'views/product/product_details_page.dart';
import 'views/cart/provider/cart_provider.dart'; // Adicione este import

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Akitem',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'TT Rounds',
      ),
      home: const HomePage(),
      routes: {
        '/menu': (context) => const MenuPage(),
        '/perfil': (context) => const ProfilePage(),
        '/promocoes': (context) => const PromocoesDestaquesPage(),
        '/loja': (context) => const ShopPage(),
        '/carrinho': (context) => const CartPage(),
        '/produto': (context) => const ProductDetailsPage(
              productId: '', // Este valor será sobrescrito pela navegação
            ),
      },
    );
  }
}
