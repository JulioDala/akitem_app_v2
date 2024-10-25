import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class NavigationIcons extends StatelessWidget {
  const NavigationIcons({super.key});

  // Modificar o método para receber BuildContext como parâmetro
  Widget _buildNavItem(BuildContext context, IconData icon, String label, Color color, String routeName) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Passar context para o método _buildNavItem
          _buildNavItem(context, Icons.local_offer, 'Promoções', AppColors.secundary, '/promocoes'),
          _buildNavItem(context, Icons.favorite_border, 'Favoritos', AppColors.secundary, '/favoritos'),
          _buildNavItem(context, Icons.list, 'Blog', AppColors.secundary, '/blog'),
          _buildNavItem(context, Icons.shopping_cart, 'Compras', AppColors.secundary, '/loja'),
        ],
      ),
    );
  }
}
