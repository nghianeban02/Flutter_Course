import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/components/buy_now_row_button.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:grocery/core/models/product/product_viewmodel.dart';
import 'package:grocery/views/home/product_details_page_2.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import 'package:intl/intl.dart';
import 'network_image.dart';

class ProductTileSquare extends StatefulWidget {
  const ProductTileSquare({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Product data;

  @override
  State<ProductTileSquare> createState() => _ProductTileSquareState();
}

class _ProductTileSquareState extends State<ProductTileSquare> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding / 2),
      child: Material(
        borderRadius: AppDefaults.borderRadius,
        color: AppColors.scaffoldBackground,
        child: InkWell(
          borderRadius: AppDefaults.borderRadius,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                  objPro: widget.data,
                ),
              ),
            );
          },
          child: Container(
            width: 176,
            height: 296,
            padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: AppColors.placeholder),
              borderRadius: AppDefaults.borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding / 2),
                  child: AspectRatio(
                    aspectRatio: 2 / 1.5,
                    child: NetworkImageWithLoader(
                      widget.data.imageURL!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.data.nameProduct!,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // const Spacer(),
                const SizedBox(
                  height: 16,
                ),
                // Text(
                //   widget.data.weight,
                // ),
                // const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      NumberFormat('###,###.###₫').format(widget.data.price),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    // Text(
                    //   NumberFormat('###,###.###₫').format(widget.data.price),
                    //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    //         decoration: TextDecoration.lineThrough,
                    //       ),
                    // ),
                  ],
                ),
                Consumer<ProductVM>(
                    builder: (context, value, child) =>
                        addToCartBtn(widget.data)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget productItemSquare(Product productmodel, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding / 2),
    child: Material(
      borderRadius: AppDefaults.borderRadius,
      color: AppColors.scaffoldBackground,
      child: Container(
        child: InkWell(
          borderRadius: AppDefaults.borderRadius,
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ProductDetailsPage(
                  objPro: productmodel,
                ),
              ),
            );
          },
          child: Container(
            width: 176,
            height: 296,
            padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: AppColors.placeholder),
              borderRadius: AppDefaults.borderRadius,
            ),
            child: Consumer<ProductVM>(
              builder: (context, value, child) {
                bool isLiked = value.lstFavorite
                    .any((element) => element.id == productmodel.id);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                          padding:
                              const EdgeInsets.all(AppDefaults.padding / 2),
                          child: AspectRatio(
                            aspectRatio: 2 / 1.5,
                            child: NetworkImageWithLoader(
                              productmodel.imageURL!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                    //nút thêm vào danh sách yêu thích
                    // Stack(
                    //   children: [
                    //     Padding(
                    //       padding:
                    //           const EdgeInsets.all(AppDefaults.padding / 2),
                    //       child: AspectRatio(
                    //         aspectRatio: 2 / 1.5,
                    //         child: NetworkImageWithLoader(
                    //           productmodel.imageURL!,
                    //           fit: BoxFit.contain,
                    //         ),
                    //       ),
                    //     ),
                    //     Positioned(
                    //       right: 0,
                    //       child: IconButton(
                    //         onPressed: () {
                    //           print('Bạn vừa nhấn nút thả tim');
                    //           value.addOrRemoveFavorites(productmodel);
                    //         },
                    //         icon: Container(
                    //           padding: const EdgeInsets.all(10),
                    //           decoration: const BoxDecoration(
                    //             color: Colors.white54,
                    //             shape: BoxShape.circle,
                    //           ),
                    //           child: Icon(
                    //             isLiked
                    //                 ? Icons.favorite
                    //                 : Icons.favorite_border,
                    //             color: isLiked ? Colors.red : null,
                    //             size: 20,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    const SizedBox(height: 8),
                    Text(
                      productmodel.nameProduct!,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // const Spacer(),
                    const SizedBox(
                      height: 16,
                    ),
                    // Text(
                    //   widget.data.weight,
                    // ),
                    // const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          NumberFormat('###,###.###₫')
                              .format(productmodel.price!),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.green),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                      ],
                    ),

                    //nút giỏ hàng
                    Consumer<ProductVM>(
                        builder: (context, value, child) =>
                            addToCartBtnList(productmodel)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}
