import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/constants/app_defaults.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/models/order/order.dart';
import 'package:grocery/views/home/order_empty.dart';
import 'package:grocery/views/profile/order/order_details_2.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/components/app_back_button.dart';

class AllOrderPage extends StatefulWidget {
  const AllOrderPage({Key? key}) : super(key: key);

  @override
  State<AllOrderPage> createState() => _AllOrderPageState();
}

class _AllOrderPageState extends State<AllOrderPage> {
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
    // Lấy thông tin hóa đơn từ API
    List<OrderModel> bills = await APIRepository().getBill();

    //Sắp xếp hóa đơn theo ngày tạo hóa đơn
    bills.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
    return bills;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Đơn hàng của tôi'),
        //nút refresh lại trang
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ), // Icon làm mới
            onPressed: () {
              // Xử lý sự kiện khi người dùng nhấn vào nút làm mới
              // Đặt logic làm mới danh sách đơn hàng ở đây
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: _getBills(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.green, size: 50),
            );
          } else {
            //báo lỗi nếu hệ thống trả về lỗi
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
            //nếu danh sách rỗng trả về trang thông báo rỗng
            else if (snapshot.data!.isEmpty) {
              return OrderEmpty();
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
      ),
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
                          '#${order.id.length > 5 ? order.id.substring(0, 5) + '...' : order.id}',
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
                    Row(
                      children: [
                        const Text('Giá:'),
                        const SizedBox(width: 5),
                        //hiển thị mã đơn hàng
                        Text(
                          NumberFormat('###,###.### ₫').format(order.total),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
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
