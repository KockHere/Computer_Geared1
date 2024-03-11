import 'package:flutter/material.dart';
import 'package:shop_app/models/Payment.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    Key? key,
    required this.payment,
  }) : super(key: key);

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            height: 28,
            width: 28,
            child: Image.network(
                payment.paymentImage ?? "https://cdn.haitrieu.com/wp-content/uploads/2022/10/Logo-ZaloPay-Square.png"),
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
