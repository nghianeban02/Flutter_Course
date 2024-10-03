import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:grocery/core/models/tools_viewmodel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../core/components/app_back_button.dart';
import '../../core/components/product_tile_square.dart';
import '../../core/constants/constants.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({
    Key? key,
    required this.dataSearch,
    this.dataProduct,
  }) : super(key: key);

  final String dataSearch;
  final Product? dataProduct;
  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  TextEditingController _searchController = TextEditingController();

  Future<List<Product>> getResult(String proName) async {
    if (widget.dataSearch != null) {
      return await APIRepository().findProduct(proName);
    }

    // Lấy thông tin product từ API
    return await APIRepository().findProduct(proName);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResult(widget.dataSearch);
    _searchController.text = widget.dataSearch;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kết quả tìm kiếm',
          style: TextStyle(fontSize: 15),
        ),
        leading: const AppBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Consumer<ToolsVM>(
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Tìm kiếm sản phẩm',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        child: SvgPicture.asset(AppIcons.search),
                      ),
                      suffixIconConstraints: const BoxConstraints(),
                    ),
                    onFieldSubmitted: (v) {
                      //thêm từ khóa vào lịch sử tìm kiếm
                      value.addSearchResult(v);
                      setState(() {
                        _searchController.text = v;
                      });
                    },
                  );
                },
              ),
            ),
            FutureBuilder<List<Product>>(
              future: getResult(_searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                          color: Colors.green, size: 50));
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  );
                } else {
                  //nếu không tìm thấy sản phẩm trả về ds rỗng
                  if (snapshot.data!.isEmpty) {
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppDefaults.padding),
                            child: Text(
                              '0 sản phẩm được tìm thấy',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppDefaults.padding),
                            child: Text(
                              '${snapshot.data!.length} sản phẩm được tìm thấy',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: SizedBox(
                            width: 550,
                            height: 575,
                            child: GridView.builder(
                              itemCount: snapshot.data!.length,
                              padding: const EdgeInsets.only(
                                  top: AppDefaults.padding),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.65,
                              ),
                              itemBuilder: (context, index) {
                                final itemPro = snapshot.data![index];
                                return productItemSquare(itemPro, context);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
