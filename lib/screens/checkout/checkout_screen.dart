import 'package:flutter/material.dart';
import 'package:shop_app/components/payment_card.dart';

import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/OrderAPI.dart';
import 'package:shop_app/controllers/PaymentAPI.dart';
import 'package:shop_app/controllers/ShippingAddressAPI.dart';
import 'package:shop_app/controllers/VnPayAPI.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/CartItem.dart';
import 'package:shop_app/models/Payment.dart';
import 'package:shop_app/models/ShippingAddress.dart';
import 'package:shop_app/screens/add_shipping_address/add_shipping_address_screen.dart';
import 'package:shop_app/screens/checkout/components/cart_container.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/screens/payment/payment_screen.dart';
import 'package:shop_app/screens/shipping_address/shipping_address_screen.dart';
import 'package:shop_app/screens/vnpay/vnpay_screen.dart';
import 'package:shop_app/show_dialog.dart';
import 'package:shop_app/variables.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<CartItem> listCartItem = [];
  Map<String, List<CartItem>> listCartBuildPc = {};

  List<ShippingAddress> listShippingAddress = [];
  ShippingAddress shippingAddress = ShippingAddress();

  List<Payment> listPayment = [];
  Payment payment = Payment();
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    PaymentAPI.getListPayment().then((payments) {
      listPayment = payments;
      if (listPayment.isNotEmpty) {
        payment = listPayment[0];
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
    ShippingAddressAPI.getListShippingAddress().then((shippingAddresses) {
      listShippingAddress = shippingAddresses;
      if (listShippingAddress.isEmpty) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AddShippingAddressScreen()),
        ).then((value) {
          getListShippingAddress();
        });
      } else {
        initScreen();
      }
    });
  }

  void initScreen() {
    shippingAddress = listShippingAddress[0];
    listCartItem = [];
    for (Cart element in listUserCart) {
      if (element.personalBuildPcId == "" && element.productList!.isNotEmpty) {
        listCartItem.add(element.productList!.first);
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
      setState(() {
        isLoading = false;
      });
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

  void getListShippingAddress() {
    setState(() {
      isLoading = true;
    });
    ShippingAddressAPI.getListShippingAddress().then((shippingAddresses) {
      listShippingAddress = shippingAddresses;
      if (listShippingAddress.isEmpty) {
        Navigator.pop(context);
      } else {
        initScreen();
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xfff6f6f6),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "Checkout",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Customer's Information:",
                    style: TextStyle(
                      color: inActiveIconColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ShippingAddressScreen()),
                      ).then((newShippingAddress) {
                        if (newShippingAddress != null) {
                          shippingAddress = newShippingAddress;
                          setState(() {});
                        } else {
                          getListShippingAddress();
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shippingAddress.recipientName ?? "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    shippingAddress.recipientPhone ?? "",
                                    style: const TextStyle(
                                      color: inActiveIconColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "${shippingAddress.streetAddress ?? ""}, ${shippingAddress.ward ?? ""}, ${shippingAddress.district ?? ""}, ${shippingAddress.city ?? ""}",
                                    style: const TextStyle(
                                      color: inActiveIconColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Payment Method:",
                    style: TextStyle(
                      color: inActiveIconColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentScreen()),
                      ).then((newPayment) {
                        if (newPayment != null) {
                          payment = newPayment;
                          setState(() {});
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: PaymentCard(payment: payment),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Product List / Build List",
                    style: TextStyle(
                      color: inActiveIconColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 14, 10, 0),
                  child: Column(
                    children: [
                      ...listCartBuildPc.entries.map(
                        (e) => CartContainer(
                          name: e.key,
                          cartItems: e.value,
                        ),
                      ),
                      CartContainer(
                        name: "id&&User Product",
                        cartItems: listCartItem,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            // height: 174,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -15),
                  blurRadius: 20,
                  color: const Color(0xFFDADADA).withOpacity(0.15),
                )
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "Total:\n",
                            children: [
                              TextSpan(
                                text:
                                    "${formatCurrency(totalPrice).replaceAll(".", ",")}đ",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            List<String> listCartItemId = [];
                            for (Cart cart in listUserCart) {
                              listCartItemId.add(cart.cartItemId ?? "");
                            }
                            OrderAPI.createOrders(
                                    payment.paymentId ?? "",
                                    shippingAddress.addressId ?? "",
                                    listCartItemId)
                                .then((result) {
                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                              if (result != "") {
                                if (payment.paymentMethod == "CASH") {
                                  showDialogAddOrderSuccess(context)
                                      .then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const InitScreen(initIndex: 4),
                                      ),
                                    );
                                  });
                                } else {
                                  VnPayAPI.createPayment(result)
                                      .then((vnPayURL) async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VnPayScreen(url: vnPayURL)),
                                    ).then((data) {
                                      if (data != null) {
                                        if (data["success"] == true) {
                                          showDialogAddOrderSuccess(context)
                                              .then((value) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const InitScreen(
                                                        initIndex: 4),
                                              ),
                                            );
                                          });
                                        }
                                      }
                                    });
                                  });
                                }
                              }
                            });
                          },
                          child: const Text("Checkout"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        isLoading ? const LoadingScreen() : Container(),
      ],
    );
  }
}
