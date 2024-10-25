import 'package:akitem/core/components/custom_bottom_navigation_bar.dart';
import 'package:akitem/views/home/components/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:akitem/views/shop/components/custom_app_bar.dart';
import 'package:akitem/views/shop/components/express_switch.dart';
import 'package:akitem/views/shop/components/filters_row.dart';
import 'package:akitem/views/shop/components/category_items.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool entregasExpress = false;
  bool vendidoPorWorten = false;
  final PageController _pageController = PageController(viewportFraction: 0.93);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpressSwitch(
              value: entregasExpress,
              onChanged: (value) => setState(() {
                entregasExpress = value;
              }),
            ),
            const Divider(height: 1),
            FiltersRow(
              vendidoPorWorten: vendidoPorWorten,
              onSwitchChanged: (value) => setState(() {
                vendidoPorWorten = value;
              }),
            ),
            const ProductGrid(),
            const CategoryItems(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
