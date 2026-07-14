import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../services/api_service.dart';
import 'category_product_card.dart';

class CategoryGrid extends StatelessWidget {
  final String categoryId;
  final String keyword;
  final String gender;
  final String sport;

  const CategoryGrid({
    super.key,
    required this.categoryId,
    required this.keyword,
    required this.gender,
    required this.sport,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: ApiService.getProducts(),

      builder: (context, snapshot) {

        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Error
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Không thể tải dữ liệu!",
              style: TextStyle(
                color: Colors.red.shade700,
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const SizedBox();
        }

        // Lọc theo Category
        final products = snapshot.data!
            .where((e) {

          if (e.categoryId != categoryId) {
            return false;
          }

          if (!e.name
              .toLowerCase()
              .contains(keyword.toLowerCase())) {
            return false;
          }

          if (gender != "Tất cả" &&
              e.gender.toLowerCase() !=
                  gender.toLowerCase()) {
            return false;
          }

          if (sport != "Tất cả" &&
              e.sport.toLowerCase() !=
                  sport.toLowerCase()) {
            return false;
          }

          return true;
        })
            .toList();

        if (products.isEmpty) {
          return const Center(
            child: Text(
              "Không có sản phẩm",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),

          itemCount: products.length,

          physics: const BouncingScrollPhysics(),

          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 2,

            mainAxisSpacing: 16,

            crossAxisSpacing: 16,

            childAspectRatio: 0.62,

          ),

          itemBuilder: (context, index) {
            return CategoryProductCard(
              product: products[index],
            );
          },
        );
      },
    );
  }
}