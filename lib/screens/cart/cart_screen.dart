import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/CartAPI.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/cart/components/cart_container.dart';
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
  Map<String, List<CartItem>> listCartBuildPc = {};
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    for (Cart element in listUserCart) {
      if (element.personalBuildPcId == "" || element.buildPcDetail == null) {
        if (element.productList!.isNotEmpty) {
          listCartItem.add(element.productList!.first);
        }
      } else if (element.personalBuildPcId != "") {
        List<CartItem> listCartItemBuildPc = [];
        if (element.buildPcDetail!.motherboardSpecification != null) {
          listCartItemBuildPc.add(CartItem.fromJson1(
              element.buildPcDetail!.motherboardSpecification!.toJson()));
        }
        if (element.buildPcDetail!.processorSpecification != null) {
          listCartItemBuildPc.add(CartItem.fromJson1(
              element.buildPcDetail!.processorSpecification!.toJson()));
        }
        if (element.buildPcDetail!.caseSpecification != null) {
          listCartItemBuildPc.add(CartItem.fromJson1(
              element.buildPcDetail!.caseSpecification!.toJson()));
        }
        if (element.buildPcDetail!.gpuSpecification != null) {
          listCartItemBuildPc.add(CartItem.fromJson1(
              element.buildPcDetail!.gpuSpecification!.toJson()));
        }
        if (element.buildPcDetail!.ramSpecification != null) {
          CartItem ram = CartItem.fromJson1(
              element.buildPcDetail!.ramSpecification!.toJson());
          ram.quantity = element.buildPcDetail!.ramQuantity;
          listCartItemBuildPc.add(ram);
        }
        if (element.buildPcDetail!.storageSpecification != null) {
          CartItem storage = CartItem.fromJson1(
              element.buildPcDetail!.storageSpecification!.toJson());
          storage.quantity = element.buildPcDetail!.storageQuantity;
          listCartItemBuildPc.add(storage);
        }
        if (element.buildPcDetail!.caseCoolerSpecification != null) {
          listCartItemBuildPc.add(CartItem.fromJson1(
              element.buildPcDetail!.caseCoolerSpecification!.toJson()));
        }
        if (element.buildPcDetail!.monitorSpecification != null) {
          listCartItemBuildPc.add(CartItem.fromJson1(
              element.buildPcDetail!.monitorSpecification!.toJson()));
        }
        if (element.buildPcDetail!.cpuCoolerSpecification != null) {
          listCartItemBuildPc.add(CartItem.fromJson1(
              element.buildPcDetail!.cpuCoolerSpecification!.toJson()));
        }
        if (element.buildPcDetail!.psuSpecification != null) {
          listCartItemBuildPc.add(CartItem.fromJson1(
              element.buildPcDetail!.psuSpecification!.toJson()));
        }
        listCartBuildPc[
                "${element.cartItemId}&&${element.buildPcDetail!.profileName!}"] =
            listCartItemBuildPc;
      }
    }
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
    listCartBuildPc.forEach((key, value) {
      for (CartItem cartItem in value) {
        totalPrice += double.parse(cartItem.unitPrice!.replaceAll(",", "")) *
            cartItem.quantity!;
      }
    });
  }

  Future<bool> confirmDismiss(CartItem cartItem, int index) async {
    setState(() {
      isLoading = true;
    });
    if (user.userId == "") {
      // userCart.productTotal = (int.parse(userCart.productTotal!) -
      //         userCart.productList![index].quantity!)
      //     .toString();
      // userCart.productList!.removeAt(index);
      // listCartItem = userCart.productList ?? [];

      // prefs.then((dataPrefs) {
      //   dataPrefs.setString("USER_CART", userCart.toJson().toString());
      // });
      // getTotalPrice();
      // setState(() {
      //   isLoading = false;
      // });
      // return true;
    } else {
      CartAPI.updateQuantityCartItem(
        cartItem.cartItemId ?? "",
        0,
      ).then((result) {
        if (result) {
          CartAPI.getUserCart().then((cart) {
            listCartItem = [];
            for (Cart element in listUserCart) {
              if (element.personalBuildPcId == "" &&
                  element.productList!.isNotEmpty) {
                listCartItem.add(element.productList!.first);
              }
            }
            getTotalPrice();
            setState(() {
              isLoading = false;
            });
            showDialogDeleteCartItemSuccess(context);
          });
          return true;
        }
      });
    }
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
              "Cart",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              (listCartItem.isEmpty ? "" : "${listCartItem.length} Product") +
                  (listCartItem.isEmpty || listCartBuildPc == {}
                      ? ""
                      : " And ") +
                  (listCartBuildPc == {}
                      ? ""
                      : "${listCartBuildPc.length} PC Build"),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          listCartItem.isEmpty && listCartBuildPc == {}
              ? const Center(child: Text("Cart is empty..."))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...listCartBuildPc.entries.map((e) => CartContainer(
                              name: e.key,
                              cartItems: e.value,
                              onTapDelete: () {
                                setState(() {
                                  isLoading = true;
                                });
                                CartAPI.deleteBuildPcCartItem(
                                        e.key.split("&&")[0])
                                    .then((result) {
                                  if (result) {
                                    CartAPI.getUserCart().then((cart) {
                                      listCartItem = [];
                                      listCartBuildPc = {};
                                      for (Cart element in listUserCart) {
                                        if (element.personalBuildPcId == "" &&
                                            element.productList!.isNotEmpty) {
                                          listCartItem
                                              .add(element.productList!.first);
                                        } else if (element.personalBuildPcId !=
                                            "") {
                                          List<CartItem> listCartItemBuildPc =
                                              [];
                                          if (element.buildPcDetail!
                                                  .motherboardSpecification !=
                                              null) {
                                            listCartItemBuildPc.add(
                                                CartItem.fromJson1(element
                                                    .buildPcDetail!
                                                    .motherboardSpecification!
                                                    .toJson()));
                                          }
                                          if (element.buildPcDetail!
                                                  .processorSpecification !=
                                              null) {
                                            listCartItemBuildPc.add(
                                                CartItem.fromJson1(element
                                                    .buildPcDetail!
                                                    .processorSpecification!
                                                    .toJson()));
                                          }
                                          if (element.buildPcDetail!
                                                  .caseSpecification !=
                                              null) {
                                            listCartItemBuildPc.add(
                                                CartItem.fromJson1(element
                                                    .buildPcDetail!
                                                    .caseSpecification!
                                                    .toJson()));
                                          }
                                          if (element.buildPcDetail!
                                                  .gpuSpecification !=
                                              null) {
                                            listCartItemBuildPc.add(
                                                CartItem.fromJson1(element
                                                    .buildPcDetail!
                                                    .gpuSpecification!
                                                    .toJson()));
                                          }
                                          if (element.buildPcDetail!
                                                  .ramSpecification !=
                                              null) {
                                            CartItem ram = CartItem.fromJson1(
                                                element.buildPcDetail!
                                                    .ramSpecification!
                                                    .toJson());
                                            ram.quantity = element
                                                .buildPcDetail!.ramQuantity;
                                            listCartItemBuildPc.add(ram);
                                          }
                                          if (element.buildPcDetail!
                                                  .storageSpecification !=
                                              null) {
                                            CartItem storage =
                                                CartItem.fromJson1(element
                                                    .buildPcDetail!
                                                    .storageSpecification!
                                                    .toJson());
                                            storage.quantity = element
                                                .buildPcDetail!.storageQuantity;
                                            listCartItemBuildPc.add(storage);
                                          }
                                          if (element.buildPcDetail!
                                                  .caseCoolerSpecification !=
                                              null) {
                                            listCartItemBuildPc.add(
                                                CartItem.fromJson1(element
                                                    .buildPcDetail!
                                                    .caseCoolerSpecification!
                                                    .toJson()));
                                          }
                                          if (element.buildPcDetail!
                                                  .monitorSpecification !=
                                              null) {
                                            listCartItemBuildPc.add(
                                                CartItem.fromJson1(element
                                                    .buildPcDetail!
                                                    .monitorSpecification!
                                                    .toJson()));
                                          }
                                          if (element.buildPcDetail!
                                                  .cpuCoolerSpecification !=
                                              null) {
                                            listCartItemBuildPc.add(
                                                CartItem.fromJson1(element
                                                    .buildPcDetail!
                                                    .cpuCoolerSpecification!
                                                    .toJson()));
                                          }
                                          if (element.buildPcDetail!
                                                  .psuSpecification !=
                                              null) {
                                            listCartItemBuildPc.add(
                                                CartItem.fromJson1(element
                                                    .buildPcDetail!
                                                    .psuSpecification!
                                                    .toJson()));
                                          }
                                          listCartBuildPc[
                                                  "${element.cartItemId}&&${element.buildPcDetail!.profileName!}"] =
                                              listCartItemBuildPc;
                                        }
                                      }
                                      getTotalPrice();
                                      if (mounted) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                      showDialogDeleteCartItemSuccess(context);
                                    });
                                  } else {
                                    if (mounted) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  }
                                });
                              },
                            )),
                        listCartItem.isEmpty
                            ? Container()
                            : Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xfff6f6f6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Other product",
                                      style: TextStyle(
                                        color: inActiveIconColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ListView.builder(
                                      itemCount: listCartItem.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Dismissible(
                                          key: Key(listCartItem[index]
                                              .cartItemId
                                              .toString()),
                                          direction:
                                              DismissDirection.endToStart,
                                          confirmDismiss: (direction) =>
                                              confirmDismiss(
                                                  listCartItem[index], index),
                                          background: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFE6E6),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Row(
                                              children: [
                                                const Spacer(),
                                                SvgPicture.asset(
                                                    "assets/icons/Trash.svg"),
                                              ],
                                            ),
                                          ),
                                          child: CartCard(
                                            cartItem: listCartItem[index],
                                            onTapMinus: () {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              if (user.userId == "") {
                                                // userCart.productList![index].quantity =
                                                //     userCart.productList![index].quantity! - 1;
                                                // if (userCart.productList![index].quantity == 0) {
                                                //   userCart.productList!.removeAt(index);
                                                // }
                                                // listCartItem = userCart.productList ?? [];
                                                // userCart.productTotal =
                                                //     (int.parse(userCart.productTotal!) - 1)
                                                //         .toString();
                                                // prefs.then((dataPrefs) {
                                                //   dataPrefs.setString(
                                                //       "USER_CART", jsonEncode(userCart.toJson()));
                                                // });
                                                // getTotalPrice();
                                                // setState(() {
                                                //   isLoading = false;
                                                // });
                                              } else {
                                                CartAPI.updateQuantityCartItem(
                                                  listCartItem[index]
                                                          .cartItemId ??
                                                      "",
                                                  listCartItem[index]
                                                          .quantity! -
                                                      1,
                                                ).then((result) {
                                                  if (result) {
                                                    CartAPI.getUserCart()
                                                        .then((cart) {
                                                      listCartItem = [];
                                                      for (Cart element
                                                          in listUserCart) {
                                                        if (element.personalBuildPcId ==
                                                                "" &&
                                                            element.productList!
                                                                .isNotEmpty) {
                                                          listCartItem.add(
                                                              element
                                                                  .productList!
                                                                  .first);
                                                        }
                                                      }
                                                      getTotalPrice();
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    });
                                                  }
                                                });
                                              }
                                            },
                                            onTapPlus: () {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              if (user.userId == "") {
                                                // userCart.productList![index].quantity =
                                                //     userCart.productList![index].quantity! + 1;
                                                // listCartItem = userCart.productList ?? [];
                                                // userCart.productTotal =
                                                //     (int.parse(userCart.productTotal!) + 1)
                                                //         .toString();
                                                // prefs.then((dataPrefs) {
                                                //   dataPrefs.setString(
                                                //       "USER_CART", jsonEncode(userCart.toJson()));
                                                // });
                                                // getTotalPrice();
                                                // setState(() {
                                                //   isLoading = false;
                                                // });
                                              } else {
                                                CartAPI.updateQuantityCartItem(
                                                  listCartItem[index]
                                                          .cartItemId ??
                                                      "",
                                                  listCartItem[index]
                                                          .quantity! +
                                                      1,
                                                ).then((result) {
                                                  if (result) {
                                                    CartAPI.getUserCart()
                                                        .then((cart) {
                                                      listCartItem = [];
                                                      for (Cart element
                                                          in listUserCart) {
                                                        if (element
                                                                .personalBuildPcId ==
                                                            "") {
                                                          listCartItem.add(
                                                              element
                                                                  .productList!
                                                                  .first);
                                                        }
                                                      }
                                                      getTotalPrice();
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    });
                                                  }
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        const SizedBox(height: 20),
                      ],
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
