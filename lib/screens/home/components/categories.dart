import 'package:flutter/material.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/products/products_screen.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.categories,
    required this.listAllProduct,
  }) : super(key: key);

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
        children: List.generate(
          categories.length > 8 ? 8 : categories.length,
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
                        .where((element) =>
                            element.categoryName!.toLowerCase().contains(categories[index].name!.toLowerCase()))
                        .toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

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
            child: Image.network(icon),
          ),
          const SizedBox(height: 4),
          Text(text, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
