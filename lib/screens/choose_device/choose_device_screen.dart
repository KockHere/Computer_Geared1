import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/PCComponentAPI.dart';
import 'package:shop_app/controllers/ProductAPI.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/specifications/Case.dart';
import 'package:shop_app/models/specifications/Gpu.dart';
import 'package:shop_app/models/specifications/Motherboard.dart';
import 'package:shop_app/models/specifications/Processor.dart';
import 'package:shop_app/models/specifications/Ram.dart';
import 'package:shop_app/models/specifications/Storage.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/variables.dart';

import '../details/details_screen.dart';

class ChooseDeviceScreen extends StatefulWidget {
  const ChooseDeviceScreen({
    super.key,
    required this.category,
    required this.listSelectedProduct,
    required this.estimatePower,
  });

  final Category category;
  final List<Product> listSelectedProduct;
  final int estimatePower;

  @override
  State<ChooseDeviceScreen> createState() => _ChooseDeviceScreenState();
}

class _ChooseDeviceScreenState extends State<ChooseDeviceScreen> {
  String selectedSort = "ASC";
  Brand selectedBrand = Brand(productBrandId: "", productBrandName: "All");

  List<String> listSort = ["ASC", "DESC"];

  List<Product> listProduct = [];

  List<Product> listAllProductCate = [];

  Processor processor = Processor(productId: "");
  Motherboard motherboard = Motherboard(productId: "");
  Case caseSpec = Case(productId: "");
  Gpu gpu = Gpu(productId: "");
  Ram ram = Ram(productId: "");
  Storage storage = Storage(productId: "");

  @override
  void initState() {
    super.initState();
    widget.category.brandList!.add(selectedBrand);
    initScreen();
  }

  @override
  void dispose() {
    super.dispose();
    widget.category.brandList!
        .removeWhere((element) => element.productBrandId == "");
  }

  Future<void> initScreen() async {
    setState(() {
      isLoading = true;
    });
    if (widget.category.name!.toLowerCase() == "monitor" ||
        widget.category.name!.toLowerCase() == "psu" ||
        widget.category.name!.toLowerCase() == "cooler cpu" ||
        widget.category.name!.toLowerCase() == "fan") {
      // PCComponentAPI.getListProductComponent(widget.category.name!)
      //     .then((products) {
      //   listProduct = products;
      //   listAllProductCate = products;
      //   if (widget.category.name!.toLowerCase() == "psu") {
      //     listProduct = listProduct
      //         .where((element) => element.power! >= widget.estimatePower)
      //         .toList();
      //     listAllProductCate = listAllProductCate
      //         .where((element) => element.power! >= widget.estimatePower)
      //         .toList();
      //   }
      //   if (mounted) {
      //     setState(() {
      //       isLoading = false;
      //     });
      //   }
      // });
      ProductAPI.getListProduct().then((products) {
        listProduct = products
            .where((element) => element.categoryName!
                .toLowerCase()
                .contains(widget.category.name!.toLowerCase()))
            .toList();
        listAllProductCate = products
            .where((element) => element.categoryName!
                .toLowerCase()
                .contains(widget.category.name!.toLowerCase()))
            .toList();
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    } else {
      for (Product p in widget.listSelectedProduct) {
        if (p.categoryName!.toLowerCase() !=
            widget.category.name!.toLowerCase()) {
          await checkMainComponent(p, "processor");
          await checkMainComponent(p, "motherboard");
          await checkMainComponent(p, "case");
          await checkMainComponent(p, "gpu");
          await checkMainComponent(p, "ram");
          await checkMainComponent(p, "storage");
        }
      }
      // if (processor.productId != "" ||
      //     motherboard.productId != "" ||
      //     caseSpec.productId != "" ||
      //     gpu.productId != "" ||
      //     ram.productId != "" ||
      //     storage.productId != "") {
      PCComponentAPI.getListProductComponentPost(
              widget.category.name!,
              processor,
              motherboard,
              caseSpec,
              gpu,
              ram,
              storage,
              widget.listSelectedProduct)
          .then((products) {
        listProduct = products;
        listAllProductCate = products;
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
      // } else  {
      //   ProductAPI.getListProduct().then((products) {
      //     listProduct = products
      //         .where((element) => element.categoryName!
      //             .toLowerCase()
      //             .contains(widget.category.name!.toLowerCase()))
      //         .toList();
      //     listAllProductCate = products
      //         .where((element) => element.categoryName!
      //             .toLowerCase()
      //             .contains(widget.category.name!.toLowerCase()))
      //         .toList();
      //     if (mounted) {
      //       setState(() {
      //         isLoading = false;
      //       });
      //     }
      //   });
      // }
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  Future<void> checkMainComponent(Product p, String category) async {
    if (p.categoryName!.toLowerCase() == category) {
      Map<String, dynamic> data = await PCComponentAPI.getProductComponent(
          p.categoryName ?? "", p.productId ?? "");
      if (data.isNotEmpty) {
        if (category == "processor") {
          processor = Processor.fromJson(data);
        } else if (category == "motherboard") {
          motherboard = Motherboard.fromJson(data);
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick ${widget.category.name!}"),
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
                  listProduct = listAllProductCate;
                } else {
                  listProduct = listAllProductCate
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
                        childAspectRatio: 0.45,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) => ChooseDeviceCard(
                        product: listProduct[index],
                        onPress: () => Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments: {
                            "product": listProduct[index],
                            "isBuildPC": true,
                            "motherboard": motherboard,
                          },
                        ).then((product) {
                          if (product != null) {
                            Navigator.pop(context, product);
                          }
                        }),
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

class ChooseDeviceCard extends StatelessWidget {
  const ChooseDeviceCard({
    super.key,
    required this.product,
    required this.onPress,
  });

  final Product product;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(product.imageLinks!.isNotEmpty
                  ? product.imageLinks![0]
                  : "https://lh3.googleusercontent.com/icxPo1Rqyjc1XkfEpTq6NJx3p1mFclraPE3mp3uxCUDBoHXuhbq8WMGMiwE3L4czehocmdRCuSyBF9QOU4DQhz30eIjekvNm=rw"),
            ),
            SizedBox(
              height: 40,
              child: Text(
                product.name ?? "",
                style: const TextStyle(fontWeight: FontWeight.w600),
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 60,
              child: Text(
                product.description ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${product.unitPrice}đ",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.pop(context, product);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: kPrimaryColor,
                ),
                child: const Text(
                  "Add Product",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
