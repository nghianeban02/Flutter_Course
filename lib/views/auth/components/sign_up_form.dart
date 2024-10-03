import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/models/user/register.dart';
import 'package:grocery/core/routes/app_routes.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/validators.dart';
import 'already_have_accout.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _key = GlobalKey<FormState>();
  int _gender = 0;
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _schoolKeyController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _imageURL = TextEditingController();
  String gendername = 'None';
  String temp = '';
  bool isLoading = false;
  bool isPasswordShown = false;
  bool isConfirmPasswordShown = false;

  Future<String> register() async {
    return await APIRepository().register(Signup(
        accountID: _accountController.text,
        birthDay: _birthDayController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        fullName: _fullNameController.text,
        phoneNumber: _phoneNumberController.text,
        schoolKey: _schoolKeyController.text,
        schoolYear: _schoolYearController.text,
        gender: getGender(),
        imageUrl: _imageURL.text,
        numberID: _numberIDController.text));
  }

  signUp() async {
    try {
      Future<String> register() async {
        return await APIRepository().register(Signup(
            accountID: _accountController.text,
            birthDay: _birthDayController.text,
            password: _passwordController.text,
            confirmPassword: _confirmPasswordController.text,
            fullName: _fullNameController.text,
            phoneNumber: _phoneNumberController.text,
            schoolKey: _schoolKeyController.text,
            schoolYear: _schoolYearController.text,
            gender: getGender(),
            imageUrl: _imageURL.text,
            numberID: _numberIDController.text));
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });

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
    }
  }

  void isSignUp() async {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  getGender() {
    if (_gender == 1) {
      return "Male";
    } else if (_gender == 2) {
      return "Female";
    }
    return "Other";
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
    return Container(
      margin: const EdgeInsets.all(AppDefaults.margin),
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppDefaults.boxShadow,
        borderRadius: AppDefaults.borderRadius,
      ),
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tên tài khoản",
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _accountController,
              validator: Validators.required,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text(
              "ID tài khoản",
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _numberIDController,
              validator: Validators.required,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text(
              "Họ và tên",
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _fullNameController,
              validator: Validators.required,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Mật khẩu", style: TextStyle(color: Colors.black)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
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
            const Text("Nhập lại mật khẩu",
                style: TextStyle(color: Colors.black)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _confirmPasswordController,
              validator: (v) =>
                  MatchValidator(errorText: 'Mật khẩu không trùng khớp')
                      .validateMatch(v as String, _passwordController.text),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              obscureText: !isConfirmPasswordShown,
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

            const SizedBox(height: AppDefaults.padding),
            const Text("Số điện thoại", style: TextStyle(color: Colors.black)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneNumberController,
              textInputAction: TextInputAction.next,
              validator: Validators.required,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Ngày sinh", style: TextStyle(color: Colors.black)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _birthDayController,
              textInputAction: TextInputAction.next,
              validator: Validators.required,
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Giới tính", style: TextStyle(color: Colors.black)),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text("Nam"),
                    leading: Transform.translate(
                        offset: const Offset(16, 0),
                        child: Radio(
                          value: 1,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        )),
                  ),
                ),
                Expanded(
                  child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Nữ"),
                      leading: Transform.translate(
                        offset: const Offset(16, 0),
                        child: Radio(
                          value: 2,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      )),
                ),
                Expanded(
                    child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Khác"),
                  leading: Transform.translate(
                      offset: const Offset(16, 0),
                      child: Radio(
                        value: 3,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      )),
                )),
              ],
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Khóa", style: TextStyle(color: Colors.black)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _schoolYearController,
              textInputAction: TextInputAction.next,
              validator: Validators.required,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Mã khóa", style: TextStyle(color: Colors.black)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _schoolKeyController,
              textInputAction: TextInputAction.next,
              validator: Validators.required,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: AppDefaults.padding),

            const Text("Link avatar", style: TextStyle(color: Colors.black)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _imageURL,
              textInputAction: TextInputAction.done,
              validator: Validators.required,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: AppDefaults.padding),
            // const SizedBox(height: AppDefaults.padding),
            // const SignUpButton(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppDefaults.padding * 2),
              child: Row(
                children: [
                  Text(
                    'Đăng ký',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        if (_phoneNumberController.text.length < 10 ||
                            _phoneNumberController.text.length > 10) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.scale,
                            title: 'Lỗi',
                            desc: 'Số điện thoại của bạn phải đủ 10 số',
                            btnOkOnPress: () {},
                            headerAnimationLoop: false,
                            btnOkText: "OK",
                            btnOkColor: Colors.green,
                          ).show();
                          setState(
                            () => isLoading = false,
                          );
                        } else {
                          String respone = await register();
                          if (respone == "ok") {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.scale,
                              title: 'Đăng ký thành công',
                              desc:
                                  'Chúc mừng bạn đã đăng ký tài khoản thành công!',
                              btnOkOnPress: () {
                                Navigator.pushNamed(context, AppRoutes.login);
                              },
                              headerAnimationLoop: false,
                              btnOkText: "Đăng nhập",
                              btnOkColor: Colors.green,
                            ).show();
                            setState(
                              () => isLoading = false,
                            );
                          }
                          // else if (respone == "error duplicate") {
                          //   print(respone);
                          //   AwesomeDialog(
                          //     context: context,
                          //     dialogType: DialogType.error,
                          //     animType: AnimType.scale,
                          //     title: 'Lỗi tồn tại thông tin',
                          //     desc:
                          //         'Vui lòng kiểm tra lại thông tin\nTên tài khoản, ID tài khoản, số điện thoại',
                          //     btnOkOnPress: () {},
                          //     headerAnimationLoop: false,
                          //     btnOkText: "OK",
                          //     btnOkColor: Colors.red,
                          //   ).show();
                          //   setState(
                          //     () => isLoading = false,
                          //   );
                          // }
                          else {
                            print(respone);
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
                            setState(
                              () => isLoading = false,
                            );
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(elevation: 1),
                    child: SvgPicture.asset(
                      AppIcons.arrowForward,
                      // ignore: deprecated_member_use
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const AlreadyHaveAnAccount(),
            const SizedBox(height: AppDefaults.padding),
          ],
        ),
      ),
    );
  }
}
