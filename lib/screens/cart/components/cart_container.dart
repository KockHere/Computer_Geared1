import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/CartItem.dart';
import 'package:shop_app/screens/cart/components/cart_card.dart';

class CartContainer extends StatelessWidget {
  const CartContainer({
    super.key,
    required this.name,
    required this.cartItems,
    required this.onTapDelete,
  });

  final String name;
  final List<CartItem> cartItems;
  final Function() onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xfff6f6f6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name.split("&&")[1],
                  style: const TextStyle(
                    color: inActiveIconColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTapDelete,
                child: const Icon(Icons.clear),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ListView.builder(
            itemCount: cartItems.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CartCard(
                cartItem: cartItems[index],
                onTapMinus: () {},
                onTapPlus: () {},
                isShow: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
