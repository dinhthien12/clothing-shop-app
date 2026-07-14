import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../services/api_service.dart';
import 'banner_widget.dart';
import 'category_widget.dart';
import 'product_grid.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService.getProducts();
  }

  Future<void> _reload() async {
    setState(() {
      _productsFuture = ApiService.getProducts();
    });
    await _productsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: RefreshIndicator(
        onRefresh: _reload,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const BannerWidget(),
              const CategoryWidget(),
              FutureBuilder<List<Product>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(30),
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(Icons.error_outline,
                                color: Colors.red, size: 36),
                            const SizedBox(height: 8),
                            const Text("Không tải được sản phẩm"),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: _reload,
                              child: const Text("Thử lại"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final products = snapshot.data ?? [];
                  return ProductGrid(products: products);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}