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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
              color: isCheck ? kPrimaryColor : Colors.white,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(purposeText),
      ],
    );
  }
}
