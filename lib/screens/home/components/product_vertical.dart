import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';

class ProductVertical extends StatelessWidget {
  const ProductVertical({
    Key? key,
    required this.onTap,
    required this.products,
    required this.onTapAddToCart,
  }) : super(key: key);

  final Function() onTap;
  final List<Product> products;
  final Function() onTapAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xfff6f6f6),
      child: products.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(20),
              child: GridView.count(
                childAspectRatio: 0.42,
                mainAxisSpacing: 20,
                crossAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                  products.length,
                  (index) => ProductCard(
                    product: products[index],
                    onTapAddToCart: onTapAddToCart,
                  ),
                ),
              ),
            )
          : const Center(child: Text("No Product")),
    );
  }
}
