import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String url =
      "https://my-json-server.typicode.com/dinhthien12/clothing-shop-app/products";

  static Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Không lấy được dữ liệu");
    }
  }
}