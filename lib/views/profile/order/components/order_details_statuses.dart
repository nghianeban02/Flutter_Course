import 'package:flutter/material.dart';

import '../../../../core/enums/dummy_order_status.dart';
import 'order_status_row.dart';

class OrderStatusColumn extends StatelessWidget {
  const OrderStatusColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        OrderStatusRow(
          status: OrderStatus.confirmed,
          date: '1/4/2023',
          time: '01.00 PM',
          isStart: true,
          isActive: true,
        ),
        OrderStatusRow(
          status: OrderStatus.processing,
          date: '',
          time: '',
          isActive: true,
        ),
        OrderStatusRow(
          status: OrderStatus.shipped,
          date: '',
          time: '',
          isActive: false,
        ),
        OrderStatusRow(
          status: OrderStatus.delivery,
          date: '',
          time: '',
          isEnd: false,
        ),
      ],
    );
  }
}
