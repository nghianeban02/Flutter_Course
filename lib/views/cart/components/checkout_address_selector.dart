import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/core/models/user/user.dart';
import 'package:grocery/core/routes/app_routes.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/components/title_and_action_button.dart';
import 'checkout_address_card.dart';

class AddressSelector extends StatefulWidget {
  const AddressSelector({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressSelector> createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
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
    return strUser.isEmpty
        ? Center(
            child: LoadingAnimationWidget.threeArchedCircle(
                color: Colors.green, size: 50),
          )
        : Column(
            children: [
              TitleAndActionButton(
                title: 'Địa chỉ giao hàng',
                actionLabel: 'Thêm mới',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.newAddress);
                },
                isHeadline: false,
              ),
              AddressCard(
                label: 'Nhà riêng',
                phoneNumber: user.phoneNumber!,
                address: '828, Sư Vạn Hạnh,Phường 13,Quận 10,Hồ Chí Minh',
                isActive: true,
                onTap: () {},
              ),
              // AddressCard(
              //   label: 'Office Address',
              //   phoneNumber: '(309) 071-9396-939',
              //   address: '1749 Custom Road, Chhatak',
              //   isActive: true,
              //   onTap: () {},
              // )
            ],
          );
  }
}
