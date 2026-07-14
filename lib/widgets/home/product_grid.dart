// import 'package:flutter/material.dart';
// import '../../models/product.dart';
// import '../../screens/product/product_detail_screen.dart';
//
// class ProductGrid extends StatelessWidget {
//   final List<Product> products;
//
//   const ProductGrid({super.key, required this.products});
//
//   @override
//   Widget build(BuildContext context) {
//     if (products.isEmpty) {
//       return const Padding(
//         padding: EdgeInsets.all(30),
//         child: Center(child: Text("Chưa có sản phẩm nào")),
//       );
//     }
//
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: products.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 12,
//           crossAxisSpacing: 12,
//           childAspectRatio: 0.68,
//         ),
//         itemBuilder: (context, index) {
//           return _ProductCard(product: products[index]);
//         },
//       ),
//     );
//   }
// }
//
// class _ProductCard extends StatelessWidget {
//   final Product product;
//
//   const _ProductCard({required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(12),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailScreen(product: product),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Ảnh sản phẩm
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(12),
//                 ),
//                 child: Container(
//                   width: double.infinity,
//                   color: const Color(0xFFEFEFEF),
//                   child: product.image.isEmpty
//                       ? const Center(
//                     child: Icon(Icons.image, size: 40, color: Colors.grey),
//                   )
//                       : Image.network(
//                     product.image,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) => const Center(
//                       child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
//                     ),
//                     loadingBuilder: (context, child, progress) {
//                       if (progress == null) return child;
//                       return const Center(
//                         child: SizedBox(
//                           width: 22,
//                           height: 22,
//                           child: CircularProgressIndicator(strokeWidth: 2),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//
//             // Tên sản phẩm
//             Padding(
//               padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
//               child: Text(
//                 product.name,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(fontWeight: FontWeight.w500),
//               ),
//             ),
//
//             // Giá
//             Padding(
//               padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//               child: Text(
//                 product.formattedPrice,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../screens/product/product_detail_screen.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(30),
        child: Center(child: Text("Chưa có sản phẩm nào")),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, index) {
          return _ProductCard(product: products[index]);
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFFEFEFEF),
                  child: product.image.isEmpty
                      ? const Center(
                    child: Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  )
                      : Image.asset(
                    product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Tên sản phẩm
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
              child: Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Giá
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Text(
                product.formattedPrice,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}