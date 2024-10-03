import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/utils/validators.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/components/app_back_button.dart';
import '../../../core/constants/constants.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool isOldPasswordShown = false;
  bool isNewPasswordShown = false;
  bool isConfirmPasswordShown = false;
  bool _isLoading = false;

  Future<void> changePass() async {
    bool check = await APIRepository()
        .changePassword(_oldPasswordController.text, _passwordController.text);

    setState(() {
      _isLoading = true;
    });
    if (check) {
      print('Cập nhật mật khẩu thành công');
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Cập nhật mật khẩu\nthành công',
        btnOkOnPress: () {},
        headerAnimationLoop: false,
        btnOkText: "OK",
      ).show();
      setState(
        () => isLoading = false,
      );
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Đã xảy ra lỗi',
        desc: 'Vui lòng kiểm tra lại mật khẩu hiện tại',
        btnOkOnPress: () {},
        headerAnimationLoop: false,
        btnOkText: "OK",
        btnOkColor: Colors.red,
      ).show();
      setState(
        () => isLoading = false,
      );
    }
  }

  onOldPassShowClicked() {
    isOldPasswordShown = !isOldPasswordShown;
    setState(() {});
  }

  onNewPassShowClicked() {
    isNewPasswordShown = !isNewPasswordShown;
    setState(() {});
  }

  onConfirmPassShowClicked() {
    isConfirmPasswordShown = !isConfirmPasswordShown;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'Thay đổi mật khẩu',
        ),
      ),
      backgroundColor: AppColors.cardColor,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* <----  Current Password -----> */
                  const Text("Nhập mật khẩu cũ:"),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _oldPasswordController,
                    validator: Validators.required,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isOldPasswordShown,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: onOldPassShowClicked,
                        icon: SvgPicture.asset(
                          AppIcons.eye,
                        ),
                      ),
                      suffixIconConstraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(height: AppDefaults.padding),

                  /* <---- New Password -----> */
                  const Text("Nhập mật khẩu mới:"),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: Validators.required,
                    textInputAction: TextInputAction.next,
                    obscureText: !isNewPasswordShown,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: onNewPassShowClicked,
                        icon: SvgPicture.asset(
                          AppIcons.eye,
                        ),
                      ),
                      suffixIconConstraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(height: AppDefaults.padding),

                  /* <---- Confirm Password-----> */
                  const Text("Nhập lại mật khẩu:"),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (v) => MatchValidator(
                            errorText: 'Mật khẩu không trùng khớp')
                        .validateMatch(v as String, _passwordController.text),
                    textInputAction: TextInputAction.done,
                    obscureText: !isConfirmPasswordShown,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: onConfirmPassShowClicked,
                        icon: SvgPicture.asset(
                          AppIcons.eye,
                        ),
                      ),
                      suffixIconConstraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(height: AppDefaults.padding),

                  /* <---- Submit -----> */
                  const SizedBox(height: AppDefaults.padding),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (isLoading) return;
                          setState(
                            () => isLoading = true,
                          );
                          changePass();
                        }
                      },
                      child: isLoading
                          ? LoadingAnimationWidget.waveDots(
                              color: Colors.white, size: 20)
                          : const Text('Lưu thay đổi'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
