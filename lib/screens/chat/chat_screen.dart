import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../login/login_screen.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    // =============================
    // CHƯA ĐĂNG NHẬP
    // =============================
    if (!authProvider.isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Tin nhắn"),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.chat_bubble_outline,
                  size: 90,
                  color: Colors.grey,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Đăng nhập để trò chuyện với KTK Shop",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Bạn có thể hỏi về sản phẩm,\nđơn hàng hoặc chương trình khuyến mãi.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text("Đăng nhập"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // =============================
    // ĐÃ ĐĂNG NHẬP
    // =============================
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tin nhắn"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),

            leading: const CircleAvatar(
              radius: 26,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.store,
                color: Colors.white,
              ),
            ),

            title: const Text(
              "KTK Shop",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            subtitle: const Text(
              "Xin chào 👋 KTK Shop có thể hỗ trợ gì cho bạn?",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            trailing: const Text(
              "Hôm nay",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatDetailScreen(),
                ),
              );
            },
          ),

          const Divider(height: 1),
        ],
      ),
    );
  }
}