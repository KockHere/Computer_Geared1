import 'package:flutter/material.dart';
import 'package:shop_app/components/payment_card.dart';
import 'package:shop_app/controllers/PaymentAPI.dart';

import 'package:shop_app/models/Payment.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/variables.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<Payment> listPayment = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    PaymentAPI.getListPayment().then((payments) {
      listPayment = payments;
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xfff6f6f6),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "Payment Method",
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
                        onTap: () {
                          Navigator.pop(context, listPayment[index]);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 10),
                          child: PaymentCard(payment: listPayment[index]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isLoading ? const LoadingScreen() : Container(),
      ],
    );
  }
}
