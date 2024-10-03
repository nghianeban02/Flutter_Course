import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/constants/app_defaults.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/models/order/order.dart';
import 'package:grocery/views/profile/order/order_details_2.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class AllTab extends StatefulWidget {
  const AllTab({
    Key? key,
  }) : super(key: key);

  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  Future<List<OrderModel>> _getOrderHistory() async {
    // thêm vào 1 dòng dữ liệu nếu getdata không có hoặc chưa có database
    //return await _databaseHelper.categories();
    // Lấy danh sác category từ API
    return await APIRepository().getBill();
  }

  List<OrderModel> orders = [];

  @override
  void initState() {
    // TODO: implement initState
    _getOrderHistory();
    super.initState();
  }

  Future<List<OrderModel>> _getBills() async {
    // Lấy thông tin product từ API
    return await APIRepository().getBill();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderModel>>(
      future: _getBills(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(
                color: Colors.green, size: 50),
          );
        } else {
          if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Text(
                'Đã có lỗi xảy ra! Vui lòng thử lại',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              duration: Duration(seconds: 2),
            ));
          }
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                return orderItemTile(order, context);
              },
            ),
          );
        }
      },
    );
  }

  Widget orderItemTile(OrderModel order, BuildContext context) {
    return FutureBuilder<List<OrderModel>>(
      future: _getOrderHistory(),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
            vertical: AppDefaults.padding / 2,
          ),
          child: Material(
            color: Colors.white,
            borderRadius: AppDefaults.borderRadius,
            child: InkWell(
              onTap: () {
                print('Bạn vừa chọn hóa đơn ${order.id}');
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => OrderDetails(
                            orderModel: order,
                          )),
                ).then((value) {
                  if (value == true) {
                    // Nếu giá trị trả về là true, thực hiện cập nhật giao diện ở đây
                    setState(() {
                      print('đã cập nhật');
                      // Cập nhật lại danh sách đơn hàng
                      setState(() {});
                    });
                  }
                });
              },
              borderRadius: AppDefaults.borderRadius,
              child: Container(
                padding: const EdgeInsets.all(AppDefaults.padding),
                decoration: BoxDecoration(
                  borderRadius: AppDefaults.borderRadius,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Mã đơn hàng:'),
                        const SizedBox(width: 5),
                        //hiển thị mã đơn hàng
                        Text(
                          '${order.id.length > 5 ? order.id.substring(0, 5) + '...' : order.id}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        const Spacer(),
                        //hiển thị ngày đặt
                        Text(order.dateCreated),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Nút xóa hóa đơn
                          Container(
                            width: 145,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.red, // Màu nền của nút
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(0, 3), // Đổ bóng
                                ),
                              ],
                            ),
                            child: TextButton(
                              onPressed: () async {
                                // Xử lý logic khi nút được nhấn
                                // Ví dụ: Xóa hóa đơn
                                print('Bạn vừa chọn xóa hóa đơn');
                                bool check =
                                    await APIRepository().deleteBill(order.id);
                                if (check) {
                                  setState(() {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        'Hóa đơn "${order.id.length > 5 ? order.id.substring(0, 5) + '...' : order.id}" đã xóa thành công!',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                      ),
                                      duration: Duration(seconds: 2),
                                    ));
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      'Đã có lỗi xảy ra! Vui lòng rhử lại',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                    ),
                                    duration: Duration(seconds: 2),
                                  ));
                                }
                              },
                              child: const Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Xóa hóa đơn',
                                      style: TextStyle(
                                          color: Colors.white, // Màu chữ
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
