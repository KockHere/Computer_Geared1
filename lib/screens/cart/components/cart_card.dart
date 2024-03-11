import 'package:flutter/material.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';

import '../../../constants.dart';
import '../../../models/CartItem.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cartItem,
    required this.onTapMinus,
    required this.onTapPlus,
  }) : super(key: key);

  final CartItem cartItem;
  final Function() onTapMinus;
  final Function() onTapPlus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.network(cartItem.images!.isNotEmpty
                    ? cartItem.images![0]
                    : "https://lh3.googleusercontent.com/icxPo1Rqyjc1XkfEpTq6NJx3p1mFclraPE3mp3uxCUDBoHXuhbq8WMGMiwE3L4czehocmdRCuSyBF9QOU4DQhz30eIjekvNm=rw"),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.productName ?? "",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${cartItem.unitPrice}đ",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: kPrimaryColor),
                    ),
                    Row(
                      children: [
                        RoundedIconBtn(
                          icon: Icons.remove,
                          showShadow: true,
                          press: onTapMinus,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "x${cartItem.quantity}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        RoundedIconBtn(
                          icon: Icons.add,
                          showShadow: true,
                          press: onTapPlus,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
