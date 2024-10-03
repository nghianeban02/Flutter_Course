import 'package:flutter/material.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:grocery/core/models/product/product_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/constants.dart';
import '../components/single_cart_item_tile.dart';
import '../components/items_totals_price_checkout.dart';

class ItemChecking extends StatefulWidget {
  const ItemChecking({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemChecking> createState() => _ItemCheckingState();
}

class _ItemCheckingState extends State<ItemChecking> {
  var lstProStr = "";
  List<Product> itemsList = [];

  @override
  void initState() {
    super.initState();
  }

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
              'Thông tin đơn hàng',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        SizedBox(
          height: 85,
          child: Consumer<ProductVM>(
            builder: (context, value, child) => Scaffold(
              body: SafeArea(
                child: Scaffold(
                  //nếu giỏ hàng rỗng -> trả về trang thông báo giỏ hàng rỗng ngược lại trả về danh sách
                  body: ListView.builder(
                      itemCount: value.lst.length,
                      itemBuilder: ((context, index) {
                        return singleCartItemCheckout(value.lst[index],context);
                      })),
                ),
              ),
            ),
          ),
        ),
        // const CouponCodeField(),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          child: ItemTotalsAndPriceCheckOut(),
        ),
      ],
    );
  }
}
