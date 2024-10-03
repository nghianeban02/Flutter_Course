import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/constants.dart';

class SocialLogins extends StatefulWidget {
  const SocialLogins({
    Key? key,
  }) : super(key: key);

  @override
  State<SocialLogins> createState() => _SocialLoginsState();
}

class _SocialLoginsState extends State<SocialLogins> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding * 2,
                  vertical: AppDefaults.padding,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppIcons.zaloIcon,
                    width: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Zalo',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppDefaults.margin),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blueAccent),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding * 2,
                  vertical: AppDefaults.padding,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppIcons.facebookIconFill,
                    width: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Facebook',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
