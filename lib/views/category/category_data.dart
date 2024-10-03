import 'package:flutter/material.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/models/category/category_product.dart';
import 'package:grocery/views/category/category_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'components/category_tile.dart';

class CateogoriesGrid extends StatefulWidget {
  const CateogoriesGrid({
    Key? key,
  }) : super(key: key);

  @override
  State<CateogoriesGrid> createState() => _CateogoriesGridState();
}

class _CateogoriesGridState extends State<CateogoriesGrid> {
  Future<List<Category>> _getCategorys() async {
    // thêm vào 1 dòng dữ liệu nếu getdata không có hoặc chưa có database
    //return await _databaseHelper.categories();
    // Lấy danh sác category từ API
    return await APIRepository().getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _getCategorys(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.green, size: 50)),
          );
        } else {
          return Expanded(
            child: GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 4,
                mainAxisSpacing: 11,
              ),
              itemBuilder: (context, index) {
                final itemCate = snapshot.data![index];
                return itemCateView(itemCate, context);
              },
            ),
          );
        }
      },
    );
  }
}

Widget itemCateView(Category category, BuildContext context) {
  return CategoryTile(
    imageLink: category.imageURL!,
    label: category.name,
    backgroundColor: Colors.grey.shade200,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryProductPage(
            objCat: category,
          ),
        ),
      );
    },
  );
}
