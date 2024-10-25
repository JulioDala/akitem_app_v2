import 'package:flutter/material.dart';

import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_bottom_navigation_bar.dart';
import 'components/banner_carousel.dart';
import 'components/navigation_icons.dart';
import 'components/product_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(),
        body: TabBarView(
          children: [
            HomeContent(),
            Center(child: Text('Conteúdo de Serviços em desenvolvimento')),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          NavigationIcons(),
          BannerCarousel(),
          ProductGrid(),
        ],
      ),
    );
  }
}
