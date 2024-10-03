import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class SignUpPageHeader extends StatefulWidget {
  const SignUpPageHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpPageHeader> createState() => _SignUpPageHeaderState();
}

class _SignUpPageHeaderState extends State<SignUpPageHeader> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Text(
          'Đăng ký tài khoản',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
