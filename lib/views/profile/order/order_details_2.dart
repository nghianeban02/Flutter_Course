import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/models/order/order.dart';
import 'package:grocery/core/models/order/orderDetaile.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:grocery/core/models/user/user.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/components/app_back_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_defaults.dart';


class OrderDetails extends StatefulWidget {
  OrderModel orderModel;
  OrderDetails({super.key, required this.orderModel});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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

  bool isOrderPlaced = false; // Trạng thái đơn hàng đã được đặt lại hay chưa
  OrderDetaileModel orderDetailModel = new OrderDetaileModel(
      productId: 1,
      productName: 'Iphone 15',
      imageUrl: 'Null',
      price: 15600000,
      count: 15,
      total: 256000000);
  final List<OrderDetaileModel> lstOrder = [];
  final List<Product> lstCreOrder = [];

  Future<List<OrderDetaileModel>> _getDetaileBills() async {
    // Lấy thông tin product từ API
    List<OrderDetaileModel> lst =
        await APIRepository().getDetaileBill(widget.orderModel.id);

    // Tạo danh sách mới để tránh thay đổi lstCreOrder trong hàm này
    List<Product> updatedList = [];

    // Duyệt qua từng phần tử trong lst và thêm vào updatedList
    lst.forEach((orderDetail) {
      updatedList
          .add(Product(id: orderDetail.productId, quantity: orderDetail.count));
    });

    // Thêm updatedList vào lstCreOrder
    lstCreOrder.addAll(updatedList);

    return lst;
  }

  void _resetOrder(BuildContext context) async {
    // Thực hiện hành động đặt lại đơn hàng
    // Đây là nơi bạn có thể thực hiện các tác vụ như gửi yêu cầu đặt lại đơn hàng đến máy chủ, cập nhật trạng thái, v.v.
    // Sau khi hoàn thành, bạn có thể chuyển người dùng đến màn hình mới hoặc cập nhật lại dữ liệu
    // Ví dụ: Navigator.push(context, MaterialPageRoute(builder: (context) => NewOrderPage()));
    bool check = await APIRepository().addBill(lstCreOrder);
    if (check == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        content: Text(
          'Đặt lại đơn hàng thành công!',
          style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          maxLines: 2,
        ),
        duration: Duration(seconds: 2),
      ));
      setState(() {
        isOrderPlaced = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text(
          'Đặt lại đơn hàng không thành công!',
          style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          maxLines: 2,
        ),
        duration: Duration(seconds: 2),
      ));
    }
  }

  // Thực hiện gọi API sau khi nhận được id tham số đầu vào
  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Chi tiết đơn hàng'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(AppDefaults.margin),
          padding: const EdgeInsets.all(AppDefaults.padding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppDefaults.borderRadius,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Mã đơn hàng",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "#${widget.orderModel.id.length > 30 ? widget.orderModel.id.substring(0, 30) + '' : widget.orderModel.id}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              const Divider(),
              const SizedBox(height: AppDefaults.padding),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ngày đặt",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.orderModel.dateCreated,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              const SizedBox(height: AppDefaults.padding),
              const Divider(),
              strUser.isEmpty
                  ? Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                          color: Colors.green, size: 50),
                    )
                  : Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Thông tin đơn hàng",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                user.fullName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                user.phoneNumber!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "828 Sư Vạn Hạnh,P.13,Q.10,TP.HCM",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              const SizedBox(height: AppDefaults.padding),
              const Divider(),
              _buildOrderList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context) {
    return FutureBuilder<List<OrderDetaileModel>>(
      future: _getDetaileBills(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(
                color: Colors.green, size: 50),
          );
        }
        double totalPrice =
            snapshot.data!.fold(0, (sum, item) => sum + item.total);
        lstOrder.addAll(snapshot.data!);
        return Padding(
          padding: const EdgeInsets.all(1),
          child: Column(
            children: [
              //Thông tin đơn hàng
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Chi tiết sản phẩm',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final order = snapshot.data![index];
                  return ListTile(
                    leading: Image.network(
                      order.imageUrl!,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, StackTrace) =>
                          const Icon(Icons.image),
                    ),
                    title: Text(order.productName),
                    subtitle: Text(
                      'Số lượng: ${order.count}\nGiá: ${NumberFormat('###,###.### ₫').format(order.price)}',
                      textAlign: TextAlign.end,
                    ),
                  );
                },
              ),
              const Divider(),

              //Thông tin tổng tiền đơn hàng & phương thức thanh toán
              Padding(
                padding: const EdgeInsets.all(3),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Tổng tiền đơn hàng',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                        const Spacer(),
                        Text(
                          NumberFormat('###,###.### ₫').format(totalPrice),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Phương thức thanh toán',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                        const Spacer(),
                        Text(
                          'Thanh toán\nkhi nhận hàng',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 10),

              //Button đặt lại đơn hàng
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nút Mua lại
                  ElevatedButton.icon(
                    icon: isOrderPlaced
                        ? Icon(Icons.check, size: 24)
                        : const Icon(Icons.shopping_cart,
                            size: 24), // Kích thước icon
                    label: isOrderPlaced
                        ? Text("Đã đặt lại", style: TextStyle(fontSize: 16))
                        : const Text("Mua lại",
                            style: TextStyle(fontSize: 16)), // Kích thước chữ
                    onPressed: () {
                      // Hành động khi nút được nhấn

                      if (isOrderPlaced == false) {
                        _resetOrder(context);
                        print('Bạn vừa nhấn mua lại');
                      } else
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text(
                            'Đơn hàng của bạn đã được thêm mới\nVui lòng kiểm tra lại!',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          duration: Duration(seconds: 2),
                        ));
                      ;
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // Màu chữ và icon
                      minimumSize:
                          const Size(150, 50), // Kích thước tối thiểu của nút
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10), // Padding bên trong nút
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
