import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Đã thêm import Provider
import '../../providers/cart_provider.dart'; // Đã thêm import CartProvider
import '../order/my_order_screen.dart';

class PaymentScreen extends StatelessWidget {
  final double totalAmount;
  final String orderId;

  const PaymentScreen({
    super.key,
    required this.totalAmount,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    const String bankId = 'vcb';
    const String accountNo = '0359060083';
    const String accountName = 'DANG TUAN KIET';

    final String addInfo = 'Thanh_toan_don_$orderId';

    final String qrImageUrl =
        'https://img.vietqr.io/image/$bankId-$accountNo-print.png?amount=${totalAmount.toInt()}&addInfo=$addInfo&accountName=$accountName';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Thanh toán',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Quét mã QR để thanh toán',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sử dụng App ngân hàng hoặc ví điện tử để quét mã',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade200, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  qrImageUrl,
                  width: 250,
                  height: 300,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(
                    width: 250,
                    height: 250,
                    child: Center(
                      child: Icon(Icons.wifi_off, size: 50, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Mã đơn hàng:', orderId),
                  const Divider(height: 24),
                  _buildDetailRow(
                    'Số tiền:',
                    '${totalAmount.toInt()} VNĐ',
                    isBold: true,
                    color: Colors.red,
                  ),
                  const Divider(height: 24),
                  _buildDetailRow('Nội dung:', addInfo),
                ],
              ),
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // 1. XÓA SẠCH GIỎ HÀNG
                  Provider.of<CartProvider>(context, listen: false).clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Xác nhận thanh toán thành công!'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  // 2. CHUYỂN HƯỚNG VỀ TRANG ĐƠN HÀNG
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const MyOrdersScreen()),
                        (route) => route.isFirst,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'TÔI ĐÃ CHUYỂN KHOẢN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      String label,
      String value, {
        bool isBold = false,
        Color color = Colors.black87,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 15, color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}