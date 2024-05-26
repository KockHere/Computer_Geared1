import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/OrderDetail.dart';

class OrderDetailCard extends StatelessWidget {
  const OrderDetailCard({
    super.key,
    required this.orderDetail,
    required this.isAllowReview,
    required this.onTapRating,
  });

  final OrderDetail orderDetail;
  final bool isAllowReview;
  final Function() onTapRating;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
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
                Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text:
                              //"${orderDetail.unitPrice}đ",
                              "${formatCurrency(double.parse(orderDetail.unitPrice!.toString())).replaceAll(".", ",")}đ",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                          children: [
                            TextSpan(
                                text: " x${orderDetail.quantity}",
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      ),
                    ),
                    if (isAllowReview) ...[
                      GestureDetector(
                        onTap: onTapRating,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 6),
                                blurRadius: 10,
                                color: const Color(0xFFB0B0B0).withOpacity(0.4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/Star Icon.svg"),
                              const SizedBox(width: 4),
                              const Text(
                                "Rating",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
