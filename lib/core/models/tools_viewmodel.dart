import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToolsVM with ChangeNotifier {
  List<String> lst = [];
  String shippingAddress = '';

  // Hàm thêm từ khóa tìm kiếm vào danh sách
  void addSearchResult(String name) {
    // Kiểm tra từ khóa đã tồn tại trong danh sách hay chưa?
    bool isExisting = lst.any((element) => lst.contains(name),);

    // Nếu chưa tồn tại, thêm vào
    if (!isExisting) {
      lst.add(name);
      // notifyListeners();
    } else {
    }
    notifyListeners();
  }

  // Hàm thêm địa chỉ giao hàng
  void addShipAddress(String address) {
    // Kiểm tra địa chỉ đã tồn tại chưa?
    bool isExisting = shippingAddress.contains(address);

    // Nếu chưa tồn tại, thêm vào
    if (!isExisting) {
      shippingAddress = address;
      // notifyListeners();
    } else {
    }
    notifyListeners();
  }
}
