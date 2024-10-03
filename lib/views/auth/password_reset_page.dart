import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/routes/app_routes.dart';
import 'package:grocery/core/utils/validators.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/components/app_back_button.dart';
import '../../core/constants/constants.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  bool _isLoading = false;
  final _key = GlobalKey<FormState>();
  TextEditingController _accountIdController = TextEditingController();
  TextEditingController _numberIdController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _CofirmPasswordController = TextEditingController();
  bool isPasswordShown = false;
  bool isConfirmPasswordShown = false;

  Future<void> _resetPassword() async {
    String accountId = _accountIdController.text;
    String numberId = _numberIdController.text;
    String newPassword = _newPasswordController.text;

    print('Thông tin tài khoản: $accountId, $numberId, $newPassword');
    // Set isLoading to true để hiển thị circular progress indicator
    setState(() {
      _isLoading = true;
    });

    // Gọi API reset password ở đây
    try {
      await Future.delayed(Duration(seconds: 2)); // Giả lập API đang xử lý
      bool check = await APIRepository()
          .forgotPassword(accountId, numberId, newPassword);
      // Set isLoading to false khi nhận được phản hồi từ API
      if (check) {
        setState(() {
          _isLoading = false;
        });
        print('Đặt lại mật khẩu thành công!');
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          title: 'Đặt lại mật khẩu thành công',
          btnOkOnPress: () {
            Navigator.pushNamed(context, AppRoutes.login);
          },
          headerAnimationLoop: false,
          btnOkText: "Đăng nhập",
        ).show();
      } else {
        print('Đặt lại mật khẩu thất bại!');
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'Đã xảy ra lỗi',
          desc: 'Vui lòng kiểm tra lại thông tin',
          btnOkOnPress: () {},
          headerAnimationLoop: false,
          btnOkText: "OK",
          btnOkColor: Colors.red,
        ).show();
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Đã xảy ra lỗi',
        desc: 'Vui lòng kiểm tra lại thông tin',
        btnOkOnPress: () {},
        headerAnimationLoop: false,
        btnOkText: "OK",
        btnOkColor: Colors.red,
      ).show();
      setState(() {
        _isLoading = false;
      });
    }

    // Xử lý phản hồi từ API, ví dụ:
    // if (response.statusCode == 200) {
    //   // Xử lý khi reset password thành công
    // } else {
    //   // Xử lý khi reset password thất bại
    // }
  }

  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  onConfirmPassShowClicked() {
    isConfirmPasswordShown = !isConfirmPasswordShown;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Đặt lại mật khẩu'),
        backgroundColor: AppColors.scaffoldBackground,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(AppDefaults.margin),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDefaults.padding,
                    vertical: AppDefaults.padding * 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppDefaults.borderRadius,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Đặt lại mật khẩu',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppDefaults.padding * 3),
                      const Text("Tên tài khoản"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _accountIdController,
                        validator: Validators.required,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: AppDefaults.padding * 3),
                      const Text("Number ID"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _numberIdController,
                        validator: Validators.required,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: AppDefaults.padding * 3),
                      const Text("Mật khẩu mới"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _newPasswordController,
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !isPasswordShown,
                        decoration: InputDecoration(
                          suffixIcon: Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: onPassShowClicked,
                              icon: SvgPicture.asset(
                                AppIcons.eye,
                                width: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("Xác nhận mật khẩu"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _CofirmPasswordController,
                        validator: Validators.required,
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !isConfirmPasswordShown,
                        onFieldSubmitted: (value) {
                          if (_key.currentState!.validate()) {
                            if (_newPasswordController.text !=
                                _CofirmPasswordController.text) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.scale,
                                title: 'Mật khẩu không trùng khớp',
                                desc:
                                    'Vui lòng kiểm tra lại mật khẩu mới\nvà nhập lại mật khẩu',
                                btnOkOnPress: () {},
                                headerAnimationLoop: false,
                                btnOkText: "OK",
                                btnOkColor: Colors.green,
                              ).show();
                              setState(
                                () => _isLoading = false,
                              );
                            } else {
                              if (_isLoading) return;
                              setState(
                                () => _isLoading = true,
                              );
                              _resetPassword();
                            }
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: onConfirmPassShowClicked,
                              icon: SvgPicture.asset(
                                AppIcons.eye,
                                width: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDefaults.padding * 2),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              if (_newPasswordController.text !=
                                  _CofirmPasswordController.text) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.scale,
                                  title: 'Mật khẩu không trùng khớp',
                                  desc:
                                      'Vui lòng kiểm tra lại mật khẩu mới\nvà nhập lại mật khẩu',
                                  btnOkOnPress: () {},
                                  headerAnimationLoop: false,
                                  btnOkText: "OK",
                                  btnOkColor: Colors.green,
                                ).show();
                                setState(
                                  () => _isLoading = false,
                                );
                              } else {
                                if (_isLoading) return;
                                setState(
                                  () => _isLoading = true,
                                );
                                _resetPassword();
                              }
                            }
                          },
                          child: _isLoading
                              ? LoadingAnimationWidget.waveDots(
                                  color: Colors.white, size: 35)
                              : const Text('Đổi mật khẩu'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
