import 'package:flutter/material.dart';

import '../../../../core/components/network_image.dart';
import '../../../../core/data/dummy_data/dummy_product_model.dart';
import 'package:intl/intl.dart';

class OrderDetailsProductTile extends StatelessWidget {
  const OrderDetailsProductTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ProductModel data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 80,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: NetworkImageWithLoader(
              data.cover,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 8),
              Text(data.weight)
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              NumberFormat('###,###.###₫').format(data.price.toInt()),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'SL: 1',
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        )
      ],
    );
  }
}
