import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final conversations = List.generate(
      5,
          (index) => {
        "name": "Shop KTK - Chi nhánh ${index + 1}",
        "lastMessage": "Cảm ơn bạn đã liên hệ, shop sẽ phản hồi sớm nhất.",
        "time": "${9 + index}:30",
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tin nhắn"),
        centerTitle: true,
      ),
      body: conversations.isEmpty
          ? const Center(child: Text("Chưa có cuộc trò chuyện nào"))
          : ListView.separated(
        itemCount: conversations.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final chat = conversations[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 6,
            ),
            leading: const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blue,
              child: Icon(Icons.store, color: Colors.white),
            ),
            title: Text(
              chat["name"] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              chat["lastMessage"] as String,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              chat["time"] as String,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            onTap: () {
              // TODO: điều hướng vào màn hình chi tiết chat
            },
          );
        },
      ),
    );
  }
}