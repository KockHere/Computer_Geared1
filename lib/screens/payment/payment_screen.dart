import 'package:flutter/material.dart';
import 'package:shop_app/components/payment_card.dart';

import 'package:shop_app/models/Payment.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<Payment> listPayment = [
    Payment(
      paymentId: "1",
      paymentImage:
          "https://cdn.haitrieu.com/wp-content/uploads/2022/10/Logo-ZaloPay-Square.png",
      paymentMethod: "ZaloPay",
    ),
    Payment(
      paymentId: "2",
      paymentImage:
          "https://cdn.haitrieu.com/wp-content/uploads/2022/10/Logo-ZaloPay-Square.png",
      paymentMethod: "Credit Card",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Phương thức thanh toán",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                listPayment.length,
                (index) => Container(
                  color: Colors.white,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: PaymentCard(payment: listPayment[index]),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
