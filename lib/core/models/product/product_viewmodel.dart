import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery/core/models/product/product.dart';

class ProductVM with ChangeNotifier {
  List<Product> lst = [];
  List<Product> lstFavorite = [];

  // Hàm thêm sản phẩm vào danh sách yêu thích
  void addOrRemoveFavorites(Product product) {
    // Kiểm tra xem sản phẩm đã tồn tại trong danh sách yêu thích chưa
    bool isExisting = lstFavorite.any((element) => element.id == product.id);

    // Nếu sản phẩm chưa tồn tại trong danh sách yêu thích, thêm vào
    if (!isExisting) {
      lstFavorite.add(product);
      // notifyListeners();
    } else {
      lstFavorite.removeWhere((element) => element.id == product.id);
    }
    notifyListeners();
  }

  // Hàm xóa danh sách yêu thích
  void removeFavorite(Product product) {
    // Kiểm tra xem sản phẩm đã tồn tại trong danh sách yêu thích chưa
    bool isExisting = lstFavorite.any((element) => element.id == product.id);
    // Nếu sản phẩm chưa tồn tại trong danh sách yêu thích, thêm vào
    if (isExisting) {
      lstFavorite.remove(product);
      notifyListeners();
    }
  }

  // thêm 1 item vào danh sách
  bool add(Product pro) {
    // Check if the product already exists in the cart
    final existingProductIndex =
        lst.indexWhere((product) => product.id == pro.id);

    if (existingProductIndex != -1) {
      // If product already exists, update its quantity
      lst[existingProductIndex].quantity =
          lst[existingProductIndex].quantity! + 1;
    } else {
      // If product doesn't exist, add it to the cart
      lst.add(pro);
      return true;
    }
    notifyListeners();
    return true;
  }

  //xóa vị trí
  // del(int index) {
  //   lst.removeAt(index);
  //   notifyListeners();
  // }

  // Function to remove a product from the cart
  remove(Product pro) {
    // Check if the product exists in the cart
    final existingProductIndex =
        lst.indexWhere((product) => product.id == pro.id);

    if (existingProductIndex != -1) {
      // If product exists, decrease its quantity
      if (lst[existingProductIndex].quantity! > 1) {
        lst[existingProductIndex].quantity =
            lst[existingProductIndex].quantity! - 1;
      } else {
        // If quantity is already 1, remove the product from the cart
        lst.removeAt(existingProductIndex);
      }
      notifyListeners();
    }
  }

  // hàm xóa nếu người dùng bấm vào nút thùng rác trong giỏ hàng
  bool removeTrash(Product pro) {
    // Check if the product exists in the cart
    final existingProductIndex =
        lst.indexWhere((product) => product.id == pro.id);

    if (existingProductIndex != -1) {
      // If quantity is already 1, remove the product from the cart
      lst.removeAt(existingProductIndex);
      notifyListeners();
      return true;
    }
    return false;
  }

// Function to calculate total quantity of products in the cart
  int getTotalQuantity() {
    int totalQuantity = 0;
    lst.forEach((product) {
      totalQuantity += product.quantity!;
    });
    return totalQuantity;
  }

  // Function to calculate total price of products in the cart
  double getTotalPrice() {
    double totalPrice = 0;
    lst.forEach((product) {
      totalPrice += (product.price! * product.quantity!);
    });
    return totalPrice;
  }

  del(int id) {
    // Remove product with matching id from the list
    lst.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  deleteAll() {
    lst.clear();
    notifyListeners();
  }
}
