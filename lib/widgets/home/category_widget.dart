import 'package:flutter/material.dart';
import '../../screens/category/category_screen.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        "id": "ao",
        "icon": Icons.checkroom,
        "label": "Áo",
      },
      {
        "id": "quan",
        "icon": Icons.dry_cleaning,
        "label": "Quần",
      },
      {
        "id": "ao-khoac",
        "icon": Icons.ac_unit,
        "label": "Áo khoác",
      },
      {
        "id": "phu-kien",
        "icon": Icons.watch,
        "label": "Phụ kiện",
      },
    ];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];

          return InkWell(
            borderRadius: BorderRadius.circular(12),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryScreen(
                    categoryId: item["id"] as String,
                    categoryName: item["label"] as String,
                  ),
                ),
              );
            },

            child: Container(
              width: 75,
              margin: const EdgeInsets.only(right: 12),

              child: Column(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      item["icon"] as IconData,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    item["label"] as String,
                    style: const TextStyle(fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}