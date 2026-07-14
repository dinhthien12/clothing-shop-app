import 'package:flutter/material.dart';

// Đảm bảo model OrderItem của bạn đã có đủ các trường cần thiết
class OrderItem {
  final String orderId;
  final double totalAmount;
  String status;
  final DateTime date;

  OrderItem({
    required this.orderId,
    required this.totalAmount,
    this.status = "Đã xác nhận",
    required this.date
  });
}

class OrderProvider with ChangeNotifier {
  // 1. Danh sách lưu đơn hàng (luôn bắt đầu là rỗng)
  final List<OrderItem> _orders = [];

  // 2. Getter để lấy danh sách từ bên ngoài
  List<OrderItem> get orders => _orders;

  // 3. Hàm thêm đơn hàng mới - Đây là hàm bạn gọi khi đặt hàng thành công
  void addOrder(double total, String orderId) {
    final newOrder = OrderItem(
        orderId: orderId,
        totalAmount: total,
        date: DateTime.now(),
        status: "Đã xác nhận"
    );

    _orders.add(newOrder);

    // 4. BẮT BUỘC: Thông báo cho màn hình MyOrdersScreen biết để nó vẽ lại danh sách
    notifyListeners();
  }
}