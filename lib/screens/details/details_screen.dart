import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/controllers/CartAPI.dart';
import 'package:shop_app/models/CartItem.dart';
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
  Product product = Product();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ProductDetailsArguments data =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    product = data.product;
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
                    ProductDescription(product: product),
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
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: TopRoundedContainer(
            color: Colors.white,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: ElevatedButton(
                  onPressed: () {
                    if (user.userId == "") {
                      Navigator.pushNamed(context, SignInScreen.routeName);
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
                        setState(() {
                          isLoading = false;
                        });
                        showDialogAddToCartSuccess(context);
                      });
                    }
                  },
                  child: const Text("Thêm vào giỏ hàng"),
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

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
