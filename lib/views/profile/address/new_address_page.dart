import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/models/tools_viewmodel.dart';
import 'package:grocery/views/profile/map_page_2.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_defaults.dart';
import '../../../core/components/app_back_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewAddressPage extends StatefulWidget {
  // static const _position = LatLng(10.77615745855286, 106.66759669033004);
  const NewAddressPage({Key? key}) : super(key: key);

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  final ToolsVM toolsVM = ToolsVM();
  Set<Marker> _markers = HashSet<Marker>();
  static const LatLng point = LatLng(10.762622, 106.660172);
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneCallController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  bool isEnabled = true;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _markers.add(Marker(
        markerId: MarkerId('0'),
        position: point,
        infoWindow: InfoWindow(title: 'AA', snippet: 'Ho Chi Minh City')));

    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'Thêm địa chỉ mới',
        ),
      ),
      body: Consumer<ToolsVM>(
        builder: (context, value, child) {
          _addressController.text = value.shippingAddress;
          return SingleChildScrollView(
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
                  /* <----  Full Name -----> */
                  const Text("Tên riêng"),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDefaults.padding),

                  /* <---- Phone Number -----> */
                  const Text("Số điện thoại"),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDefaults.padding),

                  /* <---- Address Line 1 -----> */
                  const Text("Địa chỉ giao hàng"),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _addressController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    // decoration: InputDecoration(
                    //   labelText: value.shippingAddress,
                    // ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => MapPage2(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'Chọn từ bản đồ',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: AppDefaults.padding),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text(
                        'Lưu',
                        style: TextStyle(fontSize: 19),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
