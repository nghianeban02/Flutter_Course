import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery/core/models/user/user.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/constants.dart';
import 'profile_header_options.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background
        Image.asset('assets/images/profile_page_background.png'),

        /// Content
        Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false, // tắt nút app back
              title: const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text('Tài khoản của tôi'),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const _UserData(),
            const ProfileHeaderOptions()
          ],
        ),
      ],
    );
  }
}

class _UserData extends StatefulWidget {
  const _UserData({
    Key? key,
  }) : super(key: key);

  @override
  State<_UserData> createState() => _UserDataState();
}

class _UserDataState extends State<_UserData> {
  String strUser = '';
  // khi dùng tham số truyền vào phải khai báo biến trùng tên require
  User user = User.userEmpty();
  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    strUser = pref.getString('user')!;
    await Future.delayed(const Duration(seconds: 2));
    user = User.fromJson(jsonDecode(strUser));
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: strUser.isEmpty
          ? Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.white, size: 50),
            )
          : Row(
              children: [
                const SizedBox(width: AppDefaults.padding),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipOval(
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network(
                        user.imageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDefaults.padding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName!,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mã KH: ${user.accountId}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
