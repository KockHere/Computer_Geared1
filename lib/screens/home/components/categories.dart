import 'package:flutter/material.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/products/products_screen.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.categories,
    required this.listAllProduct,
  });

  final List<Category> categories;
  final List<Product> listAllProduct;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ...List.generate(
            categories.length > 7 ? 7 : categories.length,
            (index) => CategoryCard(
              icon: categories[index].image != ""
                  ? categories[index].image!
                  : "https://lh3.googleusercontent.com/2701fTP9z5BT0Jn40Jc6qiXij824-WxAM6wavqFHvf7tp5WLkpJwh7Kn6TsesgatH_avVdZMkVtu8qfpZ3jfkWDsIeXYKg-L=rw",
              text: categories[index].name ?? "",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(
                      title: categories[index].name ?? "",
                      products: listAllProduct
                          .where((element) => element.categoryName!
                              .toLowerCase()
                              .contains(categories[index].name!.toLowerCase()))
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          CategoryCard(
            icon: "",
            text: "All",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InitScreen(initIndex: 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.icon,
    required this.text,
    required this.press,
  });

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          SizedBox(
            height: 56,
            width: 56,
            child: icon.isEmpty
                ? Container(
                    color: Colors.transparent,
                    alignment: Alignment.bottomCenter,
                    child: const Icon(Icons.more_horiz),
                  )
                : Image.network(
                    icon,
                    errorBuilder: (context, error, stackTrace) => Image.network(
                        "https://lh3.googleusercontent.com/icxPo1Rqyjc1XkfEpTq6NJx3p1mFclraPE3mp3uxCUDBoHXuhbq8WMGMiwE3L4czehocmdRCuSyBF9QOU4DQhz30eIjekvNm=rw"),
                  ),
          ),
          const SizedBox(height: 4),
          Text(text, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
