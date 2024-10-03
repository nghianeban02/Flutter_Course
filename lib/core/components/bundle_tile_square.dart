import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../data/dummy_data/dummy_bundle_model.dart';
import '../routes/app_routes.dart';
import 'package:intl/intl.dart';
import 'network_image.dart';

class BundleTileSquare extends StatelessWidget {
  const BundleTileSquare({
    Key? key,
    required this.data,
  }) : super(key: key);

  final BundleModel data;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.scaffoldBackground,
      borderRadius: AppDefaults.borderRadius,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.bundleProduct);
        },
        borderRadius: AppDefaults.borderRadius,
        child: Container(
          width: 176,
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1, color: AppColors.placeholder),
            borderRadius: AppDefaults.borderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: NetworkImageWithLoader(
                    data.cover,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              //Title sản phẩm
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  //Sub title
                  // Text(
                  //   data.itemNames.join(','),
                  //   maxLines: 1,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  //Giá đã giảm
                  Text(
                    NumberFormat('###,###.###₫').format(data.price.toInt()),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.black),
                  ),
                  //Giá chưa giảm
                  const SizedBox(width: 4),
                  Text(
                    NumberFormat('###,###.###₫').format(data.mainPrice.toInt()),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
