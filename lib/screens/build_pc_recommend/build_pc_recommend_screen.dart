// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/CategoryAPI.dart';
import 'package:shop_app/controllers/PCBuilderAPI.dart';
import 'package:shop_app/controllers/PCComponentAPI.dart';
import 'package:shop_app/models/CartItem.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/specifications/Gpu.dart';
import 'package:shop_app/models/specifications/Processor.dart';
import 'package:shop_app/models/specifications/Psu.dart';
import 'package:shop_app/models/specifications/UserPC.dart';
import 'package:shop_app/screens/build_pc_recommend/components/build_pc_cart.dart';
import 'package:shop_app/screens/choose_device/choose_device_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/variables.dart';

class BuildPCRecommendScreen extends StatefulWidget {
  BuildPCRecommendScreen({super.key, required this.userPC});

  UserPC userPC;
  @override
  State<BuildPCRecommendScreen> createState() => _BuildPCRecommendScreenState();
}

class _BuildPCRecommendScreenState extends State<BuildPCRecommendScreen> {
  List<Category> listCategory = [];
  List<Product> listSelectedProduct = [];
  double price = 0;

  int indexCategory = 0;
  List<Category> listIndexCategory = [];

  List<CartItem> listSelectedCartItem = [];
  int totalPage = 0;

  int selectedPower = 0;
  int totalPower = 0;

  Psu psu = Psu(productId: "", power: 0);

