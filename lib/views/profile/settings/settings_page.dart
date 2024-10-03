import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/components/app_back_button.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/components/app_settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'Cài đặt',
          style: TextStyle(fontSize: 16),
        ),
      ),
      backgroundColor: AppColors.cardColor,
      body: Container(
        margin: const EdgeInsets.all(AppDefaults.padding),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDefaults.padding,
          vertical: AppDefaults.padding * 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackground,
          borderRadius: AppDefaults.borderRadius,
        ),
        child: Column(
          children: [
            AppSettingsListTile(
              label: 'Ngôn ngữ',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.settingsLanguage),
            ),
            AppSettingsListTile(
              label: 'Thông báo',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.settingsNotifications),
            ),
            AppSettingsListTile(
              label: 'Đổi mật khẩu',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.changePassword),
            ),
            // AppSettingsListTile(
            //   label: 'Đổi số điện thoại',
            //   trailing: SvgPicture.asset(AppIcons.right),
            //   onTap: () =>
            //       Navigator.pushNamed(context, AppRoutes.changePhoneNumber),
            // ),
            AppSettingsListTile(
              label: 'Đổi địa chỉ giao hàng',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.deliveryAddress),
            ),
            // AppSettingsListTile(
            //   label: 'Location',
            //   trailing: SvgPicture.asset(AppIcons.right),
            //   onTap: () {},
            // ),
            // AppSettingsListTile(
            //   label: 'Thay đổi thông tin cá nhân',
            //   trailing: SvgPicture.asset(AppIcons.right),
            //   onTap: () => Navigator.pushNamed(context, AppRoutes.profileEdit),
            // ),
            AppSettingsListTile(
              label: 'Xóa tài khoản',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.introLogin),
            ),
          ],
        ),
      ),
    );
  }
}
