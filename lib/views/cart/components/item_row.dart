import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  const ItemRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                ),
          ),
          const Spacer(),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
