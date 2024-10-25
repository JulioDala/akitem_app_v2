import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/enums/order_status.dart';

class OrderPreviewTile extends StatelessWidget {
  const OrderPreviewTile({
    super.key,
    required this.orderID,
    required this.date,
    required this.status,
    required this.onTap,
  });

  final String orderID;
  final String date;
  final OrderStatus status;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: AppDefaults.borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppDefaults.borderRadius,
          child: Container(
            padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              borderRadius: AppDefaults.borderRadius,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Order ID:'),
                    const SizedBox(width: 5),
                    Text(
                      orderID,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.black),
                    ),
                    const Spacer(),
                    Text(date),
                  ],
                ),
                Row(
                  children: [
                    const Text('Status'),
                    Expanded(
                      child: RangeSlider(
                        values: RangeValues(0, _orderSliderValue()),
                        max: 3,
                        divisions: 3,
                        onChanged: (v) {},
                        activeColor: _orderColor(),
                        inactiveColor: AppColors.placeholder.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Opacity(
                            opacity: status == OrderStatus.confirmed ? 1 : 0,
                            child: Text(
                              'Verificado',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: _orderColor()),
                            ),
                          ),
                          Opacity(
                            opacity: status == OrderStatus.pending ? 1 : 0,
                            child: Text(
                              'Pendente',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: _orderColor()),
                            ),
                          ),
                          Opacity(
                            opacity: status == OrderStatus.cancelled ? 1 : 0,
                            child: Text(
                                  'Cancelado',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: _orderColor()),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _orderSliderValue() {
    switch (status) {
      case OrderStatus.confirmed:
        return 3;
      case OrderStatus.pending:
        return 1.5;
      case OrderStatus.cancelled:
        return 3;

      default:
        return 0;
    }
  }

  Color _orderColor() {
    switch (status) {
      case OrderStatus.confirmed:
        return const Color(0xFF41AA55);
      case OrderStatus.pending:
        return const Color(0xFFFFC107);
      case OrderStatus.shipped:
        return const Color(0xFFE19603);
      case OrderStatus.delivery:
        return const Color(0xFF4044AA);
      case OrderStatus.cancelled:
        return const Color(0xFFFF1F1F);

      default:
        return Colors.red;
    }
  }
}

extension OrderStatusExtension on OrderStatus {
  int get value {
    switch (this) {
      case OrderStatus.pending:
        return 0;
      case OrderStatus.confirmed:
        return 1;
      case OrderStatus.cancelled:
        return 2;
      default:
        return -1;
    }
  }

  static OrderStatus fromInt(int value) {
    switch (value) {
      case 0:
        return OrderStatus.pending;
      case 1:
        return OrderStatus.confirmed;
      case 2:
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending; // Default case
    }
  }
}
