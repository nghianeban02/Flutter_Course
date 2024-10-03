import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:grocery/core/models/product/product_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/components/network_image.dart';
import '../../../core/constants/constants.dart';

class SingleCartItemTile extends StatefulWidget {
  const SingleCartItemTile({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleCartItemTile> createState() => _SingleCartItemTileState();
}

class _SingleCartItemTileState extends State<SingleCartItemTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      child: Column(
        children: [
          Row(
            children: [
              /// Thumbnail
              const SizedBox(
                width: 70,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: NetworkImageWithLoader(
                    'https://cdn.tgdd.vn/Products/Images/2683/323687/bhx/nuoc-tuong-dau-nanh-nam-duong-chinh-hieu-con-meo-den-chai-280ml-clone-202403221040454651.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              /// Quantity and Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nước tương đậu nành Nam Dương\nchính hiệu Con Mèo Đen\nchai 280ml',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black),
                        ),
                        // Text(
                        //   '1.8kg',
                        //   style: Theme.of(context).textTheme.bodySmall,
                        // ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(AppIcons.removeQuantity),
                        constraints: const BoxConstraints(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '1',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(AppIcons.addQuantity),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),

              /// Price and Delete labelLarge
              Column(
                children: [
                  IconButton(
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: SvgPicture.asset(AppIcons.delete),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '13.600₫',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          const Divider(thickness: 0.1),
        ],
      ),
    );
  }
}

Widget singleCartItemCheckout(Product productModel, BuildContext context) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image(
                image: NetworkImage(productModel.imageURL!),
                height: 70,
                width: 70,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image),
              ),
              const SizedBox(width: 8),

              /// Hiển thị tên sản phẩm & nút chỉnh số lượng
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productModel.nameProduct!,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Consumer<ProductVM>(
                        builder: (context, value, child) => IconButton(
                          onPressed: () {
                            if (productModel.quantity == 1) {
                              value.del(productModel.id!);
                            }
                            value.remove(productModel);
                            //Nếu danh sách sản phẩm rỗng -> thoát khỏi trang thanh toán
                            if (value.lst.isEmpty) {
                              Navigator.pop(context);
                            }
                          },
                          icon: SvgPicture.asset(AppIcons.removeQuantity),
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          productModel.quantity.toString(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                      Consumer<ProductVM>(
                        builder: (context, value, child) => IconButton(
                          onPressed: () {
                            value.add(productModel);
                          },
                          icon: SvgPicture.asset(AppIcons.addQuantity),
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),

              /// Hiển thị giá sản phẩm và nút xóa sản phẩm
              Column(
                children: [
                  Consumer<ProductVM>(
                    builder: (context, value, child) => IconButton(
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        bool check = value.removeTrash(productModel);
                        if (check == true) {
                          //Nếu danh sách sản phẩm rỗng -> thoát khỏi trang thanh toán
                          if (value.lst.isEmpty) {
                            Navigator.pop(context);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            content: Text(
                              'Sản phẩm ${productModel.nameProduct} không thể xóa khỏi đơn hàng.Vui lòng thử lại!',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            duration: const Duration(seconds: 2),
                          ));
                        }
                      },
                      icon: SvgPicture.asset(AppIcons.delete),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    NumberFormat('###,###.### ₫').format(productModel.price),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              )
            ],
          ),
          const Divider(thickness: 0.1),
        ],
      ),
    ),
  );
}
