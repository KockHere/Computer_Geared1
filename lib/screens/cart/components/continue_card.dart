import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/checkout/checkout_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/variables.dart';

class ContinueCard extends StatelessWidget {
  const ContinueCard({
    super.key,
    required this.totalPrice,
  });

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
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
                      if (user.userId == "") {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      } else {
                        if (totalPrice != 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CheckoutScreen()),
                          );
                        }
                      }
                    },
                    child: const Text("Continue"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
