import 'package:flutter/material.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:grocery/core/models/product/product_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../core/components/app_back_button.dart';
import '../../core/components/buy_now_row_button.dart';
import '../../core/components/price_and_quantity.dart';
import '../../core/components/review_row_button.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/routes/app_routes.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product? objPro; 
  const ProductDetailsPage({Key? key, this.objPro}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Future<Product> getDataProById(int catId,int proId) async {
    if (widget.objPro != null) {
      // Lấy thông tin product từ SQL lite
      // return await _databaseProduct
      //     .findProductId(int.parse(widget.brandId.toString()));
      // Lấy thông tin product từ API
      return await APIRepository().getSingleProduct(catId,proId);
    }

    // Lấy thông tin product từ SQL lite
    //return await _databaseProduct.products();

    // Lấy thông tin product từ API
    return await APIRepository().getSingleProduct(catId,proId);
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
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: BuyNowRow(
            onBuyButtonTap: () {
              Navigator.pushNamed(context, AppRoutes.cartPage);
            },
            // onCartButtonTap: () {},
          ),
        ),
      ),
      // body: productDetailPage(objPro, context)
    );
  }
}

Widget productDetailPage(Product productModel, BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      leading: const AppBackButton(),
      title: const Text('Chi tiết sản phẩm'),
    ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
        child: Consumer<ProductVM>(
            builder: (context, value, child) =>
                addToCartBtn(productModel)),
      ),
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Image(
            image: NetworkImage(productModel.imageURL!),
            height: 500,
            width: 500,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image),
          ),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
            child: PriceAndQuantityRow(
              currentPrice: 20,
              orginalPrice: 30,
              quantity: 2,
            ),
          ),
          const SizedBox(height: 8),

          /// Product Details
          Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mô tả sản phẩm',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  productModel.description!,
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
    ),
  );
}
