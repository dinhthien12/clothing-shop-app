import 'package:flutter/material.dart';
import '../../screens/chat/chat_screen.dart';
import '../../screens/favorite/favorite_screen.dart';
import '../../screens/profile/profile_screen.dart';

class HomeBottomNav extends StatefulWidget {
  const HomeBottomNav({super.key});

  @override
  State<HomeBottomNav> createState() => _HomeBottomNavState();
}

class _HomeBottomNavState extends State<HomeBottomNav> {
  int _currentIndex = 0;

  void _onTap(int index) {
    if (index == 0) {
      // Đang ở Home rồi thì không làm gì
      setState(() => _currentIndex = 0);
      return;
    }

    Widget screen;
    switch (index) {
      case 1:
        screen = const ChatScreen();
        break;
      case 2:
        screen = const FavoriteScreen();
        break;
      case 3:
        screen = const ProfileScreen();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    ).then((_) {
      // Khi quay lại Home, reset icon về Home
      setState(() => _currentIndex = 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Yêu thích"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Tài khoản"),
      ],
    );
  }
}