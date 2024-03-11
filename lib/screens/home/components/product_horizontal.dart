import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';

class ProductHorizontal extends StatelessWidget {
  const ProductHorizontal({
    Key? key,
    required this.backgroundColor,
    required this.categoryName,
    required this.onTap,
    required this.products,
    required this.onTapAddToCart,
  }) : super(key: key);

  final Color backgroundColor;
  final String categoryName;
  final Function() onTap;
  final List<Product> products;
  final Function() onTapAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  categoryName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: const Row(
                    children: [
                      Text(
                        "Xem thêm",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 4,
                          left: 2,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.black.withOpacity(0.5),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      products.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: ProductCard(
                            product: products[index],
                            onTapAddToCart: onTapAddToCart,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
