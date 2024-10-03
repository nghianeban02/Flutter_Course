import 'package:flutter/material.dart';
import 'package:grocery/core/models/product/product_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/components/dotted_divider.dart';
import '../../../core/constants/constants.dart';
import 'item_row.dart';

class ItemTotalsAndPrice extends StatefulWidget {
  const ItemTotalsAndPrice({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemTotalsAndPrice> createState() => _ItemTotalsAndPriceState();
}

class _ItemTotalsAndPriceState extends State<ItemTotalsAndPrice> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDefaults.padding),
      child: Consumer<ProductVM>(
        builder: (context, value, child) {
          final totalQuantity = value.getTotalQuantity();
          final totalPrice = value.getTotalPrice();
          return Column(
            children: [
              ItemRow(
                title: 'Tổng số lượng',
                value: totalQuantity,
              ),
              DottedDivider(),
              ItemRow(
                title: 'Thành tiền',
                value: NumberFormat('###,###.### ₫').format(totalPrice),
              ),
            ],
          );
        },
      ),
    );
  }
}
