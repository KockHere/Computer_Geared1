import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/CartItem.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

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
                Text.rich(
                  TextSpan(
                    text: "${cartItem.unitPrice}đ",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                    children: [
                      TextSpan(
                          text: " x${cartItem.quantity}",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
