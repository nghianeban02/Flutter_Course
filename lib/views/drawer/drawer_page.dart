import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/components/app_back_button.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/constants/app_icons.dart';
import '../../core/routes/app_routes.dart';
import '../../core/components/app_settings_tile.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          children: [
            AppSettingsListTile(
              label: 'Mời bạn bè sử dụng',
              trailing: SvgPicture.asset(AppIcons.right),
            ),
            AppSettingsListTile(
              label: 'Về chúng tôi',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.aboutUs),
            ),
            AppSettingsListTile(
              label: 'Câu hỏi thường gặp',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.faq),
            ),
            AppSettingsListTile(
              label: 'Điều khoản & Điều kiện',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.termsAndConditions),
            ),
            // AppSettingsListTile(
            //   label: 'Trung tâm hỗ trợ',
            //   trailing: SvgPicture.asset(AppIcons.right),
            //   onTap: () => Navigator.pushNamed(context, AppRoutes.help),
            //),
            AppSettingsListTile(
              label: 'Đánh giá app',
              trailing: SvgPicture.asset(AppIcons.right),
              // onTap: () => Navigator.pushNamed(context, AppRoutes.help),
            ),
            AppSettingsListTile(
              label: 'Quyền riêng tư',
              trailing: SvgPicture.asset(AppIcons.right),
              // onTap: () => Navigator.pushNamed(context, AppRoutes.),
            ),
            AppSettingsListTile(
              label: 'Liên hệ chúng tôi',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.contactUs),
            ),
            AppSettingsListTile(
              label: 'Video demo app',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.instruction),
            ),
            // const SizedBox(height: AppDefaults.padding * 3),
            // AppSettingsListTile(
            //   label: 'Đăng xuất',
            //   trailing: SvgPicture.asset(AppIcons.right),
            //   onTap: () { 
            //     logOut(context);
            //     // Navigator.pushNamed(context, AppRoutes.introLogin);
            //     },
            // ),
          ],
        ),
      ),
    );
  }
}
