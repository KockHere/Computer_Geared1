import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/variables.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    Key? key,
    required this.title,
    required this.products,
  }) : super(key: key);

  final String title;
  final List<Product> products;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: widget.products.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.all(20),
                    color: const Color(0xfff6f6f6),
                    child: GridView.builder(
                      itemCount: widget.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.46,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                        product: widget.products[index],
                        onTapAddToCart: () {
                          setState(() {});
                        },
                      ),
                    ),
                  )
                : const Center(child: Text("No Product")),
          ),
          isLoading ? const LoadingScreen() : Container(),
        ],
      ),
    );
  }
}
