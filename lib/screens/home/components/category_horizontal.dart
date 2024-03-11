import 'package:flutter/material.dart';
import 'package:shop_app/models/Category.dart';

class CategoryHorizontal extends StatelessWidget {
  const CategoryHorizontal({
    Key? key,
    required this.categoryActive,
    required this.categories,
    required this.onTap,
  }) : super(key: key);

  final String categoryActive;
  final List<Category> categories;
  final Function(String name) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              "Tất cả sản phẩm",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    categories.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          onTap(categories[index].name ?? "Tất cả");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          margin: const EdgeInsets.only(right: 20),
                          decoration: categoryActive == categories[index].name ? BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: const Color(0xfff6f6f6),
                          ) : null,
                          child: Text(
                            categories[index].name ?? "",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
