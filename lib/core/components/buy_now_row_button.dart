import 'package:flutter/material.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:grocery/core/models/product/product_viewmodel.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';

class BuyNowRow extends StatefulWidget {
  const BuyNowRow({
    Key? key,
    // required this.onCartButtonTap,
    required this.onBuyButtonTap,
  }) : super(key: key);

  // final void Function() onCartButtonTap;
  final void Function() onBuyButtonTap;

  @override
  State<BuyNowRow> createState() => _BuyNowRowState();
}

class _BuyNowRowState extends State<BuyNowRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDefaults.padding,
      ),
      child: Row(
        children: [
          // OutlinedButton(
          //   onPressed: onCartButtonTap,
          //   child: SvgPicture.asset(AppIcons.shoppingCart),
          // ),
          // const SizedBox(width: AppDefaults.padding),
          Expanded(
            child: ElevatedButton(
              onPressed: widget.onBuyButtonTap,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(AppDefaults.padding * 1.2),
              ),
              child: const Text(
                'Thêm vào giỏ hàng',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuyNowRowList extends StatefulWidget {
  const BuyNowRowList({
    Key? key,
    // required this.onCartButtonTap,
    required this.onBuyButtonTap,
  }) : super(key: key);

  // final void Function() onCartButtonTap;
  final void Function() onBuyButtonTap;

  @override
  State<BuyNowRowList> createState() => _BuyNowRowListState();
}

class _BuyNowRowListState extends State<BuyNowRowList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<ProductVM>(
            builder: (context, value, child) => ElevatedButton.icon(
              icon: const Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
                size: 20,
              ),
              label: const Text(
                'Giỏ hàng',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                // value.add();
              },
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                backgroundColor: Colors.green,
              ),
            ),
          ),
          // OutlinedButton(
          //   onPressed: onCartButtonTap,
          //   child: SvgPicture.asset(AppIcons.shoppingCart),
          // ),
          // const SizedBox(width: AppDefaults.padding),
        ],
      ),
    );
  }
}

Widget addToCartBtnList(Product productModel) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 11,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<ProductVM>(
          builder: (context, value, child) => ElevatedButton.icon(
            icon: const Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
              size: 20,
            ),
            label: const Text(
              'Giỏ hàng',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              bool check = value.add(productModel);
              if (check == true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                  content: Text(
                    'Đã thêm ${productModel.nameProduct} vào giỏ hàng!',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                  duration: Duration(seconds: 2),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  content: Text(
                    '${productModel.nameProduct} thêm vào giỏ hàng thất bại!',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                  duration: const Duration(seconds: 2),
                ));
              }
            },
            style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
              backgroundColor: Colors.green,
            ),
          ),
        ),
        // OutlinedButton(
        //   onPressed: onCartButtonTap,
        //   child: SvgPicture.asset(AppIcons.shoppingCart),
        // ),
        // const SizedBox(width: AppDefaults.padding),
      ],
    ),
  );
}

Widget addToCartBtn(Product productModel) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: AppDefaults.padding,
    ),
    child: Row(
      children: [
        Expanded(
          child: Consumer<ProductVM>(
            builder: (context, value, child) => ElevatedButton(
              onPressed: () {
                bool check = value.add(productModel);
                if (check == true) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green,
                    content: Text(
                      'Đã thêm ${productModel.nameProduct} vào giỏ hàng!',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    duration: Duration(seconds: 2),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                    content: Text(
                      '${productModel.nameProduct} thêm vào giỏ hàng thất bại!',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    duration: const Duration(seconds: 2),
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(AppDefaults.padding * 1.2),
              ),
              child: const Text(
                'Thêm vào giỏ hàng',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
