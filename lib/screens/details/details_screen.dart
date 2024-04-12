import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/controllers/CartAPI.dart';
import 'package:shop_app/controllers/PCComponentAPI.dart';
import 'package:shop_app/models/CartItem.dart';
import 'package:shop_app/models/specifications/Case.dart';
import 'package:shop_app/models/specifications/Gpu.dart';
import 'package:shop_app/models/specifications/Motherboard.dart';
import 'package:shop_app/models/specifications/Processor.dart';
import 'package:shop_app/models/specifications/Ram.dart';
import 'package:shop_app/models/specifications/Storage.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/show_dialog.dart';
import 'package:shop_app/variables.dart';

import '../../models/Product.dart';
import 'components/color_dots.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int selectedColor = 1;
  int quantity = 1;
  Product product = Product(name: "", categoryName: "");
  bool isBuildPC = false;

  Motherboard motherboard = Motherboard(productId: "");

  bool isView = false;
  Processor processor = Processor(productId: "");
  Motherboard motherboardProduct = Motherboard(productId: "");
  Case caseSpec = Case(productId: "");
  Gpu gpu = Gpu(productId: "");
  Ram ram = Ram(productId: "");
  Storage storage = Storage(productId: "");

  String specification = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    product = data["product"] ?? Product(name: "", categoryName: "");
    isBuildPC = data["isBuildPC"] ?? false;
    motherboard = data["motherboard"] ?? Motherboard(productId: "");
    isView = data["isView"] ?? false;
    if (product.productId != null) {
      if (product.categoryName!
          .toLowerCase()
          .contains(RegExp(r'processor|motherboard|case|gpu|ram|storage'))) {
        setState(() {
          isLoading = true;
        });
        checkMainComponent(product, product.categoryName!.toLowerCase())
            .then((value) {
          if (processor.productId != "") {
            processor.toJson().forEach((key, value) {
              if (!key.contains(RegExp(
                  r'primary_product_id|name|description|unit_price|price|discount|sold|image_links|specification_id|product_id'))) {
                specification += "$key: $value\n";
              }
            });
          } else if (motherboardProduct.productId != "") {
            motherboardProduct.toJson().forEach((key, value) {
              if (!key.contains(RegExp(
                  r'primary_product_id|name|description|unit_price|price|discount|sold|image_links|specification_id|product_id'))) {
                specification += "$key: $value\n";
              }
            });
          } else if (caseSpec.productId != "") {
            caseSpec.toJson().forEach((key, value) {
              if (!key.contains(RegExp(
                  r'primary_product_id|name|description|unit_price|price|discount|sold|image_links|specification_id|product_id'))) {
                specification += "$key: $value\n";
              }
            });
          } else if (gpu.productId != "") {
            gpu.toJson().forEach((key, value) {
              if (!key.contains(RegExp(
                  r'primary_product_id|name|description|unit_price|price|discount|sold|image_links|specification_id|product_id'))) {
                specification += "$key: $value\n";
              }
            });
          } else if (ram.productId != "") {
            ram.toJson().forEach((key, value) {
              if (!key.contains(RegExp(
                  r'primary_product_id|name|description|unit_price|price|discount|sold|image_links|specification_id|product_id'))) {
                specification += "$key: $value\n";
              }
            });
          } else if (storage.productId != "") {
            storage.toJson().forEach((key, value) {
              if (!key.contains(RegExp(
                  r'primary_product_id|name|description|unit_price|price|discount|sold|image_links|specification_id|product_id'))) {
                specification += "$key: $value\n";
              }
            });
          }
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        });
      }
    }
    setState(() {});
  }

  Future<void> checkMainComponent(Product p, String category) async {
    if (p.categoryName!.toLowerCase() == category) {
      Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
          p.categoryName ?? "", p.productId ?? "");
      if (data.isNotEmpty) {
        if (category == "processor") {
          processor = Processor.fromJson(data);
        } else if (category == "motherboard") {
          motherboardProduct = Motherboard.fromJson(data);
        } else if (category == "case") {
          caseSpec = Case.fromJson(data);
        } else if (category == "gpu") {
          gpu = Gpu.fromJson(data);
        } else if (category == "ram") {
          ram = Ram.fromJson(data);
        } else if (category == "storage") {
          storage = Storage.fromJson(data);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: const Color(0xFFF5F6F9),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  backgroundColor: Colors.white,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            actions: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "4.7",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        SvgPicture.asset("assets/icons/Star Icon.svg"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: ListView(
            children: [
              ProductImages(product: product),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductDescription(
                      product: product,
                      specification: specification,
                    ),
                    TopRoundedContainer(
                      color: const Color(0xFFF6F7F9),
                      child: Column(
                        children: [
                          ColorDots(
                            product: product,
                            onTap1: () {
                              setState(() {
                                selectedColor = 1;
                              });
                            },
                            onTap2: () {
                              setState(() {
                                selectedColor = 2;
                              });
                            },
                            selectedColor: selectedColor,
                            quantity: quantity,
                            onTapMinus: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                            onTapPlus: () {
                              int maxQuantity = 1;
                              if (motherboard.productId != "") {
                                if (product.categoryName!
                                    .toLowerCase()
                                    .contains("ram")) {
                                  maxQuantity =
                                      int.parse(motherboard.memorySlots ?? "1");
                                } else {
                                  if (product.name!
                                      .toLowerCase()
                                      .contains("sata")) {
                                    maxQuantity = int.parse(
                                        motherboard.sata!.split(" x ")[0]);
                                  } else if (product.name!
                                      .toLowerCase()
                                      .contains("pcie")) {
                                    maxQuantity = int.parse(
                                        motherboard.m2!.split(" x ")[0]);
                                  }
                                }
                              }

                              if (quantity < maxQuantity) {
                                setState(() {
                                  quantity++;
                                });
                              }
                            },
                            isShowQuantity: (product.categoryName!
                                        .toLowerCase()
                                        .contains(RegExp(r'ram|storage')) &&
                                    motherboard.productId != "") ||
                                !isBuildPC,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: isView
              ? null
              : TopRoundedContainer(
                  color: Colors.white,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: ElevatedButton(
                        onPressed: () {
                          if (isBuildPC) {
                            product.quantityCart = quantity;
                            Navigator.pop(context, product);
                          } else {
                            if (user.userId == "") {
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                              // setState(() {
                              //   isLoading = true;
                              // });
                              // bool isDup = false;
                              // for (CartItem element in userCart.productList!) {
                              //   if (element.productId == product.productId) {
                              //     isDup = true;
                              //     element.quantity =
                              //         element.quantity! + quantity;
                              //     break;
                              //   }
                              // }
                              // if (!isDup) {
                              //   userCart.productList!.add(
                              //     CartItem(
                              //       quantity: quantity,
                              //       productId: product.productId,
                              //       unitPrice: product.unitPrice!,
                              //       images: product.imageLinks ?? [],
                              //       productName: product.name ?? "",
                              //     ),
                              //   );
                              // }
                              // userCart.productTotal =
                              //     (int.parse(userCart.productTotal!) + quantity)
                              //         .toString();
                              // prefs.then((dataPrefs) {
                              //   dataPrefs.setString(
                              //       "USER_CART", jsonEncode(userCart.toJson()));
                              // });
                              // quantity = 1;
                              // setState(() {
                              //   isLoading = false;
                              // });
                              // showDialogAddToCartSuccess(context);
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              CartAPI.addCartItem([
                                CartItem(
                                  quantity: quantity,
                                  productId: product.productId,
                                  unitPrice: product.unitPrice,
                                ),
                              ]).then((value) {
                                quantity = 1;
                                CartAPI.getUserCart().then((value) {
                                  if (mounted) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showDialogAddToCartSuccess(context);
                                  }
                                });
                              });
                            }
                          }
                        },
                        child: Text(isBuildPC ? "Add To Cart" : "Add To Cart"),
                      ),
                    ),
                  ),
                ),
        ),
        isLoading ? const LoadingScreen() : Container(),
      ],
    );
  }
}
