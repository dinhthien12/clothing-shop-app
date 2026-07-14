import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../chat/chat_screen.dart';
import '../login/login_screen.dart';
import 'order_screen.dart';
import 'address_screen.dart';
import 'setting_screen.dart';
import 'about_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tài khoản"),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xfff5f5f5),
      body: ListView(
        children: [
          ///================ HEADER ==================
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor:
                  authProvider.isLoggedIn ? Colors.blue : Colors.grey,
                  child: const Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authProvider.isLoggedIn
                            ? (authProvider.userName ?? "Khách hàng")
                            : "Chưa đăng nhập",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      authProvider.isLoggedIn
                          ? Text(
                        authProvider.userEmail ?? "",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      )
                          : TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Đăng nhập ngay",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          ///================ ĐƠN HÀNG ==================
          _menuItem(
            context,
            icon: Icons.inventory_2_outlined,
            title: "Đơn hàng của tôi",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OrderScreen(),
                ),
              );
            },
          ),

          ///================ ĐỊA CHỈ ==================
          _menuItem(
            context,
            icon: Icons.location_on_outlined,
            title: "Địa chỉ giao hàng",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddressScreen(),
                ),
              );
            },
          ),

          ///================ CHAT ==================
          _menuItem(
            context,
            icon: Icons.chat_bubble_outline,
            title: "Chat với Shop",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatScreen(),
                ),
              );
            },
          ),

          ///================ CÀI ĐẶT ==================
          _menuItem(
            context,
            icon: Icons.settings_outlined,
            title: "Cài đặt",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingScreen(),
                ),
              );
            },
          ),

          ///================ GIỚI THIỆU ==================
          _menuItem(
            context,
            icon: Icons.info_outline,
            title: "Giới thiệu ứng dụng",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AboutScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 15),

          ///================ ĐĂNG XUẤT ==================
          _menuItem(
            context,
            icon: Icons.logout,
            title: "Đăng xuất",
            color: Colors.red,
            onTap: () async {
              final result = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Đăng xuất"),
                    content: const Text(
                      "Bạn có chắc muốn đăng xuất không?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Hủy"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text("Đăng xuất"),
                      ),
                    ],
                  );
                },
              );

              if (result == true) {
                authProvider.logout();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _menuItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
        Color color = Colors.black87,
      }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      elevation: 0,
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 17,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}