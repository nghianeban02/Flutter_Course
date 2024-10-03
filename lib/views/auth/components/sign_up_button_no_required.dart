import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';

class SignUpButtonNoRequired extends StatefulWidget {
  const SignUpButtonNoRequired({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpButtonNoRequired> createState() => _SignUpButtonNoRequiredState();
}

class _SignUpButtonNoRequiredState extends State<SignUpButtonNoRequired> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding * 2),
      child: Row(
        children: [
          Text(
            'Đăng ký',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.numberVerification);
            },
            style: ElevatedButton.styleFrom(elevation: 1),
            child: SvgPicture.asset(
              AppIcons.arrowForward,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
