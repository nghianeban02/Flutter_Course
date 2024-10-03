// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery/core/models/user/user.dart';
import 'package:grocery/core/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

//khai báo thêm biến token khi save user để tránh bị null token khi getList
Future<bool> saveUser(User objUser,String token) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? check = prefs.getString('user');
    if (check != null) {
      prefs.setString('user', '');
      prefs.setString('authToken', '');
    }
    String strUser = jsonEncode(objUser);
    prefs.setString('user', strUser);
    prefs.setString('authToken', token);
    print("Lưu phiên login thành công: $strUser");
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> logOut(BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', '');
    print("Logout thành công");
    Navigator.pushNamed(context, AppRoutes.introLogin);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

//
Future<User> getUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String strUser = pref.getString('user')!;
  return User.fromJson(jsonDecode(strUser));
}

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  //error 
  String check = pref.getString('authToken')!;
  return check;
}