import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:grocery/core/models/product/product_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../views/home/components/animated_dots.dart';
import '../constants/constants.dart';
import 'network_image.dart';

class ProductImagesSlider extends StatefulWidget {
  const ProductImagesSlider({
    Key? key,
    required this.images,
    required this.data,
  }) : super(key: key);

  final List<String> images;
  final Product data;

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  late PageController controller;
  int currentIndex = 0;

  List<String> images = [];

  @override
  void initState() {
    super.initState();
    images = widget.images;
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: AppColors.coloredBackground,
        borderRadius: AppDefaults.borderRadius,
      ),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        children: [
          //hiển thị hình ảnh sản phẩm
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: (v) {
                    currentIndex = v;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(AppDefaults.padding),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: NetworkImageWithLoader(
                          images[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                  itemCount: images.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: AnimatedDots(
                  totalItems: images.length,
                  currentIndex: currentIndex,
                ),
              )
            ],
          ),
          //nút yêu thích
          Consumer<ProductVM>(
            builder: (context, value, child) {
              bool isLiked = value.lstFavorite
                  .any((element) => element.id == widget.data.id);
              return Positioned(
                right: 0,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: AppDefaults.borderRadius,
                  child: IconButton(
                    onPressed: () {
                      print('Bạn vừa nhấn nút thả tim');
                              value.addOrRemoveFavorites(widget.data);
                    },
                    iconSize: 56,
                    constraints:
                        const BoxConstraints(minHeight: 56, minWidth: 56),
                    icon: Container(
                      padding: const EdgeInsets.all(AppDefaults.padding),
                      decoration: const BoxDecoration(
                        color: AppColors.scaffoldBackground,
                        shape: BoxShape.circle,
                      ),
                      child: isLiked
                      ? SvgPicture.asset(AppIcons.heartActive)
                      : SvgPicture.asset(AppIcons.heart)
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
