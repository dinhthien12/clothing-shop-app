import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    final menuItems = [
      {"icon": Icons.receipt_long_outlined, "label": "Đơn hàng của tôi"},
      {"icon": Icons.location_on_outlined, "label": "Địa chỉ giao hàng"},
      {"icon": Icons.payment_outlined, "label": "Phương thức thanh toán"},
      {"icon": Icons.notifications_outlined, "label": "Thông báo"},
      {"icon": Icons.settings_outlined, "label": "Cài đặt"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tài khoản"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authProvider.isLoggedIn
                            ? (authProvider.userName ?? "Khách hàng")
                            : "Chưa đăng nhập",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      if (!authProvider.isLoggedIn)
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text("Đăng nhập ngay"),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ...menuItems.map(
                (item) => Column(
              children: [
                ListTile(
                  leading: Icon(item["icon"] as IconData),
                  title: Text(item["label"] as String),
                  trailing: const Icon(Icons.chevron_right),
                  tileColor: Colors.white,
                  onTap: () {
                    // TODO: điều hướng theo từng mục
                  },
                ),
                const Divider(height: 1),
              ],
            ),
          ),
          if (authProvider.isLoggedIn)
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text("Đăng xuất",
                      style: TextStyle(color: Colors.red)),
                  tileColor: Colors.white,
                  onTap: () {
                    context.read<CartProvider>().clear();
                    context.read<AuthProvider>().logout();
                  },
                ),
                const Divider(height: 1),
              ],
            ),
        ],
      ),
    );
  }
}