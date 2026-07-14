import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../login/login_screen.dart';
// THÊM DÒNG NÀY VÀO:
import '../payment/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
        centerTitle: true,
      ),
      body: !authProvider.isLoggedIn
          ? _buildLoginPrompt(context)
          : cartProvider.isEmpty
          ? const Center(child: Text("Giỏ hàng trống"))
          : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: cartProvider.items.length,
        itemBuilder: (context, index) {
          final item = cartProvider.items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              // ĐÃ SỬA: Hiển thị ảnh thực tế từ đường dẫn item.image
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.circular(8),
                  image: item.image.isNotEmpty
                      ? DecorationImage(
                    image: AssetImage(item.image),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: item.image.isEmpty
                    ? const Icon(Icons.image, color: Colors.grey)
                    : null,
              ),
              title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  // ĐÃ SỬA: Hiển thị màu rõ ràng hơn
                  Text("Màu: ${item.color.isNotEmpty ? item.color : 'Mặc định'}",
                      style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  Row(
                    children: [
                      Text("${item.price} đ", style: const TextStyle(fontWeight: FontWeight.w600)),
                      const Spacer(),
                      InkWell(
                        onTap: () => cartProvider.decreaseQuantity(item.name, item.color),
                        child: const Icon(Icons.remove_circle_outline, size: 20, color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text("${item.quantity}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      InkWell(
                        onTap: () => cartProvider.increaseQuantity(item.name, item.color),
                        child: const Icon(Icons.add_circle_outline, size: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => cartProvider.removeItem(item.name, item.color),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: (!authProvider.isLoggedIn || cartProvider.isEmpty)
          ? null
          : Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Text("Tổng cộng:", style: TextStyle(fontSize: 16)),
            const Spacer(),
            Text(
              "${cartProvider.totalPrice} đ",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                // TẠO MÃ ĐƠN HÀNG NGẪU NHIÊN
                final orderId = 'KTK${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}';

                // ĐIỀU HƯỚNG SANG TRANG THANH TOÁN
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(
                      totalAmount: cartProvider.totalPrice.toDouble(),
                      orderId: orderId,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                backgroundColor: Colors.black, // Thêm màu cho nổi bật
              ),
              child: const Text("Thanh toán", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock_outline, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          const Text("Vui lòng đăng nhập để xem giỏ hàng"),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text("Đăng nhập"),
          ),
        ],
      ),
    );
  }
}