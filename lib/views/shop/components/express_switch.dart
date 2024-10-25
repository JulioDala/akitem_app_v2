import 'package:flutter/material.dart';

class ExpressSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const ExpressSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              value: value,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
