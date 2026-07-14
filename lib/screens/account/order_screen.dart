import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Hãy đảm bảo đường dẫn import đúng tới file OrderProvider của bạn
import '../../providers/order_provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Chúng ta lấy dữ liệu từ Provider thay vì khai báo List cứng
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đơn hàng của tôi"),
        centerTitle: true,
      ),
      // Sử dụng Consumer để tự động cập nhật khi Provider thay đổi
      body: Consumer<OrderProvider>(
        builder: (context, orderData, child) {
          final orders = orderData.orders;

          return orders.isEmpty
              ? const _EmptyOrder()
              : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mã đơn: ${order.orderId}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Ngày đặt: ${order.date.toString().substring(0, 10)}",
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${order.totalAmount.toInt()} VNĐ",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            label: Text(order.status),
                            backgroundColor: _getStatusColor(order.status),
                          ),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Chi tiết đơn ${order.orderId}"),
                                ),
                              );
                            },
                            child: const Text("Xem chi tiết"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Đang giao": return Colors.orange.shade200;
      case "Hoàn thành": return Colors.green.shade200;
      case "Đã hủy": return Colors.red.shade200;
      default: return Colors.grey.shade300;
    }
  }
}

class _EmptyOrder extends StatelessWidget {
  const _EmptyOrder();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 20),
          Text("Bạn chưa có đơn hàng nào", style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }
}