import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isHighlighted;

  const MenuItem({
    super.key,
    required this.title,
    required this.onTap,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isHighlighted ? AppColors.secundary : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: isHighlighted ? Colors.white : Colors.black,
              ),
            ),
            Icon(
              Icons.play_arrow_outlined,
              color: isHighlighted ? Colors.white : AppColors.secundary,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
