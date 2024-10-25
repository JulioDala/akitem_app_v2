import 'package:akitem/core/components/custom_bottom_navigation_bar.dart';
import 'package:akitem/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PromocoesDestaquesPage extends StatefulWidget {
  const PromocoesDestaquesPage({super.key});

  @override
  State<PromocoesDestaquesPage> createState() => _PromocoesDestaquesPageState();
}

class _PromocoesDestaquesPageState extends State<PromocoesDestaquesPage> {
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
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Promoções e Destaques',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Entregas Express Switch
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 32,
              child: Row(
                children: [
                  const Icon(Icons.local_shipping, size: 16),
                  const SizedBox(width: 4),
                  const Text(
                    'Entregas Express',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      value: entregasExpress,
                      onChanged: (value) {
                        setState(() {
                          entregasExpress = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Filtros Row
            Container(
              height: 32,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        const Text('Vendido por', style: TextStyle(fontSize: 11)),
                        const SizedBox(width: 4),
                        Image.asset(
                          'assets/images/app_icon.png',
                          width: 16,
                          height: 16,
                        ),
                        const Spacer(),
                        Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            value: vendidoPorWorten,
                            onChanged: (value) {
                              setState(() {
                                vendidoPorWorten = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, color: Colors.grey),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.swap_vert, size: 16),
                    label: const Text('ORDENAR', style: TextStyle(fontSize: 11)),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                  Container(width: 1, color: Colors.grey),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.tune, size: 16),
                    label: const Text('FILTRAR', style: TextStyle(fontSize: 11)),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ],
              ),
            ),

            // Carrossel de Promoções usando PageView
            SizedBox(
              height: 400, // Aumentei a altura do container
              child: PageView(
                controller: _pageController,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8), // Ajustei o padding
                    child: _buildPromotionCard(
                      image: 'assets/images/product7.webp',
                      title: 'PROMOÇÃO NOS PRODUTOS\nASSINALADOS DE 16 A 24 OUT',
                      discount: 'Até 50% desconto direto',
                      description: 'em Telemóveis, Portáteis, TVs,\nEletrodomésticos e muito mais',
                      buttonText: 'VER PRODUTOS',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8), // Ajustei o padding
                    child: _buildPromotionCard(
                      image: 'assets/images/product7.webp',
                      title: 'PROMOÇÃO NOS PRODUTOS\nASSINALADOS DE 16 A 24 OUT',
                      discount: 'Até 30% desconto',
                      description: 'Em Cozinhas e Móveis\nde Encastrar',
                      buttonText: 'SABER MAIS',
                      isSecondary: true,
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8), // Ajustei o padding
                    child: _buildPromotionCard(
                      image: 'assets/images/product7.webp',
                      title: 'PROMOÇÃO NOS PRODUTOS\nASSINALADOS DE 16 A 24 OUT',
                      discount: 'Até 30% desconto',
                      description: 'Em Cozinhas e Móveis\nde Encastrar',
                      buttonText: 'SABER MAIS',
                      isSecondary: true,
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8), // Ajustei o padding
                    child: _buildPromotionCard(
                      image: 'assets/images/product7.webp',
                      title: 'PROMOÇÃO NOS PRODUTOS\nASSINALADOS DE 16 A 24 OUT',
                      discount: 'Até 30% desconto',
                      description: 'Em Cozinhas e Móveis\nde Encastrar',
                      buttonText: 'SABER MAIS',
                      isSecondary: true,
                    ),
                  ),
                ],
              ),
            ),

            // Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryItem(
                    icon: 'assets/images/product7.webp',
                    label: 'Bebé,\nPuericultura',
                  ),
                  _buildCategoryItem(
                    icon: 'assets/images/product7.webp',
                    label: 'Livros, Música\ne Filmes',
                  ),
                  _buildCategoryItem(
                    icon: 'assets/images/product7.webp',
                    label: 'Escritório\ne Papelaria',
                  ),
                  _buildCategoryItem(
                    icon: 'assets/images/product7.webp',
                    label: 'Bricolage',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar()
    );
  }

  Widget _buildPromotionCard({
    required String image,
    required String title,
    required String discount,
    required String description,
    required String buttonText,
    bool isSecondary = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView( // Adicionei SingleChildScrollView aqui
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.asset(
                image,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12), // Aumentei o espaçamento
                  Text(
                    discount,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12), // Aumentei o espaçamento
                  Text(
                    description,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 20), // Aumentei o espaçamento
                  SizedBox(
                    height: 36,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: isSecondary ? Colors.black : Colors.red,
                        side: BorderSide(
                          color: isSecondary ? Colors.black : Colors.red,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                      ),
                      child: Text(buttonText, style: const TextStyle(fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem({required String icon, required String label}) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  icon,
                  width: 30,
                  height: 30,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '%',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11),
        ),
      ],
    );
  }
}