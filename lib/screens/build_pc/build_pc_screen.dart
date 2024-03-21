import 'package:flutter/material.dart';

import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/CartAPI.dart';
import 'package:shop_app/controllers/CategoryAPI.dart';
import 'package:shop_app/controllers/ProductAPI.dart';
import 'package:shop_app/models/CartItem.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/build_pc/components/build_pc_cart.dart';
import 'package:shop_app/screens/choose_device/choose_device_screen.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/show_dialog.dart';
import 'package:shop_app/variables.dart';

class BuildPCScreen extends StatefulWidget {
  const BuildPCScreen({super.key});

  @override
  State<BuildPCScreen> createState() => _BuildPCScreenState();
}

class _BuildPCScreenState extends State<BuildPCScreen> {
  List<Category> listCategory = [];
  List<Product> listAllProduct = [];
  List<Product> listSelectedProduct = [];
  double price = 0;

  int indexCategory = 0;
  List<Category> listIndexCategory = [];

  List<CartItem> listSelectedCartItem = [];
  int totalPage = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    CategoryAPI.getListCategory().then((categories) {
      listCategory = categories;
      totalPage = (listCategory.length / 4).ceil();
      changeIndexCategory();
      ProductAPI.getListProduct().then((products) {
        listAllProduct = products;
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    });
  }

  void updatePrice() {
    price = 0;
    for (CartItem cartItem in listSelectedCartItem) {
      price += double.parse(cartItem.unitPrice!.replaceAll(",", "")) *
          cartItem.quantity!;
    }
  }

  void changeIndexCategory() {
    if (indexCategory == 0) {
      listIndexCategory = listCategory
          .where((element) =>
              element.name!.toLowerCase().contains(RegExp("main|psu|ram|cpu")))
          .toList()
        ..sort((a, b) {
          final order = ["cpu", "main", "ram", "psu"];
          return order.indexOf(a.name!.toLowerCase()) -
              order.indexOf(b.name!.toLowerCase());
        });
    } else if (indexCategory == 1) {
      listIndexCategory = listCategory
          .where((element) => element.name!
              .toLowerCase()
              .contains(RegExp("vga|hard drive|case|cooling")))
          .toList()
        ..sort((a, b) {
          final order = ["cooling", "hard drive", "vga", "case"];
          return order.indexOf(a.name!.toLowerCase()) -
              order.indexOf(b.name!.toLowerCase());
        });
    } else if (indexCategory == 2) {
      listIndexCategory = listCategory
          .where((element) => element.name!
              .toLowerCase()
              .contains(RegExp("monitor|keyboard|mouse|earphone")))
          .toList();
    } else {
      listIndexCategory = listCategory.toList()
        ..removeWhere((element) => element.name!.toLowerCase().contains(RegExp(
            "main|psu|ram|cpu|vga|hard drive|case|cooling|monitor|keyboard|mouse|earphone")));
      listIndexCategory =
          listIndexCategory.skip((indexCategory - 3) * 4).take(4).toList();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: indexCategory == 0
                ? Container()
                : GestureDetector(
                    onTap: () {
                      indexCategory--;
                      changeIndexCategory();
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
            title: Text(
              "Xây dựng cấu hình PC",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: const Color(0xfff6f6f6),
              child: Column(
                children: [
                  ...List.generate(
                    listIndexCategory.length,
                    (index) => BuildPCCard(
                      category: listIndexCategory[index],
                      onTap: () {
                        if (user.userId == "") {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseDeviceScreen(
                                title: listIndexCategory[index].name ?? "",
                                products: listAllProduct
                                    .where((element) => element.categoryName!
                                        .toLowerCase()
                                        .contains(listIndexCategory[index]
                                            .name!
                                            .toLowerCase()))
                                    .toList(),
                              ),
                            ),
                          ).then((productId) {
                            if (productId != null) {
                              Product selectedProduct =
                                  listAllProduct.firstWhere((element) =>
                                      element.productId == productId);
                              setState(() {
                                listSelectedProduct.add(selectedProduct);
                                listSelectedCartItem.add(CartItem(
                                  quantity: 1,
                                  productId: productId,
                                  unitPrice: selectedProduct.unitPrice,
                                  images: selectedProduct.imageLinks,
                                  productName: selectedProduct.name,
                                  categoryName: selectedProduct.categoryName,
                                ));
                                updatePrice();
                              });
                            }
                          });
                        }
                      },
                      onTapEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseDeviceScreen(
                              title: listIndexCategory[index].name ?? "",
                              products: listAllProduct
                                  .where((element) => element.categoryName!
                                      .toLowerCase()
                                      .contains(listIndexCategory[index]
                                          .name!
                                          .toLowerCase()))
                                  .toList(),
                            ),
                          ),
                        ).then((productId) {
                          if (productId != null) {
                            Product oldProduct = listSelectedProduct.firstWhere(
                              (element) => element.categoryName!
                                  .toLowerCase()
                                  .contains(listIndexCategory[index]
                                      .name!
                                      .toLowerCase()),
                            );
                            listSelectedCartItem.removeWhere((element) =>
                                element.productId == oldProduct.productId);
                            listSelectedProduct.removeWhere(
                              (element) => element == oldProduct,
                            );
                            setState(() {
                              Product selectedProduct =
                                  listAllProduct.firstWhere((element) =>
                                      element.productId == productId);
                              listSelectedProduct.add(selectedProduct);
                              listSelectedCartItem.add(CartItem(
                                quantity: 1,
                                productId: productId,
                                unitPrice: selectedProduct.unitPrice,
                                images: selectedProduct.imageLinks,
                                productName: selectedProduct.name,
                                categoryName: selectedProduct.categoryName,
                              ));
                              updatePrice();
                            });
                          }
                        });
                      },
                      onTapDelete: () {
                        setState(() {
                          Product oldProduct = listSelectedProduct.firstWhere(
                            (element) => element.categoryName!
                                .toLowerCase()
                                .contains(listIndexCategory[index]
                                    .name!
                                    .toLowerCase()),
                          );
                          listSelectedProduct.removeWhere(
                            (element) => element == oldProduct,
                          );
                          listSelectedCartItem.removeWhere(
                            (element) =>
                                element.productId == oldProduct.productId,
                          );
                          updatePrice();
                        });
                      },
                      listAllProduct: listAllProduct,
                      cartItem: listSelectedCartItem.firstWhere(
                          (element) => element.categoryName!
                              .toLowerCase()
                              .contains(
                                  listIndexCategory[index].name!.toLowerCase()),
                          orElse: () => CartItem(productId: "")),
                      onTapPlus: (productId) {
                        listSelectedCartItem.map((element) {
                          if (element.productId == productId) {
                            element.quantity = element.quantity! + 1;
                          }
                        }).toList();
                        updatePrice();
                        setState(() {});
                      },
                      onTapMinus: (productId) {
                        listSelectedCartItem.map((element) {
                          if (element.productId == productId &&
                              element.quantity! > 1) {
                            element.quantity = element.quantity! - 1;
                          }
                        }).toList();
                        updatePrice();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nguồn ước tính",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "0W",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nguồn đã chọn",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "0W",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    if (indexCategory == totalPage - 1) ...[
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tổng",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${formatCurrency(price).replaceAll(".", ",")}đ",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ] else ...[
                      const SizedBox(height: 10),
                    ],
                    GestureDetector(
                      onTap: () {
                        if (indexCategory == totalPage - 1) {
                          if (listSelectedCartItem.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                            CartAPI.addCartItem(listSelectedCartItem)
                                .then((value) {
                              listSelectedProduct = [];
                              listSelectedCartItem = [];
                              updatePrice();
                              setState(() {
                                isLoading = false;
                              });
                              showDialogAddToCartSuccess(context);
                            });
                          }
                        } else {
                          indexCategory++;
                          changeIndexCategory();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(10, 8, 16, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: kPrimaryColor,
                        ),
                        child: Text(
                          indexCategory == totalPage - 1
                              ? "Thêm vào giỏ hàng"
                              : "Tiếp tục",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        isLoading ? const LoadingScreen() : Container(),
      ],
    );
  }
}
