import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Payment.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.payment,
  });

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          const SizedBox(
            height: 28,
            width: 28,
            child: Icon(Icons.monetization_on_outlined, color: kPrimaryColor),
          ),
          const SizedBox(width: 10),
          Text(
            payment.paymentMethod ?? "",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
