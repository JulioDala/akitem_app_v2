import 'package:flutter/material.dart';

import 'filter_modal.dart';

class FiltersRow extends StatelessWidget {
  final bool vendidoPorWorten;
  final ValueChanged<bool> onSwitchChanged;

  const FiltersRow({
    super.key,
    required this.vendidoPorWorten,
    required this.onSwitchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    onChanged: onSwitchChanged,
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
          const FilterModal(),
        ],
      ),
    );
  }
}
