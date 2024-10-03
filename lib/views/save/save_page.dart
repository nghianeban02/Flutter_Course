import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery/core/constants/app_icons.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:grocery/core/models/product/product_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'empty_save_page.dart';

class SavePage extends StatefulWidget {
  const SavePage({
    Key? key,
    this.isHomePage = false,
  }) : super(key: key);

  final bool isHomePage;

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  List<Product> itemlst = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Danh sách yêu thích",style: titleStyle),
      //   backgroundColor: appBarBackgroundColor,
      //   iconTheme: iconBackColor,
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(
              child: Consumer<ProductVM>(
                builder: (context, value, child) => Scaffold(
                  body: SafeArea(
                    child: Scaffold(
                      body: value.lstFavorite.isEmpty
                          ? const EmptySavePage()
                          : ListView.builder(
                              itemCount: value.lstFavorite.length,
                              itemBuilder: (context, index) {
                                return _buildFavorite(
                                    value.lstFavorite[index], context);
                              }),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
                height:
                    16), // Khoảng cách giữa danh sách sản phẩm và nút quay lại
          ],
        ),
      ),
    );
  }

  Widget _buildFavorite(Product product, BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners for the card
      ),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 140,
                        height: 120,
                        child: product.imageURL != 'null' &&
                                product.imageURL!
                                    .isNotEmpty // Kiểm tra xem product.img có khác null và không rỗng không
                            ? Image.network(
                                product.imageURL!, // Hình ảnh sản phẩm

                                fit: BoxFit.contain,
                              )
                            : const Icon(Icons.image), // Nếu không có hình ảnh, hiển thị icon mặc định
                      ),
                      const SizedBox(width: 30, ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.nameProduct!, // Product title
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.black),
                            ),
                            // Row(
                            //   children: [
                            //     ...List.generate(5, (index) {
                            //       return Icon(
                            //         index < 5 ? Icons.star : Icons.star_border,
                            //         size: 20,
                            //         color: Colors.amber,
                            //       );
                            //     }),
                            //     SizedBox(width: 8),
                            //     Text('126'),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  NumberFormat('###,###.### ₫')
                                      .format(product.price), // Current price
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .green, // or Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            // Text(
                            //   'Identifier number', // Placeholder for an identifier
                            //   style:
                            //       TextStyle(fontSize: 12, color: Colors.grey),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //nút xóa khỏi danh sách
                  Consumer<ProductVM>(
                    builder: (context, value, child) => Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        onPressed: () {
                          value.removeFavorite(product);
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            content: Text(
                              'Đã xóa ${product.nameProduct} khỏi danh sách yêu thích!',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            duration: const Duration(seconds: 2),
                          ));
                        },
                        icon: SvgPicture.asset(AppIcons.delete),
                      ),
                    ),
                  ),
                  //nút thêm vào giỏ hàng
                  Consumer<ProductVM>(
                    builder: (context, value, child) => Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                        onPressed: () {
                          setState(() {});
                          print('Bạn vừa nhấn nút add');
                          value.add(product);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                            content: Text(
                              'Đã thêm ${product.nameProduct} vào giỏ hàng!',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            duration: const Duration(seconds: 2),
                          ));
                        },
                        icon: SvgPicture.asset(AppIcons.shoppingCart),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
