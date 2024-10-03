import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';

class DontHaveAccountRow extends StatefulWidget {
  const DontHaveAccountRow({
    Key? key,
  }) : super(key: key);

  @override
  State<DontHaveAccountRow> createState() => _DontHaveAccountRowState();
}

class _DontHaveAccountRowState extends State<DontHaveAccountRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Chưa có tài khoản?'),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),
          child: const Text('Tạo tài khoản'),
        ),
      ],
    );
  }
}
