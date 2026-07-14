import 'package:flutter/material.dart';
import 'category_grid.dart';

class CategoryBody extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const CategoryBody({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  final TextEditingController _searchController = TextEditingController();

  String keyword = "";

  String selectedGender = "Tất cả";
  String selectedSport = "Tất cả";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          keyword = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm sản phẩm...",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: const Color(0xffF3F3F3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {

                      String tempGender = selectedGender;
                      String tempSport = selectedSport;

                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                        ),
                        builder: (_) {
                          return StatefulBuilder(
                            builder: (context, setStateSheet) {
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    const Center(
                                      child: Text(
                                        "Lọc sản phẩm",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    const Text(
                                      "Giới tính",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    Wrap(
                                      spacing: 8,
                                      children: [
                                        "Tất cả",
                                        "nam",
                                        "nu",
                                        "unisex",
                                      ].map((item) {
                                        return ChoiceChip(
                                          label: Text(item),
                                          selected:
                                          tempGender == item,
                                          onSelected: (_) {
                                            setStateSheet(() {
                                              tempGender = item;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),

                                    const SizedBox(height: 20),

                                    const Text(
                                      "Môn thể thao",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    Wrap(
                                      spacing: 8,
                                      children: [
                                        "Tất cả",
                                        "Gym",
                                        "Running",
                                        "Yoga",
                                        "Football",
                                        "Đa năng",
                                      ].map((item) {
                                        return ChoiceChip(
                                          label: Text(item),
                                          selected:
                                          tempSport == item,
                                          onSelected: (_) {
                                            setStateSheet(() {
                                              tempSport = item;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),

                                    const SizedBox(height: 25),

                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {

                                          setState(() {
                                            selectedGender =
                                                tempGender;
                                            selectedSport =
                                                tempSport;
                                          });

                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Áp dụng",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.tune),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Expanded(
          child: CategoryGrid(
            categoryId: widget.categoryId,
            keyword: keyword,
            gender: selectedGender,
            sport: selectedSport,
          ),
        ),
      ],
    );
  }
}