import 'package:flutter/material.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_bottom_navigation_bar.dart';
import 'components/menu_item.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(),
        body: TabBarView(
          children: [
            MenuContent(), // Exibe o conteúdo do menu
            Center(child: Text('Conteúdo de Serviços em desenvolvimento')), // Aba de serviços
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}

class MenuContent extends StatelessWidget {
  const MenuContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MenuItem(
          title: 'Eletrodomésticos',
          onTap: () {
            // Ação ao clicar no item de menu
          },
        ),
        MenuItem(
          title: 'Telemóveis e Smartwatches',
          onTap: () {
            // Ação ao clicar no item de menu
          },
        ),
        MenuItem(
          title: 'Informática',
          onTap: () {
            // Ação ao clicar no item de menu
          },
        ),
        MenuItem(
          title: 'TV e Som',
          onTap: () {
            // Ação ao clicar no item de menu
          },
        ),
        MenuItem(
          title: 'Gaming',
          isHighlighted: true, // Item destacado
          onTap: () {
            // Ação ao clicar no item de menu
          },
        ),
        MenuItem(
          title: 'Jogos e Brinquedos',
          onTap: () {
            // Ação ao clicar no item de menu
          },
        ),
        MenuItem(
          title: 'Fotografia, Drones e Vídeo',
          onTap: () {
            // Ação ao clicar no item de menu
          },
        ),
        MenuItem(
          title: 'Beleza e Saúde',
          onTap: () {
            // Ação ao clicar no item de menu
          },
        ),
        MenuItem(
          title: 'Bricolage',
          onTap: () {
            // Ação ao clicar no item de menu
          },
        ),
        MenuItem(
          title: 'Ferramenta',
          onTap: () {
            // Ação ao clicar no item de menu
          },
        ),
      ],
    );
  }
}
