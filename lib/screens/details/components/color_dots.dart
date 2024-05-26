import 'package:flutter/material.dart';

import '../../../components/rounded_icon_btn.dart';
import '../../../constants.dart';
import '../../../models/Product.dart';

class ColorDots extends StatelessWidget {
  const ColorDots({
    super.key,
    required this.product,
    required this.quantity,
    required this.onTapMinus,
    required this.onTapPlus,
    required this.isShowQuantity,
  });

  final Product product;
  final int quantity;
  final Function() onTapMinus;
  final Function() onTapPlus;
  final bool isShowQuantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          if (isShowQuantity) ...[
            RoundedIconBtn(
              icon: Icons.remove,
              showShadow: true,
              press: onTapMinus,
            ),
            const SizedBox(width: 4),
            Text(
              "$quantity",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 4),
            RoundedIconBtn(
              icon: Icons.add,
              showShadow: true,
              press: onTapPlus,
            ),
          ],
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    super.key,
    required this.color,
    this.isSelected = false,
  });

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      padding: const EdgeInsets.all(8),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
