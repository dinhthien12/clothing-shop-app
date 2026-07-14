import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../login/login_screen.dart';
import '../payment/checkout_screen.dart';
import '../../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  String? _selectedColor;
  late String _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.product.image;
    if (widget.product.variants != null && widget.product.variants!.isNotEmpty) {
      _selectedColor = widget.product.variants![0].color;
      _selectedImage = widget.product.variants![0].image;
    } else if (widget.product.colors.isNotEmpty) {
      _selectedColor = widget.product.colors[0];
    }
  }

  void _increaseQty() => setState(() => _quantity++);
  void _decreaseQty() { if (_quantity > 1) setState(() => _quantity--); }

  bool _requireLogin() {
    final authProvider = context.read<AuthProvider>();
    if (!authProvider.isLoggedIn) {
      _showLoginRequiredDialog();
      return true;
    }
    return false;
  }

  void _showLoginRequiredDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Yêu cầu đăng nhập"),
        content: const Text("Bạn cần đăng nhập để mua sắm tại KTK Shop."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Hủy")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text("Đăng nhập", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _addToCart() {
    if (_requireLogin()) return;

    // SỬA Ở ĐÂY: Truyền thêm 'image' và 'color' vào giỏ hàng
    context.read<CartProvider>().addItem(
      widget.product.name,
      widget.product.price.toInt(),
      quantity: _quantity,
      image: _selectedImage, // Truyền đường dẫn ảnh đang được chọn
      color: _selectedColor ?? '', // Truyền màu đang được chọn
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("Đã thêm $_quantity ${widget.product.name} vào giỏ hàng"),
          duration: const Duration(seconds: 1)
      ),
    );
  }

  void _buyNow() {
    if (_requireLogin()) return;
    final totalPrice = widget.product.price * _quantity;
    final randomOrderId = 'KTK${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}';
    Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(totalAmount: totalPrice.toDouble(), orderId: randomOrderId)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Chi tiết sản phẩm", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity, height: 350, color: const Color(0xFFF5F5F5),
              child: Image.asset(_selectedImage, fit: BoxFit.cover, key: ValueKey(_selectedImage)),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 10),
                  Text("${widget.product.price}đ", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text("Số lượng:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 20),
                      _buildQtyButton(Icons.remove, _decreaseQty),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text("$_quantity", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                      _buildQtyButton(Icons.add, _increaseQty),
                    ],
                  ),
                  if (widget.product.variants != null) ...[
                    const SizedBox(height: 25),
                    const Text("Chọn màu:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10, runSpacing: 10,
                      children: widget.product.variants!.map((variant) {
                        bool isSelected = _selectedColor == variant.color;
                        return GestureDetector(
                          onTap: () => setState(() {
                            _selectedColor = variant.color;
                            _selectedImage = variant.image;
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.black : Colors.white,
                              border: Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(variant.color, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 25),
                  const Divider(),
                  const SizedBox(height: 15),
                  const Text("Mô tả sản phẩm", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(widget.product.description, style: const TextStyle(color: Colors.grey, height: 1.6, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(child: OutlinedButton.icon(onPressed: _addToCart, icon: const Icon(Icons.shopping_cart_outlined), label: const Text("Thêm vào giỏ"))),
            const SizedBox(width: 12),
            Expanded(child: ElevatedButton(onPressed: _buyNow, style: ElevatedButton.styleFrom(backgroundColor: Colors.black), child: const Text("Mua ngay", style: TextStyle(color: Colors.white)))),
          ],
        ),
      ),
    );
  }

  Widget _buildQtyButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300, width: 1.5), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 16),
      ),
    );
  }
}