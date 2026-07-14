import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/order_provider.dart';

// --- Màn hình danh sách đơn hàng ---
class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        title: const Text(
          "Đơn hàng của tôi",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderData, child) {
          if (orderData.orders.isEmpty) {
            return const Center(
              child: Text(
                "Chưa có đơn hàng nào!",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: orderData.orders.length,
            itemBuilder: (context, index) {
              final order = orderData.orders[index];
              return Card(
                elevation: 0.5,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    "Mã đơn: ${order.orderId}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text("Tổng tiền: ${order.totalAmount.toInt()} đ"),
                      Text(
                        "Trạng thái: ${order.status}",
                        style: TextStyle(
                          color: order.status == "Đã giao"
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailScreen(order: order),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// --- Màn hình chi tiết theo dõi đơn hàng ---
class OrderDetailScreen extends StatelessWidget {
  final OrderItem order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    int currentStep = 0;
    if (order.status == "Đang giao") currentStep = 1;
    if (order.status == "Đã giao") currentStep = 2;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Chi tiết ${order.orderId}",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    "Trạng thái hiện tại",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(
                      order.status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Theme(
                data: ThemeData(canvasColor: Colors.transparent),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) =>
                  const SizedBox.shrink(), // Ẩn nút thừa
                  steps: const [
                    Step(
                      title: Text("Đã xác nhận"),
                      content: Text("Đơn hàng đã được shop tiếp nhận"),
                      isActive: true,
                    ),
                    Step(
                      title: Text("Đang giao"),
                      content: Text("Đơn hàng đang trên đường tới bạn"),
                      isActive: true,
                    ),
                    Step(
                      title: Text("Đã giao"),
                      content: Text("Đơn hàng đã hoàn thành"),
                      isActive: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
