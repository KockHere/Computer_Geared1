import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/variables.dart';
import 'package:shop_app/constants.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    super.key,
    required this.category,
    required this.products,
  });

  final Category category;
  final List<Product> products;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String selectedSort = "ASC";
  List<String> listSort = ["ASC", "DESC"];

  Brand selectedBrand = Brand(productBrandId: "", productBrandName: "All");

  List<Product> listProduct = [];

  @override
  void initState() {
    widget.category.brandList!.add(selectedBrand);
    listProduct = widget.products;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.category.brandList!
        .removeWhere((element) => element.productBrandId == "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name ?? ""),
        actions: [
          Container(
            color: const Color(0xfff6f6f6),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
            child: DropdownButton<Brand>(
              value: selectedBrand,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: const TextStyle(color: kPrimaryColor),
              onChanged: (Brand? value) {
                if (value!.productBrandId == "") {
                  listProduct = widget.products;
                } else {
                  listProduct = widget.products
                      .where((element) => element.brandName!
                          .toLowerCase()
                          .contains(value.productBrandName!.toLowerCase()))
                      .toList();
                }
                setState(() {
                  selectedBrand = value;
                });
              },
              underline: Container(),
              items: widget.category.brandList!
                  .map<DropdownMenuItem<Brand>>((Brand value) {
                return DropdownMenuItem<Brand>(
                  value: value,
                  child: Text(value.productBrandName ?? ""),
                );
              }).toList(),
            ),
          ),
          Container(
            color: const Color(0xfff6f6f6),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
            child: DropdownButton<String>(
              value: selectedSort,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: const TextStyle(color: kPrimaryColor),
              onChanged: (String? value) {
                if (value == "ASC") {
                  listProduct.sort((a, b) =>
                      int.parse(a.unitPrice!.replaceAll(",", "")).compareTo(
                          int.parse(b.unitPrice!.replaceAll(",", ""))));
                } else if (value == "DESC") {
                  listProduct.sort((a, b) =>
                      int.parse(b.unitPrice!.replaceAll(",", "")).compareTo(
                          int.parse(a.unitPrice!.replaceAll(",", ""))));
                }
                setState(() {
                  selectedSort = value ?? "ASC";
                });
              },
              underline: Container(),
              items: listSort.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: listProduct.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.all(20),
                    color: const Color(0xfff6f6f6),
                    child: GridView.builder(
                      itemCount: listProduct.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.46,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                        product: listProduct[index],
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
