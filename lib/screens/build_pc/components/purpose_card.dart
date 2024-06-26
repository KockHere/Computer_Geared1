import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class PurposeCard extends StatelessWidget {
  const PurposeCard({
    super.key,
    required this.isCheck,
    required this.purposeText,
    required this.onTap,
  });

  final bool isCheck;
  final String purposeText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              color: isCheck ? kPrimaryColor : Colors.white,
              shape: BoxShape.circle,
            ),
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(purposeText),
      ],
    );
  }
}
