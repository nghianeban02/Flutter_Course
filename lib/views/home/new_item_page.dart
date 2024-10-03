import 'package:flutter/material.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/components/app_back_button.dart';
import '../../core/components/product_tile_square.dart';
import '../../core/constants/constants.dart';

class NewItemsPage extends StatefulWidget {
  final int? brandId;
  const NewItemsPage({super.key, this.brandId});

  @override
  State<NewItemsPage> createState() => _NewItemsPageState();
}

class _NewItemsPageState extends State<NewItemsPage> {
  Future<List<Product>> getDataPro() async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // // strPro = pref.getStringList('product')! as List<Product>;
    // // String strPro = pref.getString('product')!;
    // // lỗi key tại đây
    // List<String> lstStrPro = pref.getStringList('items')!;
    // lstPro = Product.fromJson(jsonDecode(lstStrPro as String)) as List<Product>;
    // setState(() {});
    // await Future.delayed(const Duration(seconds: 1));
    // return '';

    if (widget.brandId != null) {
      // Lấy thông tin product từ SQL lite
      // return await _databaseProduct
      //     .findProductId(int.parse(widget.brandId.toString()));
      // Lấy thông tin product từ API
      return await APIRepository().getProduct(widget.brandId);
    }

    // Lấy thông tin product từ SQL lite
    //return await _databaseProduct.products();

    // Lấy thông tin product từ API
    return await APIRepository().getProduct(widget.brandId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sản phẩm mới'),
        leading: const AppBackButton(),
      ),
      body: FutureBuilder<List<Product>>(
        future: getDataPro(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.green, size: 45));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 20),
              ),
            );
          } else {
            //trả về danh sách sản phẩm theo id chẵn
            final evenItems = snapshot.data!
                .asMap()
                .entries
                .where((entry) => entry.key % 2 == 0)
                .map((entry) => entry.value)
                .toList();
            return GridView.builder(
              itemCount: evenItems.length,
              padding: const EdgeInsets.only(top: AppDefaults.padding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final itemPro = evenItems[index];
                return productItemSquare(itemPro, context);
              },
            );
          }
        },
      ),
    );
  }
}
