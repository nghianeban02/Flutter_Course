import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/core/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/components/app_radio.dart';
import '../../../core/constants/constants.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({
    Key? key,
    required this.label,
    required this.phoneNumber,
    required this.address,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final String phoneNumber;
  final String address;
  final bool isActive;
  final void Function() onTap;

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      child: Material(
        color: widget.isActive
            ? AppColors.coloredBackground
            : AppColors.textInputBackground,
        borderRadius: AppDefaults.borderRadius,
        child: 
        InkWell(
          borderRadius: AppDefaults.borderRadius,
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              borderRadius: AppDefaults.borderRadius,
              border: Border.all(
                color: widget.isActive ? AppColors.primary : Colors.grey,
                width: widget.isActive ? 1 : 0.3,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppRadio(isActive: widget.isActive),
                const SizedBox(width: 18),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.phoneNumber),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
