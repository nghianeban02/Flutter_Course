import 'package:flutter/material.dart';
import 'package:grocery/core/models/product/product_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/components/dotted_divider.dart';
import '../../../core/constants/constants.dart';
import 'item_row.dart';

class ItemTotalsAndPriceCheckOut extends StatefulWidget {
  const ItemTotalsAndPriceCheckOut({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemTotalsAndPriceCheckOut> createState() =>
      _ItemTotalsAndPriceCheckOutState();
}

class _ItemTotalsAndPriceCheckOutState
    extends State<ItemTotalsAndPriceCheckOut> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDefaults.padding),
      child: Consumer<ProductVM>(
        builder: (context, value, child) {
          final totalQuantity = value.getTotalQuantity();
          final totalPrice = value.getTotalPrice();
          int shipCost = 15000;
          return Column(
            children: [
              ItemRow(
                title: 'Tổng số lượng',
                value: totalQuantity,
              ),
              // ItemRow(
              //   title: 'Tổng tiền hàng',
              //   value: NumberFormat('###,###.### ₫').format(totalPrice),
              // ),
              // ItemRow(
              //   title: 'Phí vận chuyển',
              //   value: NumberFormat('###,###.### ₫').format(shipCost),
              // ),
              DottedDivider(),
              ItemRow(
                title: 'Tổng thanh toán',
                value:
                    NumberFormat('###,###.### ₫').format(totalPrice),
              ),
            ],
          );
        },
      ),
    );
  }
}
