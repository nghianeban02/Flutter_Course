import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/data/sharepre.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/app_themes.dart';
import '../../../core/utils/validators.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final _key = GlobalKey<FormState>();
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool idEmpty = false;
  bool passEmpty = false;
  bool isPasswordShown = false;
  String token = '';

  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  onLogin() async {
    try {
      token = await APIRepository()
          .login(accountController.text, passwordController.text);
      var user = await APIRepository().current(token);
      setState(() {
        isLoading = true;
      });

      // tải hiệu ứng chờ loading
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });
      });
      // save share
      saveUser(user, token);
      //
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const Mainpage()));
      // Navigator.pushNamed(context, AppRoutes.entryPoint);
      return token;
    } catch (error) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Đăng nhập không thành công!\nVui lòng kiểm tra lại.',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phone Field
              const Text("Tên tài khoản"),
              const SizedBox(height: 8),
              TextFormField(
                controller: accountController,
                keyboardType: TextInputType.text,
                validator: Validators.requiredWithFieldName(
                    'Vui lòng nhập tên tài khoản'),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppDefaults.padding),

              // Password Field
              const Text("Mật khẩu"),
              const SizedBox(height: 8),
              TextFormField(
                controller: passwordController,
                validator: Validators.password,
                onFieldSubmitted: (value) async {
                  if (_key.currentState?.validate() == true) {
                    if (isLoading) return;
                    setState(
                      () => isLoading = true,
                    );
                    String response = await onLogin();
                    if (response == token) {
                      Navigator.pushNamed(context, AppRoutes.entryPoint);
                      setState(
                        () => isLoading = false,
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("Alert"),
                              content: SingleChildScrollView(
                                child: Text(
                                    "Please check your information again!"),
                              ),
                            );
                          });
                      setState(
                        () => isLoading = false,
                      );
                    }
                  }
                },
                textInputAction: TextInputAction.go,
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

              // Forget Password labelLarge
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.passwordReset);
                  },
                  child: const Text('Quên mật khẩu?'),
                ),
              ),

              // Login labelLarge
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState?.validate() == true) {
                      if (isLoading) return;
                      setState(
                        () => isLoading = true,
                      );
                      String response = await onLogin();
                      if (response == token) {
                        Navigator.pushNamed(context, AppRoutes.entryPoint);
                        setState(
                          () => isLoading = false,
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Text("Alert"),
                                content: SingleChildScrollView(
                                  child: Text(
                                      "Please check your information again!"),
                                ),
                              );
                            });
                        setState(
                          () => isLoading = false,
                        );
                      }
                    }
                  },
                  child: isLoading
                      ? LoadingAnimationWidget.waveDots(
                          color: Colors.white, size: 25)
                      : const Text(
                          'Đăng nhập',
                          style: TextStyle(fontSize: 20),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
