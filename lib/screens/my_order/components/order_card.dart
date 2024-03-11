import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/CartItem.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.cartItem,
    required this.orderStatus,
    required this.onTap,
  }) : super(key: key);

  final CartItem cartItem;
  final String orderStatus;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(right: 16),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            // SizedBox(
            //   width: 88,
            //   child: AspectRatio(
            //     aspectRatio: 0.88,
            //     child: Image.network(cartItem.product!.imageLinks!.isNotEmpty
            //         ? cartItem.product!.imageLinks![0]
            //         : "https://lh3.googleusercontent.com/icxPo1Rqyjc1XkfEpTq6NJx3p1mFclraPE3mp3uxCUDBoHXuhbq8WMGMiwE3L4czehocmdRCuSyBF9QOU4DQhz30eIjekvNm=rw"),
            //   ),
            // ),
            // const SizedBox(width: 10),
            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         cartItem.product!.name ?? "",
            //         style: const TextStyle(color: Colors.black, fontSize: 16),
            //         maxLines: 3,
            //       ),
            //       const Text(
            //         "và 1 sản phẩm khác",
            //         style: TextStyle(color: Colors.grey, fontSize: 12),
            //       ),
            //       const SizedBox(height: 8),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             "${cartItem.product!.unitPrice}đ",
            //             style: const TextStyle(
            //                 fontWeight: FontWeight.w600, color: kPrimaryColor),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.symmetric(
            //                 vertical: 8, horizontal: 16),
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(20),
            //               color: orderStatus == "Hoàn thành"
            //                   ? Colors.green.withOpacity(0.3)
            //                   : orderStatus == "Hủy"
            //                       ? Colors.red.withOpacity(0.3)
            //                       : Colors.blue.withOpacity(0.3),
            //             ),
            //             child: Text(
            //               orderStatus,
            //               style: TextStyle(
            //                 fontWeight: FontWeight.w600,
            //                 color: orderStatus == "Hoàn thành"
            //                     ? Colors.green
            //                     : orderStatus == "Hủy"
            //                         ? Colors.red
            //                         : Colors.blue,
            //               ),
            //             ),
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
