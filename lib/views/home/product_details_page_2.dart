import 'package:flutter/material.dart';
import 'package:grocery/core/constants/app_colors.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:grocery/core/models/product/product_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/components/app_back_button.dart';
import '../../core/components/buy_now_row_button.dart';
import '../../core/components/product_images_slider.dart';
import '../../core/components/review_row_button.dart';
import '../../core/constants/app_defaults.dart';


class ProductDetailsPage extends StatefulWidget {
  final Product objPro;
  const ProductDetailsPage({Key? key, required this.objPro}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Future<Product> getDataProById(int catId, int proId) async {
    if (widget.objPro != null) {
      // Lấy thông tin product từ SQL lite
      // return await _databaseProduct
      //     .findProductId(int.parse(widget.brandId.toString()));
      // Lấy thông tin product từ API
      return await APIRepository().getSingleProduct(catId, proId);
    }

    // Lấy thông tin product từ SQL lite
    //return await _databaseProduct.products();

    // Lấy thông tin product từ API
    return await APIRepository().getSingleProduct(catId, proId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const AppBackButton(),
          title: const Text('Chi tiết sản phẩm'),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
            child: Consumer<ProductVM>(
                        builder: (context, value, child) =>
                            addToCartBtn(widget.objPro)),
          ),
        ),
        body: productDetailPage(widget.objPro, context));
  }
}

Widget productDetailPage(Product productModel, BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductImagesSlider(images: [productModel.imageURL.toString()],data: productModel),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.nameProduct!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /* <---- Price -----> */
              // Text(
              //   '13.600₫',
              //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold,
              //         decoration: TextDecoration.lineThrough,
              //       ),
              // ),
              // const SizedBox(width: AppDefaults.padding),
              Text(
                 NumberFormat('###,###.###₫')
                              .format(productModel.price!),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
              const Spacer(),

              /* <---- Quantity -----> */
              // Row(
              //   children: [
              //      IconButton(
              //       onPressed: onQuantityDecrease,
              //       icon: SvgPicture.asset(AppIcons.removeQuantity),
              //       constraints: const BoxConstraints(),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         '$quantity',
              //         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              //               fontWeight: FontWeight.bold,
              //               color: Colors.black,
              //             ),
              //       ),
              //     ),

              //     IconButton(
              //       onPressed: onQuantityIncrease,
              //       icon: SvgPicture.asset(AppIcons.addQuantity),
              //       constraints: const BoxConstraints(),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
        const SizedBox(height: 8),

        /// Product Details
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mô tả sản phẩm',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              Text(
                productModel.description!,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),

        /// Review Row
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
            // vertical: AppDefaults.padding,
          ),
          child: Column(
            children: [
              Divider(thickness: 0.1),
              ReviewRowButton(totalStars: 5),
              Divider(thickness: 0.1),
            ],
          ),
        ),
      ],
    ),
  );
}
