import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../login/login_screen.dart';

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
        actions: [
          // ĐÃ THÊM: checkbox "Tất cả" để chọn/bỏ chọn toàn bộ giỏ hàng
          if (authProvider.isLoggedIn && !cartProvider.isEmpty)
            Row(
              children: [
                Checkbox(
                  value: cartProvider.isAllSelected,
                  onChanged: (value) {
                    context.read<CartProvider>().selectAll(value!);
                  },
                ),
                const Text("Tất cả", style: TextStyle(fontSize: 14)),
                const SizedBox(width: 10),
              ],
            ),
        ],
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
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: item.selected,
                    onChanged: (_) {
                      cartProvider.toggleSelect(item.name, item.color);
                    },
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 60,
                      height: 60,
                      color: const Color(0xFFEFEFEF),
                      child: item.image.isNotEmpty
                          ? Image.asset(
                        item.image,
                        fit: BoxFit.cover,
                      )
                          : const Icon(Icons.image),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "Màu: ${item.color.isEmpty ? 'Mặc định' : item.color}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "${item.price} đ",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            InkWell(
                              onTap: () => cartProvider.decreaseQuantity(
                                item.name,
                                item.color,
                              ),
                              child: const Icon(
                                Icons.remove_circle_outline,
                                size: 22,
                                color: Colors.grey,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "${item.quantity}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            InkWell(
                              onTap: () => cartProvider.increaseQuantity(
                                item.name,
                                item.color,
                              ),
                              child: const Icon(
                                Icons.add_circle_outline,
                                size: 22,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () =>
                        cartProvider.removeItem(item.name, item.color),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                ],
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
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ĐÃ SỬA: nhãn tổng tiền ghi rõ là tổng của sản phẩm đã chọn
                Text(
                  "Tổng (${cartProvider.selectedCount} sản phẩm):",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  // ĐÃ SỬA: chỉ tính tổng tiền các sản phẩm đang được chọn
                  "${cartProvider.selectedTotal} đ",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // ĐÃ THÊM: chặn thanh toán nếu chưa chọn sản phẩm nào
                if (cartProvider.selectedCount == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Vui lòng chọn ít nhất 1 sản phẩm")),
                  );
                  return;
                }

                // TẠO MÃ ĐƠN HÀNG NGẪU NHIÊN
                final orderId = 'KTK${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}';

                // ĐIỀU HƯỚNG SANG TRANG THANH TOÁN, chỉ mang theo tổng tiền sản phẩm đã chọn
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(
                      totalAmount: cartProvider.selectedTotal.toDouble(),
                      orderId: orderId,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
                disabledForegroundColor: Colors.grey.shade600,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Thanh toán",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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