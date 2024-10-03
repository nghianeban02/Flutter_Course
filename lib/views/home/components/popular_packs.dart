import 'package:flutter/material.dart';
import 'package:grocery/core/components/product_tile_square.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../core/components/title_and_action_button.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';

class PopularPacks extends StatefulWidget {
    final int? brandId;
  const PopularPacks({super.key, this.brandId});

  @override
  State<PopularPacks> createState() => _PopularPacksState();
}

class _PopularPacksState extends State<PopularPacks> {
  Future<List<Product>> getDataPro() async {
   

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
    return Column(
      children: [
        TitleAndActionButton(
          title: 'Sản phẩm nổi bật',
          onTap: () => Navigator.pushNamed(context, AppRoutes.popularItems),
        ),
         SingleChildScrollView(
          padding: const EdgeInsets.only(left: AppDefaults.padding),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              popularPacks(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget popularPacks(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: getDataPro(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.green, size: 35));
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red, fontSize: 20),
            ),
          );
        } else {
          return SizedBox(
            height: 320,
            width: 500,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length=20,
              padding: const EdgeInsets.only(top: AppDefaults.padding),
              itemBuilder: (context, index) {
                if (index % 2 != 0) {
                  final itemPro = snapshot.data![index];
                  //hiển thị productbody
                  return productItemSquare(itemPro, context);
                }
                return Container();
              },
            ),
          );
        }
      },
    );
  }
}
