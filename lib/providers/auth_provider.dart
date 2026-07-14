import 'package:flutter/material.dart';

/// Quản lý trạng thái xác thực người dùng trong toàn bộ app.
/// Đăng ký ở gốc app bằng ChangeNotifierProvider (xem main.dart).
class AuthProvider extends ChangeNotifier {
  String? _userEmail;
  String? _userName;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;
  String? get userName => _userName;

  /// Đăng nhập bằng email/mật khẩu.
  /// Ném Exception nếu đăng nhập thất bại để UI có thể bắt lỗi.
  Future<void> login(String email, String password) async {
    // TODO: Thay bằng lời gọi API xác thực thật.
    await Future.delayed(const Duration(seconds: 2));

    // Giả lập kiểm tra đơn giản, thay bằng logic thật sau này.
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Email hoặc mật khẩu không hợp lệ");
    }

    _userEmail = email;
    // Tạm lấy phần trước dấu @ làm tên hiển thị.
    // Khi có API thật, thay bằng tên trả về từ server.
    _userName = email.split('@').first;
    _isLoggedIn = true;
    notifyListeners();
  }

  /// Cho phép cập nhật tên hiển thị sau này (vd. từ màn hình Chỉnh sửa hồ sơ).
  void updateUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void logout() {
    _userEmail = null;
    _userName = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}