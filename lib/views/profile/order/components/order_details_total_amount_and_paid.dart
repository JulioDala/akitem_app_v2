import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class TotalAmountAndPaidData extends StatelessWidget {
    final int totalPrice;
  const TotalAmountAndPaidData({
    super.key, required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Spacer(),
              Text(
                '$totalPrice kz',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Pagamento por',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Spacer(),
              Text(
                'Credit Card',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
