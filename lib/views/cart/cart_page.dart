import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery/core/constants/app_icons.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:grocery/core/models/product/product_viewmodel.dart';
import 'package:grocery/views/cart/empty_cart_page.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/routes/app_routes.dart';
import 'components/items_totals_price.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
    this.isHomePage = false,
  }) : super(key: key);

  final bool isHomePage;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isHomePage = false;
  var lstProStr = "";
  List<Product> itemsList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Giỏ hàng'),
        //các nút hành động
        actions: [
          //nút refresh lại trang giỏ hàng
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ), // Icon làm mới
            onPressed: () {
              // Xử lý sự kiện khi người dùng nhấn vào nút làm mới
              // Đặt logic làm mới danh sách đơn hàng ở đây
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isLoading
              ? LoadingAnimationWidget.discreteCircle(
                  color: Colors.green, size: 35)
              : Expanded(
                  child: Consumer<ProductVM>(
                    builder: (context, value, child) => Scaffold(
                      body: SafeArea(
                        child: Scaffold(
                          //nếu giỏ hàng rỗng -> trả về trang thông báo giỏ hàng rỗng ngược lại trả về danh sách
                          body: value.lst.isEmpty
                              ? const EmptyCartPage()
                              : ListView.builder(
                                  itemCount: value.lst.length,
                                  itemBuilder: ((context, index) {
                                    return singleCartItem(value.lst[index]);
                                  })),
                        ),
                      ),
                    ),
                  ),
                ),
          SizedBox(height: 20), // Add some space between list and total
          Consumer<ProductVM>(
            builder: (context, value, child) {
              final totalQuantity = value.getTotalQuantity();
              final totalPrice = value.getTotalPrice();
              return Column(
                children: [
                  //ẩn thông tin giỏ hàng & nút thanh toán nếu giỏ hàng rỗng
                  value.lst.isEmpty
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 150),
                          ],
                        )
                      : Column(
                          children: [
                            ItemTotalsAndPrice(),
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.checkoutPage);
                                  },
                                  child: const Text('Thanh toán',
                                      style: TextStyle(fontSize: 17.5)),
                                ),
                              ),
                            ),
                          ],
                        ),

                  SizedBox(
                    height: 10,
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  //
  Widget singleCartItem(Product productModel) {
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
                  height: 100,
                  width: 100,
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
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.black),
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
                                //xóa sản phẩm khỏi giỏ hàng
                                value.del(productModel.id!);
                                //thông báo đã xóa thành công sp
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'Sản phẩm ${productModel.nameProduct} đã xóa thành công khỏi giỏ hàng!',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                  ),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                              value.remove(productModel);
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
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              content: Text(
                                'Sản phẩm ${productModel.nameProduct} đã xóa thành công khỏi giỏ hàng!',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                              ),
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              content: Text(
                                'Sản phẩm ${productModel.nameProduct} không thể xóa khỏi giỏ hàng.Vui lòng thử lại!',
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
                      style: TextStyle(
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
}
