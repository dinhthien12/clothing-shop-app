import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giới thiệu ứng dụng"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// Logo
            const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.black,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),

            const SizedBox(height: 20),

            /// Tên ứng dụng
            const Text(
              "KTK SHOP",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Ứng dụng bán quần áo thời trang",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [

                    ListTile(
                      leading: Icon(Icons.school),
                      title: Text("Project Kiến trúc và Lập trình di động"),
                    ),

                    Divider(),

                    ListTile(
                      leading: Icon(Icons.code),
                      title: Text("Framework"),
                      trailing: Text("Flutter"),
                    ),

                    Divider(),

                    ListTile(
                      leading: Icon(Icons.phone_android),
                      title: Text("Phiên bản"),
                      trailing: Text("1.0.0"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Thành viên nhóm",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Column(
                children: const [

                  ListTile(
                    leading: CircleAvatar(
                      child: Text("1"),
                    ),
                    title: Text("Nguyễn Lưu Đình Thiện"),
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: CircleAvatar(
                      child: Text("2"),
                    ),
                    title: Text("Đặng Tuấn Kiệt"),
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: CircleAvatar(
                      child: Text("3"),
                    ),
                    title: Text("Mai Trung Kiên"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "KTK Shop là ứng dụng bán quần áo được xây dựng bằng Flutter nhằm phục vụ cho đồ án học phần. "
                  "Ứng dụng cung cấp các chức năng cơ bản như đăng nhập, xem sản phẩm, tìm kiếm, giỏ hàng, chat với shop và quản lý tài khoản.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "© 2026 KTK Shop",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}