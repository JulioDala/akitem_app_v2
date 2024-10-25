import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.onTap,
    required this.icon, // Agora este deve ser o nome do ícone no formato de string
    required this.title,
  });

  final void Function() onTap;
  final IconData icon; // Mudei o tipo de icon para IconData
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDefaults.borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon, size: 24, color: AppColors.secundary), // Usando o Icon aqui
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black),
              ),
              const Spacer(),
              const Icon(Icons.play_arrow, size: 16, color: AppColors.secundary), // Ícone de seta à direita
            ],
          ),
        ),
      ),
    );
  }
}
