import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/controllers/CartAPI.dart';
import 'package:shop_app/controllers/PCComponentAPI.dart';
import 'package:shop_app/controllers/ProductAPI.dart';
import 'package:shop_app/models/CartItem.dart';
import 'package:shop_app/models/Review.dart';
import 'package:shop_app/models/specifications/Case.dart';
import 'package:shop_app/models/specifications/CaseCooler.dart';
import 'package:shop_app/models/specifications/CpuCooler.dart';
import 'package:shop_app/models/specifications/Gpu.dart';
import 'package:shop_app/models/specifications/Monitor.dart';
import 'package:shop_app/models/specifications/Motherboard.dart';
import 'package:shop_app/models/specifications/Processor.dart';
import 'package:shop_app/models/specifications/Psu.dart';
import 'package:shop_app/models/specifications/Ram.dart';
import 'package:shop_app/models/specifications/Storage.dart';
import 'package:shop_app/screens/details/components/review_card.dart';
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

  CaseCooler caseCooler = CaseCooler(productId: "");
  CpuCooler cpuCooler = CpuCooler(productId: "");
  Psu psu = Psu(productId: "");
  Monitor monitor = Monitor(productId: "");

  Map<String, dynamic> specification = {};

  bool isShowSpec = false;

  List<Review> listReview = [];

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
      setState(() {
        isLoading = true;
      });
      getListReview(product.productId ?? "");
      checkMainComponent(product, product.categoryName!.toLowerCase())
          .then((value) {
        if (processor.productId != "") {
          specification = processor.toJson1();
        } else if (motherboardProduct.productId != "") {
          specification = motherboardProduct.toJson1();
        } else if (caseSpec.productId != "") {
          specification = caseSpec.toJson1();
        } else if (gpu.productId != "") {
          specification = gpu.toJson1();
        } else if (ram.productId != "") {
          specification = ram.toJson1();
        } else if (storage.productId != "") {
          specification = storage.toJson1();
        } else if (caseCooler.productId != "") {
          specification = caseCooler.toJson1();
        } else if (cpuCooler.productId != "") {
          specification = cpuCooler.toJson1();
        } else if (psu.productId != "") {
          specification = psu.toJson1();
        } else if (monitor.productId != "") {
          specification = monitor.toJson1();
        }
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
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
        } else if (category == "fan") {
          caseCooler = CaseCooler.fromJson(data);
        } else if (category == "cooler cpu") {
          cpuCooler = CpuCooler.fromJson(data);
        } else if (category == "psu") {
          psu = Psu.fromJson(data);
        } else if (category == "monitor") {
          monitor = Monitor.fromJson(data);
        }
      }
    }
  }

  Future<void> getListReview(String productId) async {
    listReview = await ProductAPI.getListReview(productId);
    setState(() {});
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
                        Text(
                          listReview.isEmpty
                              ? "4"
                              : (listReview.fold(
                                          0,
                                          (sum, item) =>
                                              sum + (item.rating ?? 0)) /
                                      listReview.length)
                                  .toString(),
                          style: const TextStyle(
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
                      isShowSpec: isShowSpec,
                      onTapShowSpec: () {
                        setState(() {
                          isShowSpec = !isShowSpec;
                        });
                      },
                      childQuantity: ColorDots(
                        product: product,
                        quantity: quantity,
                        onTapMinus: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        onTapPlus: () {
                          int maxQuantity = 1000;
                          if (motherboard.productId != "") {
                            if (product.categoryName!
                                .toLowerCase()
                                .contains("ram")) {
                              maxQuantity = motherboard.memorySlots ?? 1;
                            } else {
                              if (product.name!
                                  .toLowerCase()
                                  .contains("sata")) {
                                maxQuantity = int.parse(
                                    motherboard.sata!.split(" x ")[0]);
                              } else if (product.name!
                                  .toLowerCase()
                                  .contains("pcie")) {
                                maxQuantity =
                                    int.parse(motherboard.m2!.split(" x ")[0]);
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
                    ),
                    TopRoundedContainer(
                      color: const Color(0xFFF6F7F9),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            ...List.generate(
                              listReview.length,
                              (index) => ReviewCard(
                                review: listReview[index],
                              ),
                            ),
                          ],
                        ),
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
                        child: Text(isBuildPC ? "Add Product" : "Add To Cart"),
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
