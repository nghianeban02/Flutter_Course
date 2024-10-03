import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import 'bottom_app_bar_item.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onNavTap,
  }) : super(key: key);

  final int currentIndex;
  final void Function(int) onNavTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: AppDefaults.margin,
      color: AppColors.scaffoldBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomAppBarItem(
            name: 'Trang chủ',
            iconLocation: AppIcons.home,
            isActive: currentIndex == 0,
            onTap: () => onNavTap(0),
          ),
          BottomAppBarItem(
            name: 'Danh mục',
            iconLocation: AppIcons.menu,
            isActive: currentIndex == 1,
            onTap: () => onNavTap(1),
          ),
          const Padding(
            padding: EdgeInsets.all(AppDefaults.padding * 2),
            child: SizedBox(width: AppDefaults.margin),
          ),
          /* <---- Phần trống này chừa ra để hiển thị nút giỏ hàng ở giữa -----> */
          /* Tên file chứa cart button: entrypoint_ui.dart*/

          BottomAppBarItem(
            name: 'Yêu thích',
            iconLocation: AppIcons.heart,
            isActive: currentIndex == 3,
            onTap: () => onNavTap(3),
          ),
          BottomAppBarItem(
            name: 'Tài khoản',
            iconLocation: AppIcons.profile,
            isActive: currentIndex == 4,
            onTap: () => onNavTap(4),
          ),
        ],
      ),
    );
  }
}
