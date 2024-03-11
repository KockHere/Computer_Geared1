import 'package:flutter/material.dart';
import 'package:shop_app/controllers/CartAPI.dart';
import 'package:shop_app/controllers/CategoryAPI.dart';
import 'package:shop_app/controllers/ProductAPI.dart';

import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/home/components/category_horizontal.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/variables.dart';

import 'components/home_header.dart';
import 'components/ads_banner.dart';
import 'components/categories.dart';
import 'components/product_horizontal.dart';
import 'components/product_vertical.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> listAd = [
    "assets/images/ad1.png",
    "assets/images/ad2.png",
    "assets/images/ad3.png"
  ];

  List<Product> listAllProduct = [];
  List<Product> listProduct = [];
  List<Product> listProductCPU = [];
  List<Product> listProductMonitor = [];
  List<Product> listProductKeyboard = [];
  List<Product> listProductVGA = [];

  List<Category> listCategory = [];
  String categoryActive = "Tất cả";

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    CategoryAPI.getListCategory().then((categories) {
      listCategory.add(Category(name: "Tất cả"));
      listCategory.addAll(categories);
      ProductAPI.getListProduct().then((products) {
        listAllProduct = products;
        listProduct = listAllProduct;
        listProductCPU = listAllProduct
            .where((element) =>
                element.categoryName!.toLowerCase().contains("cpu"))
            .take(6)
            .toList();
        listProductMonitor = listAllProduct
            .where((element) =>
                element.categoryName!.toLowerCase().contains("monitor"))
            .take(6)
            .toList();
        listProductKeyboard = listAllProduct
            .where((element) =>
                element.categoryName!.toLowerCase().contains("keyboard"))
            .take(6)
            .toList();
        listProductVGA = listAllProduct
            .where((element) =>
                element.categoryName!.toLowerCase().contains("vga"))
            .take(6)
            .toList();
        CartAPI.getUserCart().then((cart) {
          userCart = cart;
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  HomeHeader(
                    numberOfProduct: userCart.productTotal == null
                        ? 0
                        : int.parse(
                            userCart.productTotal!,
                          ),
                    onSetState: () {
                      setState(() {});
                    },
                  ),
                  AdsBanner(listAds: listAd),
                  Categories(
                    categories: listCategory.skip(1).toList(),
                    listAllProduct: listAllProduct,
                  ),
                  if (listProductCPU.isNotEmpty) ...[
                    ProductHorizontal(
                      backgroundColor: const Color(0xfff6f6f6), // Colors.red,
                      categoryName: "CPU",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                              title: "CPU",
                              products: listAllProduct
                                  .where((element) => element.categoryName!
                                      .toLowerCase()
                                      .contains("cpu"))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      products: listProductCPU,
                      onTapAddToCart: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (listProductMonitor.isNotEmpty) ...[
                    ProductHorizontal(
                      backgroundColor:
                          const Color(0xfff6f6f6), // Colors.lightBlue,
                      categoryName: "Monitor",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                              title: "Monitor",
                              products: listAllProduct
                                  .where((element) => element.categoryName!
                                      .toLowerCase()
                                      .contains("monitor"))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      products: listProductMonitor,
                      onTapAddToCart: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (listProductKeyboard.isNotEmpty) ...[
                    ProductHorizontal(
                      backgroundColor:
                          const Color(0xfff6f6f6), // Colors.orangeAccent,
                      categoryName: "Keyboard",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                              title: "Keyboard",
                              products: listAllProduct
                                  .where((element) => element.categoryName!
                                      .toLowerCase()
                                      .contains("keyboard"))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      products: listProductKeyboard,
                      onTapAddToCart: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (listProductVGA.isNotEmpty) ...[
                    ProductHorizontal(
                      backgroundColor:
                          const Color(0xfff6f6f6), // Colors.orange,
                      categoryName: "VGA",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                              title: "VGA",
                              products: listAllProduct
                                  .where((element) => element.categoryName!
                                      .toLowerCase()
                                      .contains("vga"))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      products: listProductVGA,
                      onTapAddToCart: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  CategoryHorizontal(
                    categoryActive: categoryActive,
                    categories: listCategory,
                    onTap: (name) {
                      setState(() {
                        categoryActive = name;
                        listProduct = listAllProduct
                            .where((element) => element.categoryName!
                                .toLowerCase()
                                .contains(categoryActive == "Tất cả"
                                    ? ""
                                    : categoryActive.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                  ProductVertical(
                    onTap: () {},
                    products: listProduct,
                    onTapAddToCart: () {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          isLoading ? const LoadingScreen() : Container(),
        ],
      ),
    );
  }
}