  Gpu gpu = Gpu(productId: "", maxPowerConsumption: 0);
  Processor processor = Processor(productId: "", power: 0);

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    CategoryAPI.getListCategory().then((categories) {
      listCategory = categories
          .where((element) => element.name!.toLowerCase().contains(RegExp(
              r'processor|motherboard|cooler cpu|case|gpu|psu|ram|storage|fan|monitor')))
          .toList();
      totalPage = (listCategory.length / 4).ceil();
      changeIndexCategory();
      if (widget.userPC.motherboardSpecification != null) {
        addListAutoGen(widget.userPC.motherboardSpecification!.toJson());
      }
      if (widget.userPC.processorSpecification != null) {
        addListAutoGen(widget.userPC.processorSpecification!.toJson());
      }
      if (widget.userPC.caseSpecification != null) {
        addListAutoGen(widget.userPC.caseSpecification!.toJson());
      }
      if (widget.userPC.gpuSpecification != null) {
        addListAutoGen(widget.userPC.gpuSpecification!.toJson());
      }
      if (widget.userPC.ramSpecification != null) {
        addListAutoGen(widget.userPC.ramSpecification!.toJson(),
            quantity: widget.userPC.ramQuantity);
      }
      if (widget.userPC.storageSpecification != null) {
        addListAutoGen(widget.userPC.storageSpecification!.toJson(),
            quantity: widget.userPC.storageQuantity);
      }
      if (widget.userPC.caseCoolerSpecification != null) {
        addListAutoGen(widget.userPC.caseCoolerSpecification!.toJson());
      }
      if (widget.userPC.monitorSpecification != null) {
        addListAutoGen(widget.userPC.monitorSpecification!.toJson());
      }

      if (widget.userPC.cpuCoolerSpecification != null) {
        addListAutoGen(widget.userPC.cpuCoolerSpecification!.toJson());
      }
      if (widget.userPC.psuSpecification != null) {
        addListAutoGen(widget.userPC.psuSpecification!.toJson());
      }
      updatePrice();
      updateTotalPower().then((value) {
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

  Future<void> updateTotalPower() async {
    bool isGpu = true;
    bool isProccessor = true;
    bool isPsu = true;
    for (Product p in listSelectedProduct) {
      if (p.categoryName!.toLowerCase() == "gpu") {
        isGpu = false;
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          gpu = Gpu.fromJson(data);
        }
      }
      if (p.categoryName!.toLowerCase() == "processor") {
        isProccessor = false;
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          processor = Processor.fromJson(data);
        }
      }
      if (p.categoryName!.toLowerCase() == "psu") {
        isPsu = false;
        Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
            p.categoryName ?? "", p.productId ?? "");
        if (data.isNotEmpty) {
          psu = Psu.fromJson(data);
        }
      }
    }
    if (isGpu) {
      gpu = Gpu(productId: "", maxPowerConsumption: 0);
    }
    if (isProccessor) {
      processor = Processor(productId: "", power: 0);
    }
    if (isPsu) {
      psu = Psu(productId: "", power: 0);
    }
    selectedPower = psu.power!;
    totalPower = gpu.maxPowerConsumption! + processor.power!;
  }

  void changeIndexCategory() {
    listIndexCategory = listCategory.skip(indexCategory * 4).take(4).toList();
    if (mounted) {
      setState(() {});
    }
  }

  void addListAutoGen(Map<String, dynamic> json, {int? quantity}) {
    Product p = Product.fromJson(json);
    if (quantity != null) {
      p.quantityCart = quantity;
    }
    listSelectedProduct.add(p);
    listSelectedCartItem.add(CartItem(
      quantity: quantity ?? 1,
      productId: p.productId,
      unitPrice: p.unitPrice,
      images: p.imageLinks,
      productName: p.name,
      categoryName: p.categoryName,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                if (indexCategory == 0) {
                  Navigator.pop(context);
                } else {
                  indexCategory = indexCategory - 1;
                  changeIndexCategory();
                }
                setState(() {
                  isLoading = false;
                });
              },
              child: const Icon(Icons.arrow_back),
            ),
            title: Text(
              "Build PC Recommend",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChooseDeviceScreen(
                                  category: listIndexCategory[index],
                                  listSelectedProduct: listSelectedProduct,
                                  estimatePower: totalPower,
                                ),
                              ),
                            ).then((product) {});
                          },
                          onTapEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChooseDeviceScreen(
                                  category: listIndexCategory[index],
                                  listSelectedProduct: listSelectedProduct,
                                  estimatePower: totalPower,
                                ),
                              ),
                            ).then((product) {});
                          },
                          onTapDelete: () {},
                          cartItem: listSelectedCartItem.firstWhere(
                              (element) => element.categoryName!
                                  .toLowerCase()
                                  .contains(listIndexCategory[index]
                                      .name!
                                      .toLowerCase()),
                              orElse: () => CartItem(productId: "")),
                          onTapPlus: (productId) {
                            listSelectedCartItem.map((element) {
                              if (element.productId == productId) {
                                element.quantity = element.quantity! + 1;
                              }
                            }).toList();
                            updatePrice();
                            updateTotalPower().then((value) {
                              if (mounted) {
                                setState(() {});
                              }
                            });
                          },
                          onTapMinus: (productId) {
                            listSelectedCartItem.map((element) {
                              if (element.productId == productId &&
                                  element.quantity! > 1) {
                                element.quantity = element.quantity! - 1;
                              }
                            }).toList();
                            updatePrice();
                            updateTotalPower().then((value) {
                              if (mounted) {
                                setState(() {});
                              }
                            });
                          },
                          onTapProduct: () {
                            Navigator.pushNamed(
                              context,
                              DetailsScreen.routeName,
                              arguments: {
                                "product": listSelectedProduct.firstWhere(
                                    (element) => element.categoryName!
                                        .toLowerCase()
                                        .contains(listIndexCategory[index]
                                            .name!
                                            .toLowerCase())),
                                "isBuildPC": true,
                                "isView": true,
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "PSU's Watt:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${selectedPower}W",
                          style: const TextStyle(
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
                            "Total:",
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
                          if (user.userId == "") {
                            Navigator.pushNamed(
                                context, SignInScreen.routeName);
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            PCBuilderAPI.copyBuildPC(
                                    widget.userPC.userPcBuildId ?? "")
                                .then((data) {
                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                              Navigator.pop(context, data);
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
                              ? "Add PC Build"
                              : "Continue",
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
