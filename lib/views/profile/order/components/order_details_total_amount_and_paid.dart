import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class TotalAmountAndPaidData extends StatefulWidget {
  const TotalAmountAndPaidData({
    Key? key,
  }) : super(key: key);

  @override
  State<TotalAmountAndPaidData> createState() => _TotalAmountAndPaidDataState();
}

class _TotalAmountAndPaidDataState extends State<TotalAmountAndPaidData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Tổng tiền đơn hàng',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Spacer(),
              Text(
                '28,600₫',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Phương thức thanh toán',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Spacer(),
              Text(
                'COD',
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
