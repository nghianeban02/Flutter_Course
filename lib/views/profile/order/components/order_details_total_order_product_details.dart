import 'package:flutter/material.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/models/order/order.dart';
import 'package:grocery/core/models/order/orderDetaile.dart';
import 'package:grocery/core/models/product/product.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/constants/constants.dart';

class TotalOrderProductDetails extends StatefulWidget {
  OrderModel orderModel;
  TotalOrderProductDetails({super.key, required this.orderModel});

  @override
  State<TotalOrderProductDetails> createState() =>
      _TotalOrderProductDetailsState();
}

class _TotalOrderProductDetailsState extends State<TotalOrderProductDetails> {
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

  // Thực hiện gọi API sau khi nhận được id tham số đầu vào
  @override
  void initState() {
    // lstOrder.add(orderDetaileModel);
    // lstOrder.add(orderDetaileModel);
    // TODO: implement initState
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return _buildOrderList(context);
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
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Column(
            children: [
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
              // ListView.separated(
              //   itemBuilder: (context, index) {
              //     return OrderDetailsProductTile(data: Dummy.products[0]);
              //   },
              //   separatorBuilder: (context, index) => const Divider(
              //     thickness: 0.2,
              //   ),
              //   itemCount: 1,
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              // ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final order = snapshot.data![index];
                  return ListTile(
                    leading: Image.network(
                      order.imageUrl!,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, StackTrace) =>
                          Icon(Icons.image),
                    ),
                    title: Text(order.productName),
                    subtitle: Text(
                      'Số lượng: ${order.count}\nGiá: ${NumberFormat('###,###.### ₫').format(order.price)}',
                      textAlign: TextAlign.end,
                    ),
                  );
                },
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thành tiền: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      NumberFormat('###,###.### ₫').format(totalPrice),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
