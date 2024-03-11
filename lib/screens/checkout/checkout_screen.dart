import 'package:flutter/material.dart';
import 'package:shop_app/components/payment_card.dart';

import 'package:shop_app/constants.dart';
import 'package:shop_app/models/CartItem.dart';
import 'package:shop_app/models/Payment.dart';
import 'package:shop_app/screens/checkout/components/cart_card.dart';
import 'package:shop_app/screens/payment/payment_screen.dart';
import 'package:shop_app/screens/shipping_address/shipping_address_screen.dart';
import 'package:shop_app/variables.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Xác nhận",
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
                "Thông tin khách hàng",
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
                        builder: (context) => const ShippingAddressScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recipient's Name",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "0987654321",
                                style: TextStyle(
                                  color: inActiveIconColor,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "123 abc, ward, district, city",
                                style: TextStyle(
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
                "Phương thức thanh toán",
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
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: PaymentCard(
                          payment: Payment(
                            paymentId: "1",
                            paymentImage:
                                "https://cdn.haitrieu.com/wp-content/uploads/2022/10/Logo-ZaloPay-Square.png",
                            paymentMethod: "ZaloPay",
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
                "Danh sách sản phẩm",
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
                  ...List.generate(
                    listCartItem.length,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      child: CartCard(cartItem: listCartItem[index]),
                    ),
                  ),
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
                        text: "Tổng:\n",
                        children: [
                          TextSpan(
                            text: "${formatCurrency(totalPrice).replaceAll(".", ",")}đ",
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Xác nhận"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
