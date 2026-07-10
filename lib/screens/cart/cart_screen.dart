import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu tạm, sau này lấy từ CartProvider / CartService
    final cartItems = List.generate(
      3,
          (index) => {
        "name": "Sản phẩm ${index + 1}",
        "price": 150000 + index * 20000,
        "quantity": 1,
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Giỏ hàng trống"))
          : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.image, color: Colors.grey),
              ),
              title: Text(item["name"] as String),
              subtitle: Text(
                "${item["price"]} đ  •  SL: ${item["quantity"]}",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  // TODO: xóa sản phẩm khỏi giỏ hàng
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: cartItems.isEmpty
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
            const Text(
              "Tổng cộng:",
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            const Text(
              "500.000 đ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: điều hướng sang màn hình thanh toán
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
              ),
              child: const Text("Thanh toán"),
            ),
          ],
        ),
      ),
    );
  }
}