import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/models/user/changeInfoUser.dart';
import 'package:grocery/core/models/user/user.dart';
import 'package:grocery/core/utils/validators.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/components/app_back_button.dart';
import '../../core/constants/constants.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  // late User user;
  String strUser = '';
  User user = User.userEmpty();
  bool isEditing = true;
  int gender = 0;
  String genderName = 'None';
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController schoolYearController = TextEditingController();
  TextEditingController schoolKeyController = TextEditingController();
  TextEditingController imageURLController =
      TextEditingController(); // Thêm controller cho URL hình ảnh
  TextEditingController genderController = TextEditingController();
  bool isLoading = false;
  final _key = GlobalKey<FormState>();

  Future<void> getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? strUser = pref.getString('user');

    if (strUser != null) {
      setState(() {
        user = User.fromJson(jsonDecode(strUser));
        fullNameController.text = user.fullName!;
        phoneNumberController.text = user.phoneNumber!;
        gender = convertGenderRadio();
        // genderController.text = convertGender();
        birthDayController.text = user.birthDay!;
        schoolYearController.text = user.schoolYear!;
        schoolKeyController.text = user.schoolKey!;
        imageURLController.text =
            user.imageURL ?? ''; // Set giá trị cho URL hình ảnh
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  Future<String> editInfo() async {
    return await APIRepository().changeInfo(ChangeInfoUser(
      numberID: user.idNumber.toString(),
      fullName: fullNameController.text,
      birthDay: birthDayController.text,
      phoneNumber: phoneNumberController.text,
      schoolKey: schoolKeyController.text,
      schoolYear: schoolYearController.text,
      gender: getGender(),
      imageUrl: imageURLController.text,
    ));
  }

  changeInfo() async {
    try {
      Future<String> editInfo() async {
        return await APIRepository().changeInfo(ChangeInfoUser(
          numberID: user.idNumber.toString(),
          fullName: fullNameController.text,
          birthDay: birthDayController.text,
          phoneNumber: phoneNumberController.text,
          schoolKey: schoolKeyController.text,
          schoolYear: schoolYearController.text,
          gender: getGender(),
          imageUrl: imageURLController.text,
        ));
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

  getGender() {
    if (gender == 1) {
      return "Male";
    } else if (gender == 2) {
      return "Female";
    }
    return "Other";
  }

  // convertGender() {
  //   if (user.gender!.contains("Male")) {
  //     return genderController.text = "Nam";
  //   } else if (user.gender!.contains("Female")) {
  //     return genderController.text = "Nữ";
  //   }
  //   return genderController.text = "Khác";
  // }

  convertGenderRadio() {
    if (user.gender!.contains("Male")) {
      return gender = 1;
    } else if (user.gender!.contains("Female")) {
      return gender = 2;
    }
    return gender = 3;
  }

  void pasteImageURL() async {
    // Lấy dữ liệu từ clipboard và gán vào TextEditingController
    ClipboardData? clipboardData =
        await Clipboard.getData(Clipboard.kTextPlain);
    print('Thong tin hinh: ${clipboardData!.text}');
    if (clipboardData != null && clipboardData.text != null) {
      setState(() {
        imageURLController.text = clipboardData.text!;
      });
    }
  }

  void clearImageURL() {
    setState(() {
      imageURLController.text = user.imageURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'Thay đổi thông tin',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          //nút refresh lại trang
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ), // Icon làm mới
            onPressed: () {
              // Xử lý sự kiện khi người dùng nhấn vào nút làm mới
              // Đặt logic làm mới
              setState(() {});
            },
          ),

        ],
      ),
      body: SingleChildScrollView(
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
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* <----  Thay đổi avatar -----> */
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 260.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        // borderRadius: BorderRadius.circular(10.0),
                        shape: BoxShape.circle,
                      ),
                      child: user != null &&
                              user.imageURL != null &&
                              user.imageURL.isNotEmpty
                          ? Image.network(
                              imageURLController.text,
                              fit: BoxFit.contain,
                            )
                          : Center(
                              child: Text(
                                'Chọn hình ảnh từ album hoặc dán đường link ảnh vào đây',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                    ),
                    if (isEditing)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.paste),
                          onPressed: pasteImageURL,
                          tooltip: 'Dán đường link ảnh',
                        ),
                      ),
                    if (isEditing)
                      Positioned(
                        top: 30,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.clear_rounded),
                          onPressed: clearImageURL,
                          tooltip: 'Xóa hình ảnh',
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppDefaults.padding),
                // /* <----  Number ID -----> */
                // const Text(
                //   "ID tài khoản",
                //   style: TextStyle(color: Colors.black),
                // ),
                // const SizedBox(height: 8),
                // TextFormField(
                //   controller: fullNameController,
                //   validator: Validators.required,
                //   textInputAction: TextInputAction.next,
                //   enabled: isEditing,
                // ),
                // const SizedBox(height: AppDefaults.padding),
                /* <----  Họ và tên -----> */
                const Text(
                  "Họ và tên",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: fullNameController,
                  validator: Validators.required,
                  textInputAction: TextInputAction.next,
                  enabled: isEditing,
                ),
                const SizedBox(height: AppDefaults.padding),

                /* <---- Số điện thoại -----> */
                const Text(
                  "Số điện thoại",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: phoneNumberController,
                  textInputAction: TextInputAction.next,
                  validator: Validators.required,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: AppDefaults.padding),

                /* <---- Giới tính -----> */
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
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value!;
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
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value!;
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
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          )),
                    )),
                  ],
                ),
                //   TextFormField(
                //   controller: genderController,
                //   validator: Validators.required,
                //   textInputAction: TextInputAction.next,
                // ),
                const SizedBox(height: AppDefaults.padding),

                /* <---- Ngày sinh -----> */
                const Text(
                  "Ngày sinh",
                  style: TextStyle(color: Colors.black),
                ),
                // const SizedBox(height: 8),
                // TextField(
                //   decoration: InputDecoration(
                //     labelText: 'Chọn ngày',
                //     filled: true,
                //     prefixIcon: Icon(Icons.calendar_today),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.blue),
                //     ),
                //   ),
                //   readOnly: true,
                //   onTap: () {
                //     _selectDate();
                //   },
                // ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: birthDayController,
                  textInputAction: TextInputAction.next,
                  validator: Validators.required,
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: AppDefaults.padding),
                /* <---- Khóa (Ex: 2020,2021,etc....) -----> */
                const Text("Khóa", style: TextStyle(color: Colors.black)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: schoolYearController,
                  textInputAction: TextInputAction.next,
                  validator: Validators.required,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: AppDefaults.padding),
                /* <---- Mã khóa (Ex: K26,K27,K28,etc....) -----> */
                const Text("Mã khóa", style: TextStyle(color: Colors.black)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: schoolKeyController,
                  textInputAction: TextInputAction.next,
                  validator: Validators.required,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: AppDefaults.padding),
                /* <---- Link Avatar -----> */
                const Text("Link avatar",
                    style: TextStyle(color: Colors.black)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: imageURLController,
                  textInputAction: TextInputAction.done,
                  validator: Validators.required,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: AppDefaults.padding),
                /* <---- Nút lưu thay đổi -----> */
                const SizedBox(height: AppDefaults.padding),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          if (isLoading) {
                            return;
                          }
                          setState(
                            () => isLoading = true,
                          );
                          String respone = await editInfo();
                          if (respone == "ok") {
                            print('Đã cập nhật thông tin');
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.scale,
                              title: 'Cập nhật thông tin thành công',
                              desc: 'Vui lòng đăng nhập lại để thông tin\nđược cập nhật trên ứng dụng',
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                              headerAnimationLoop: false,
                              btnOkText: "OK",
                              btnOkColor: Colors.green,
                            ).show();
                            setState(
                              () => isLoading = false,
                            );
                          } else {
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
                      },
                      child: isLoading
                          ? LoadingAnimationWidget.waveDots(
                              color: Colors.white, size: 15)
                          : const Text(
                              'Lưu',
                              style: TextStyle(color: Colors.white),
                            )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
