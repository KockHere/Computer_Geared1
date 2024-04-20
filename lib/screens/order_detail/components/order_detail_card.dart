import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/OrderDetail.dart';

class OrderDetailCard extends StatelessWidget {
  const OrderDetailCard({
    super.key,
    required this.orderDetail,
  });

  final OrderDetail orderDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Image.network(orderDetail.productImg != null
                  ? orderDetail.productImg!
                  : "https://lh3.googleusercontent.com/icxPo1Rqyjc1XkfEpTq6NJx3p1mFclraPE3mp3uxCUDBoHXuhbq8WMGMiwE3L4czehocmdRCuSyBF9QOU4DQhz30eIjekvNm=rw"),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderDetail.productName ?? "",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    text: "${orderDetail.unitPrice}đ",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                    children: [
                      TextSpan(
                          text: " x${orderDetail.quantity}",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
