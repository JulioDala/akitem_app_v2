import 'package:flutter/material.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
