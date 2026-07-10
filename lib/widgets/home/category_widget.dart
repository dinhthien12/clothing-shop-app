import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {"icon": Icons.checkroom, "label": "Áo"},
      {"icon": Icons.dry_cleaning, "label": "Quần"},
      {"icon": Icons.ac_unit, "label": "Áo khoác"},
      {"icon": Icons.watch, "label": "Phụ kiện"},
    ];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];
          return Container(
            width: 75,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(item["icon"] as IconData, color: Colors.blue),
                ),
                const SizedBox(height: 6),
                Text(
                  item["label"] as String,
                  style: const TextStyle(fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}