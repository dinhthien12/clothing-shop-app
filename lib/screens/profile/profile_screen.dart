import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {"icon": Icons.receipt_long_outlined, "label": "Đơn hàng của tôi"},
      {"icon": Icons.location_on_outlined, "label": "Địa chỉ giao hàng"},
      {"icon": Icons.payment_outlined, "label": "Phương thức thanh toán"},
      {"icon": Icons.notifications_outlined, "label": "Thông báo"},
      {"icon": Icons.settings_outlined, "label": "Cài đặt"},
      {"icon": Icons.logout, "label": "Đăng xuất"},
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Nguyễn Văn A",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "0912 345 678",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
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
        ],
      ),
    );
  }
}