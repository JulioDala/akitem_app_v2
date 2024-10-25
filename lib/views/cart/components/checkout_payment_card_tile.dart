import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/constants.dart';

class PaymentCardTile extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;  // Indicador de seleção
  final void Function() onSelect;  // Função de seleção

  const PaymentCardTile({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onSelect,  // Função passada via prop
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: isSelected  // Se o cartão estiver selecionado, cor de fundo muda
            ? AppColors.coloredBackground
            : AppColors.scaffoldBackground,
        borderRadius: AppDefaults.borderRadius,
        child: InkWell(
          onTap: onSelect,  // Ao clicar, executa a função de seleção
          borderRadius: AppDefaults.borderRadius,
          child: Container(
            height: 66,
            width: 135,
            padding: const EdgeInsets.symmetric(),
            decoration: BoxDecoration(
              borderRadius: AppDefaults.borderRadius,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.placeholder,
                width: isSelected ? 1 : 0.2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(icon),  // Exibe o ícone de pagamento
                const SizedBox(height: 8),
                Text(
                  label,  // Exibe o nome do método
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
