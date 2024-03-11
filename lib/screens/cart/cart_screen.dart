import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/controllers/CartAPI.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/show_dialog.dart';
import 'package:shop_app/variables.dart';

import '../../models/CartItem.dart';
import 'components/cart_card.dart';
import 'components/continue_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> listCartItem = [];
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    listCartItem = userCart.productList ?? [];
    getTotalPrice();
    if (mounted) {
      setState(() {});
    }
  }

  void getTotalPrice() {
    totalPrice = 0;
    for (CartItem cartItem in listCartItem) {
      totalPrice += double.parse(cartItem.unitPrice!.replaceAll(",", "")) *
          cartItem.quantity!;
    }
  }

  Future<bool> confirmDismiss(CartItem cartItem) async {
    setState(() {
      isLoading = true;
    });
    CartAPI.updateQuantityCartItem(
      cartItem.cartItemId ?? "",
      0,
    ).then((result) {
      if (result) {
        CartAPI.getUserCart().then((cart) {
          listCartItem = userCart.productList ?? [];
          getTotalPrice();
          setState(() {
            isLoading = false;
          });
          showDialogDeleteCartItemSuccess(context);
        });
        return true;
      }
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Giỏ hàng",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${listCartItem.length} sản phẩm",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          listCartItem.isEmpty
              ? const Center(
                  child: Text("Chưa có sản phẩm nào trong giỏ hàng"))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemCount: listCartItem.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Dismissible(
                        key: Key(listCartItem[index].cartItemId.toString()),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) =>
                            confirmDismiss(listCartItem[index]),
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              const Spacer(),
                              SvgPicture.asset("assets/icons/Trash.svg"),
                            ],
                          ),
                        ),
                        child: CartCard(
                          cartItem: listCartItem[index],
                          onTapMinus: () {
                            setState(() {
                              isLoading = true;
                            });
                            CartAPI.updateQuantityCartItem(
                              listCartItem[index].cartItemId ?? "",
                              listCartItem[index].quantity! - 1,
                            ).then((result) {
                              if (result) {
                                CartAPI.getUserCart().then((cart) {
                                  listCartItem = userCart.productList ?? [];
                                  getTotalPrice();
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              }
                            });
                          },
                          onTapPlus: () {
                            setState(() {
                              isLoading = true;
                            });
                            CartAPI.updateQuantityCartItem(
                              listCartItem[index].cartItemId ?? "",
                              listCartItem[index].quantity! + 1,
                            ).then((result) {
                              if (result) {
                                CartAPI.getUserCart().then((cart) {
                                  listCartItem = userCart.productList ?? [];
                                  getTotalPrice();
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
          isLoading ? const LoadingScreen() : Container(),
        ],
      ),
      bottomNavigationBar: ContinueCard(totalPrice: totalPrice),
    );
  }
}
