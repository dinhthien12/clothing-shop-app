import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final int price;
  final String image;
  final String color; // Thêm trường màu
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    this.image = '',
    this.color = '', // Mặc định là chuỗi rỗng
    this.quantity = 1,
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

  void clear() {
    _items.clear();
    notifyListeners();
  }
}