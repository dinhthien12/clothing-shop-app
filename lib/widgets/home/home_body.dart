import 'package:flutter/material.dart';
import 'banner_widget.dart';
import 'category_widget.dart';
import 'product_grid.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: const SingleChildScrollView(
        child: Column(
          children: [
            BannerWidget(),
            CategoryWidget(),
            ProductGrid(),
          ],
        ),
      ),
    );
  }
}