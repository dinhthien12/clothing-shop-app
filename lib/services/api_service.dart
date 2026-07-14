import 'dart:convert';
import 'package:flutter/services.dart'; // Đọc file từ tài nguyên cục bộ
import '../models/product.dart';

class ApiService {
  static Future<List<Product>> getProducts() async {
    try {
      // 1. Đọc trực tiếp dữ liệu từ file db.json cục bộ
      final String response = await rootBundle.loadString('db.json');

      // 2. Giải mã file JSON
      final Map<String, dynamic> data = jsonDecode(response);

      // 3. Trích xuất danh sách sản phẩm từ khóa "products" trong file db.json của bạn
      final List<dynamic> productsData = data['products'] ?? [];

      // 4. Chuyển đổi thành List Object Product để giao diện hiển thị
      return productsData.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      print("Lỗi đọc file db.json: $e");
      throw Exception("Không thể tải sản phẩm offline: $e");
    }
  }
}