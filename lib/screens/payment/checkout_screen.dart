import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../../providers/order_provider.dart'; // Import Provider quản lý đơn hàng
import '../order/my_order_screen.dart'; // Import trang danh sách đơn hàng
import 'payment_screen.dart';
import '../../providers/cart_provider.dart'; // Đảm bảo đường dẫn này đúng với vị trí file của bạn
class CheckoutScreen extends StatefulWidget {
  final double totalAmount;
  final String orderId;

  const CheckoutScreen({
    super.key,
    required this.totalAmount,
    required this.orderId,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPaymentMethod = 'QR';

  final TextEditingController _nameController = TextEditingController(
    text: 'Đặng Tuấn Kiệt',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '0393993383',
  );
  final TextEditingController _addressController = TextEditingController(
    text: '180 Cao Lỗ, Phường 4, Quận 8, TP. Hồ Chí Minh',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Thanh toán đơn hàng',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Địa chỉ nhận hàng',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Họ và tên',
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Số điện thoại',
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _addressController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'Địa chỉ chi tiết',
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.payment,
                              color: Colors.black87,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Phương thức thanh toán',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        RadioListTile<String>(
                          title: const Text('Thanh toán qua mã QR (VietQR)'),
                          value: 'QR',
                          groupValue: _selectedPaymentMethod,
                          activeColor: Colors.black,
                          onChanged: (value) =>
                              setState(() => _selectedPaymentMethod = value!),
                        ),
                        RadioListTile<String>(
                          title: const Text('Thanh toán khi nhận hàng (COD)'),
                          value: 'COD',
                          groupValue: _selectedPaymentMethod,
                          activeColor: Colors.black,
                          onChanged: (value) =>
                              setState(() => _selectedPaymentMethod = value!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildPriceRow(
                          'Tổng tiền hàng',
                          '${widget.totalAmount.toInt()} đ',
                        ),
                        const SizedBox(height: 12),
                        _buildPriceRow('Phí vận chuyển', 'Miễn phí'),
                        const Divider(height: 24),
                        _buildPriceRow(
                          'Tổng thanh toán',
                          '${widget.totalAmount.toInt()} đ',
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleCheckout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'ĐẶT HÀNG',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCheckout() {
    // Lấy provider giỏ hàng
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // 1. Lưu đơn hàng
    context.read<OrderProvider>().addOrder(widget.totalAmount, widget.orderId);

    // 2. Xử lý điều hướng
    if (_selectedPaymentMethod == 'QR') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            totalAmount: widget.totalAmount,
            orderId: widget.orderId,
          ),
        ),
      );
    } else {
      // ĐẶT HÀNG COD THÀNH CÔNG -> XÓA GIỎ HÀNG
      cartProvider.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đặt hàng thành công!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MyOrdersScreen()),
      );
    }
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.bold,
            color: isTotal ? Colors.redAccent : Colors.black,
          ),
        ),
      ],
    );
  }
}
