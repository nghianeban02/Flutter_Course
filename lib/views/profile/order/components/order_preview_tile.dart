import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/data/api.dart';
import 'package:grocery/core/models/order/order.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/enums/dummy_order_status.dart';

class OrderPreviewTile extends StatefulWidget {
  const OrderPreviewTile({
    Key? key,
    required this.orderID,
    required this.date,
    required this.status,
    required this.onTap,
  }) : super(key: key);

  final String orderID;
  final String date;
  final OrderStatus status;
  final void Function() onTap;

  @override
  State<OrderPreviewTile> createState() => _OrderPreviewTileState();
}

class _OrderPreviewTileState extends State<OrderPreviewTile> {
  Future<List<OrderModel>> _getOrderHistory() async {
    // thêm vào 1 dòng dữ liệu nếu getdata không có hoặc chưa có database
    //return await _databaseHelper.categories();
    // Lấy danh sác category từ API
    return await APIRepository().getBill();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: AppDefaults.borderRadius,
        child: InkWell(
          onTap: widget.onTap,
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
                    Text(
                      '2324252627',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.black),
                    ),
                    const Spacer(),
                    const Text('1/4/2024'),
                  ],
                ),
                Row(
                  children: [
                    const Text('Tình trạng'),
                    Expanded(
                      child: RangeSlider(
                        values: RangeValues(0, _orderSliderValue()),
                        max: 3,
                        divisions: 3,
                        onChanged: (v) {},
                        activeColor: _orderColor(),
                        inactiveColor: AppColors.placeholder.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Opacity(
                            opacity:
                                widget.status == OrderStatus.confirmed ? 1 : 0,
                            child: Text(
                              'Đã xác nhận',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: _orderColor()),
                            ),
                          ),
                          Opacity(
                            opacity:
                                widget.status == OrderStatus.processing ? 1 : 0,
                            child: Text(
                              'Đang xử lý',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: _orderColor()),
                            ),
                          ),
                          Opacity(
                            opacity:
                                widget.status == OrderStatus.shipped ? 1 : 0,
                            child: Text(
                              'Đang giao',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: _orderColor()),
                            ),
                          ),
                          Opacity(
                            opacity: widget.status == OrderStatus.delivery ||
                                    widget.status == OrderStatus.cancelled
                                ? 1
                                : 0,
                            child: Text(
                              widget.status == OrderStatus.delivery
                                  ? 'Đã giao'
                                  : 'Đã hủy',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: _orderColor()),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _orderSliderValue() {
    switch (widget.status) {
      case OrderStatus.confirmed:
        return 0;
      case OrderStatus.processing:
        return 1;
      case OrderStatus.shipped:
        return 2;
      case OrderStatus.delivery:
        return 3;
      case OrderStatus.cancelled:
        return 3;

      default:
        return 0;
    }
  }

  Color _orderColor() {
    switch (widget.status) {
      case OrderStatus.confirmed:
        return const Color(0xFF4044AA);
      case OrderStatus.processing:
        return const Color(0xFF41A954);
      case OrderStatus.shipped:
        return const Color(0xFFE19603);
      case OrderStatus.delivery:
        return const Color(0xFF41AA55);
      case OrderStatus.cancelled:
        return const Color(0xFFFF1F1F);

      default:
        return Colors.red;
    }
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
              onTap: () {},
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
                          '${order.id.length > 23 ? order.id.substring(0, 23) + '...' : order.id}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        const Spacer(),
                        //hiển thị ngày đặt
                        Text(order.dateCreated),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Nút xóa hóa đơn
                              Container(
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
                                    bool check = await APIRepository()
                                        .deleteBill(order.id);
                                    if (check) {
                                      setState(() {});
                                    } else {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.scale,
                                        title: 'Không thể xóa',
                                        desc: 'Vui lòng kiểm tra lại server!',
                                        btnOkOnPress: () {},
                                        headerAnimationLoop: false,
                                        btnOkText: "Đóng",
                                      ).show();
                                    }
                                  },
                                  child: const Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.white, // Màu icon
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
