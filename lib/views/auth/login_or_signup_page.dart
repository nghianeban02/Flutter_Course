import 'package:flutter/material.dart';
import '../../core/components/network_image.dart';
import '../../core/constants/constants.dart';
import '../../core/routes/app_routes.dart';

class LoginOrSignUpPage extends StatelessWidget {
  const LoginOrSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Spacer(flex: 2),
          _AppLogoAndHeadline(),
          Spacer(),
          _Footer(),
          Spacer(),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
              child: const Text('Đăng nhập'),
            ),
          ),
        ),
        // const SizedBox(height: AppDefaults.margin),
        // Text(
        //   'Hoặc',
        //   style: Theme.of(context)
        //       .textTheme
        //       .titleLarge
        //       ?.copyWith(fontWeight: FontWeight.bold),
        // ),
        // const SizedBox(height: AppDefaults.margin),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: SvgPicture.asset(AppIcons.appleIcon),
        //       iconSize: 48,
        //     ),
        //     IconButton(
        //       onPressed: () {},
        //       icon: SvgPicture.asset(AppIcons.googleIcon),
        //       iconSize: 48,
        //     ),
        //     IconButton(
        //       onPressed: () {},
        //       icon: SvgPicture.asset(AppIcons.twitterIcon),
        //       iconSize: 48,
        //     ),
        //     IconButton(
        //       onPressed: () {},
        //       icon: SvgPicture.asset(AppIcons.facebookIcon),
        //       iconSize: 48,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class _AppLogoAndHeadline extends StatelessWidget {
  const _AppLogoAndHeadline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: const AspectRatio(
            aspectRatio: 1 / 1,
            child: NetworkImageWithLoader(AppImages.roundedLogo),
          ),
        ),
        Text(
          'Chào mừng bạn đến với',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'Kara Shop',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        )
      ],
    );
  }
}
