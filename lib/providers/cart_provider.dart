import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final int price;
  final String image;
  final String color; // Trường màu
  int quantity;
  bool selected; // ĐÃ THÊM: trạng thái được chọn để thanh toán

  CartItem({
    required this.name,
    required this.price,
    this.image = '',
    this.color = '', // Mặc định là chuỗi rỗng
    this.quantity = 1,
    this.selected = true, // Mặc định khi thêm vào giỏ là đang được chọn
  });

  int get totalPrice => price * quantity;
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  int get totalQuantity =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  int get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

  // ĐÃ THÊM: danh sách sản phẩm đang được chọn
  List<CartItem> get selectedItems =>
      _items.where((item) => item.selected).toList();

  // ĐÃ THÊM: tổng tiền chỉ tính các sản phẩm đang được chọn
  int get selectedTotal => _items
      .where((item) => item.selected)
      .fold(0, (sum, item) => sum + item.totalPrice);

  // ĐÃ THÊM: số lượng sản phẩm (loại) đang được chọn
  int get selectedCount => _items.where((item) => item.selected).length;

  // ĐÃ THÊM: kiểm tra đã chọn tất cả chưa (để đồng bộ checkbox "Tất cả")
  bool get isAllSelected =>
      _items.isNotEmpty && _items.every((item) => item.selected);

  /// Thêm sản phẩm vào giỏ. Phân biệt theo Tên và Màu sắc.
  void addItem(String name, int price, {String image = '', int quantity = 1, String color = ''}) {
    // Tìm sản phẩm trùng cả tên VÀ màu
    final index = _items.indexWhere((item) => item.name == name && item.color == color);

    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(
        CartItem(name: name, price: price, image: image, quantity: quantity, color: color),
      );
    }
    notifyListeners();
  }

  void removeItem(String name, String color) {
    _items.removeWhere((item) => item.name == name && item.color == color);
    notifyListeners();
  }

  void increaseQuantity(String name, String color) {
    final index = _items.indexWhere((item) => item.name == name && item.color == color);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(String name, String color) {
    final index = _items.indexWhere((item) => item.name == name && item.color == color);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  // ĐÃ THÊM: bật/tắt chọn 1 sản phẩm (phân biệt theo tên + màu)
  void toggleSelect(String name, String color) {
    final index = _items.indexWhere((item) => item.name == name && item.color == color);
    if (index >= 0) {
      _items[index].selected = !_items[index].selected;
      notifyListeners();
    }
  }

  // ĐÃ THÊM: chọn hoặc bỏ chọn tất cả sản phẩm trong giỏ
  void selectAll(bool value) {
    for (var item in _items) {
      item.selected = value;
    }
    notifyListeners();
  }

  // ĐÃ THÊM: xóa các sản phẩm đã chọn khỏi giỏ (dùng sau khi đặt hàng thành công)
  void removeSelectedItems() {
    _items.removeWhere((item) => item.selected);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}