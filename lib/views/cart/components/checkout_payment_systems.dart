import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import 'checkout_payment_card_tile.dart';

class PaymentSystem extends StatelessWidget {
  const PaymentSystem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
            vertical: AppDefaults.padding / 2,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Phương thức thanh toán',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [  
              PaymentCardTile(
                label: 'Thanh toán\nkhi nhận hàng',
                icon: AppIcons.cashOnDelivery,
                onTap: () {},
                isActive: true,
              ),
               PaymentCardTile(
                label: 'Momo',
                icon: AppIcons.momo,
                onTap: () {},
                isActive: false,
              ),
              PaymentCardTile(
                label: 'Thẻ tín dụng',
                icon: AppIcons.masterCard,
                onTap: () {},
                isActive: false,
              ),
            ],
          ),
        )
      ],
    );
  }
}
