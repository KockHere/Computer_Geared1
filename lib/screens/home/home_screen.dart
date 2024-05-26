import 'package:flutter/material.dart';
import 'package:shop_app/controllers/CategoryAPI.dart';
import 'package:shop_app/controllers/ProductAPI.dart';
import 'package:shop_app/controllers/CartAPI.dart';

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
  List<Product> listProductProcessor = [];
  List<Product> listProductMotherboard = [];
  List<Product> listProductCase = [];
  List<Product> listProductGPU = [];
  List<Product> listProductRam = [];
  List<Product> listProductStorage = [];
  List<Product> listProductMonitor = [];

  List<Category> listCategory = [];
  String categoryActive = "All";

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    CategoryAPI.getListCategory().then((categories) {
      listCategory.add(Category(name: "All"));
      listCategory.addAll(categories);
      ProductAPI.getListProduct().then((products) {
        listAllProduct = products;
        listProduct = listAllProduct;
        listProductProcessor = listAllProduct
            .where((element) =>
                element.categoryName!.toLowerCase().contains("processor"))
            .take(10)
            .toList();
        listProductMotherboard = listAllProduct
            .where((element) =>
                element.categoryName!.toLowerCase().contains("motherboard"))
            .take(10)
            .toList();
        listProductCase = listAllProduct
            .where((element) =>
                element.categoryName!.toLowerCase().contains("case"))
            .take(10)
            .toList();
        listProductGPU = listAllProduct
            .where((element) =>
                element.categoryName!.toLowerCase().contains("gpu"))
            .take(10)
            .toList();
        listProductRam = listAllProduct
            .where((element) =>
                element.categoryName!.toLowerCase().contains("ram"))
            .take(10)
            .toList();
        listProductStorage = listAllProduct
            .where((element) =>
                element.categoryName!.toLowerCase().contains("storage"))
            .take(10)
            .toList();
        listProductMonitor = listAllProduct
            .where((element) =>
                element.categoryName!.toLowerCase().contains("monitor"))
            .take(10)
            .toList();
        CartAPI.getUserCart().then((cart) {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        });
        prefs.then((dataPrefs) {});
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
                    // numberOfProduct: userCart.productTotal == null
                    //     ? 0
                    //     : int.parse(
                    //         userCart.productTotal!,
                    //       ),
                    numberOfProduct: listUserCart
                                .where((element) =>
                                    element.personalBuildPcId == "")
                                .toList()
                                .fold(
                                    0,
                                    (sum, item) =>
                                        sum +
                                        (item.productList!.isEmpty
                                            ? 0
                                            : item.productList!.first
                                                .quantity!)) ==
                            0
                        ? listUserCart
                            .where(
                                (element) => element.personalBuildPcId != null)
                            .length
                        : listUserCart
                            .where((element) => element.personalBuildPcId == "")
                            .toList()
                            .fold(
                                0,
                                (sum, item) =>
                                    sum +
                                    (item.productList!.isEmpty
                                        ? 0
                                        : item.productList!.first.quantity!)),
                    onSetState: () {
                      setState(() {});
                    },
                    onChange: (value) {
                      listProduct = listAllProduct
                          .where((element) => element.name!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                      listProductProcessor = listAllProduct
                          .where((element) =>
                              element.categoryName!
                                  .toLowerCase()
                                  .contains("processor") &&
                              element.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                          .take(10)
                          .toList();
                      listProductMotherboard = listAllProduct
                          .where((element) =>
                              element.categoryName!
                                  .toLowerCase()
                                  .contains("motherboard") &&
                              element.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                          .take(10)
                          .toList();
                      listProductCase = listAllProduct
                          .where((element) =>
                              element.categoryName!
                                  .toLowerCase()
                                  .contains("case") &&
                              element.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                          .take(10)
                          .toList();
                      listProductGPU = listAllProduct
                          .where((element) =>
                              element.categoryName!
                                  .toLowerCase()
                                  .contains("gpu") &&
                              element.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                          .take(10)
                          .toList();
                      listProductRam = listAllProduct
                          .where((element) =>
                              element.categoryName!
                                  .toLowerCase()
                                  .contains("ram") &&
                              element.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                          .take(10)
                          .toList();
                      listProductStorage = listAllProduct
                          .where((element) =>
                              element.categoryName!
                                  .toLowerCase()
                                  .contains("storage") &&
                              element.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                          .take(10)
                          .toList();
                      listProductMonitor = listAllProduct
                          .where((element) =>
                              element.categoryName!
                                  .toLowerCase()
                                  .contains("monitor") &&
                              element.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                          .take(10)
                          .toList();
                      setState(() {});
                    },
                  ),
                  AdsBanner(listAds: listAd),
                  Categories(
                    categories: listCategory.skip(1).toList(),
                    listAllProduct: listAllProduct,
                  ),
                  if (listProductProcessor.isNotEmpty) ...[
                    ProductHorizontal(
                      backgroundColor:
                          const Color(0xfff6f6f6), // Colors.orangeAccent,
                      categoryName: "CPU",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                              category: listCategory.firstWhere((element) =>
                                  element.name!
                                      .toLowerCase()
                                      .contains("processor")),
                              products: listAllProduct
                                  .where((element) => element.categoryName!
                                      .toLowerCase()
                                      .contains("processor"))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      products: listProductProcessor,
                      onTapAddToCart: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (listProductMotherboard.isNotEmpty) ...[
                    ProductHorizontal(
                      backgroundColor:
                          const Color(0xfff6f6f6), // Colors.orangeAccent,
                      categoryName: "Motherboard",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                              category: listCategory.firstWhere((element) =>
                                  element.name!
                                      .toLowerCase()
                                      .contains("motherboard")),
                              products: listAllProduct
                                  .where((element) => element.categoryName!
                                      .toLowerCase()
                                      .contains("motherboard"))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      products: listProductMotherboard,
                      onTapAddToCart: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (listProductCase.isNotEmpty) ...[
                    ProductHorizontal(
                      backgroundColor:
                          const Color(0xfff6f6f6), // Colors.orangeAccent,
                      categoryName: "Case",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                              category: listCategory.firstWhere((element) =>
                                  element.name!.toLowerCase().contains("case")),
                              products: listAllProduct
                                  .where((element) => element.categoryName!
                                      .toLowerCase()
                                      .contains("case"))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      products: listProductCase,
                      onTapAddToCart: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (listProductGPU.isNotEmpty) ...[
                    ProductHorizontal(
                      backgroundColor:
                          const Color(0xfff6f6f6), // Colors.lightBlue,
                      categoryName: "GPU",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                              category: listCategory.firstWhere((element) =>
                                  element.name!.toLowerCase().contains("gpu")),
                              products: listAllProduct
                                  .where((element) => element.categoryName!
                                      .toLowerCase()
                                      .contains("gpu"))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      products: listProductGPU,
                      onTapAddToCart: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (listProductRam.isNotEmpty) ...[
                    ProductHorizontal(
                      backgroundColor:
                          const Color(0xfff6f6f6), // Colors.lightBlue,
                      categoryName: "Ram",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                              category: listCategory.firstWhere((element) =>
                                  element.name!.toLowerCase().contains("ram")),
                              products: listAllProduct
                                  .where((element) => element.categoryName!
                                      .toLowerCase()
                                      .contains("ram"))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      products: listProductRam,
                      onTapAddToCart: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (listProductStorage.isNotEmpty) ...[
                    ProductHorizontal(
                      backgroundColor:
                          const Color(0xfff6f6f6), // Colors.lightBlue,
                      categoryName: "Storage",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                              category: listCategory.firstWhere((element) =>
                                  element.name!
                                      .toLowerCase()
                                      .contains("storage")),
                              products: listAllProduct
                                  .where((element) => element.categoryName!
                                      .toLowerCase()
                                      .contains("storage"))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      products: listProductStorage,
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
                              category: listCategory.firstWhere((element) =>
                                  element.name!
                                      .toLowerCase()
                                      .contains("monitor")),
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
                  CategoryHorizontal(
                    categoryActive: categoryActive,
                    categories: listCategory,
                    onTap: (name) {
                      setState(() {
                        categoryActive = name;
                        listProduct = listAllProduct
                            .where((element) => element.categoryName!
                                .toLowerCase()
                                .contains(categoryActive == "All"
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
