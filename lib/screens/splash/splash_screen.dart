import 'package:flutter/material.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  // Thêm Animation để logo phóng to/nhỏ nhìn xịn sò hơn
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Cài đặt hiệu ứng Animation chạy trong 1.5 giây
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();

    // Chuyển màn hình sau 3 giây
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Đợi 3 giây để hiển thị logo và chạy xong animation
    await Future.delayed(const Duration(seconds: 3));

    // Kiểm tra xem widget còn tồn tại không trước khi chuyển trang (Tránh crash app)
    if (!mounted) return;

    // Chuyển sang màn hình Đăng nhập và xóa Splash khỏi ngăn xếp (stack)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    // Nhớ hủy controller để giải phóng bộ nhớ
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Màu nền chủ đạo của app (có thể đổi thành màu bạn thích)
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiệu ứng FadeIn và Scale cho Logo
            ScaleTransition(
              scale: _animation,
              child: FadeTransition(
                opacity: _animation,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tên App
            const Text(
              'KTK SHOP',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 8),

            // Slogan nhỏ
            const Text(
              'Phong cách của bạn',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 48),

            // Vòng xoay load mượt mà phía dưới
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}