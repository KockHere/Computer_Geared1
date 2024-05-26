import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/CartItem.dart';
import 'package:shop_app/models/Category.dart';

class BuildPCCard extends StatelessWidget {
  const BuildPCCard({
    super.key,
    required this.category,
    required this.onTap,
    required this.onTapEdit,
    required this.onTapDelete,
    required this.cartItem,
    required this.onTapPlus,
    required this.onTapMinus,
    required this.onTapProduct,
  });

  final Category category;
  final Function() onTap;
  final Function() onTapEdit;
  final Function() onTapDelete;
  final CartItem cartItem;
  final Function(String?) onTapPlus;
  final Function(String?) onTapMinus;
  final Function() onTapProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.description ?? "",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          if (cartItem.productId != "") ...[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: onTapProduct,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        cartItem.images!.isNotEmpty
                            ? cartItem.images![0]
                            : "https://lh3.googleusercontent.com/icxPo1Rqyjc1XkfEpTq6NJx3p1mFclraPE3mp3uxCUDBoHXuhbq8WMGMiwE3L4czehocmdRCuSyBF9QOU4DQhz30eIjekvNm=rw",
                        errorBuilder: (context, error, stackTrace) => Image.network(
                            "https://lh3.googleusercontent.com/icxPo1Rqyjc1XkfEpTq6NJx3p1mFclraPE3mp3uxCUDBoHXuhbq8WMGMiwE3L4czehocmdRCuSyBF9QOU4DQhz30eIjekvNm=rw"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.productName ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${formatCurrency(double.parse(cartItem.unitPrice!.replaceAll(",", ""))).replaceAll(".", ",")}đ",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      // RoundedIconBtn(
                      //   icon: Icons.add,
                      //   showShadow: true,
                      //   press: () {
                      //     onTapPlus(cartItem.productId);
                      //   },
                      // ),
                      const SizedBox(height: 4),
                      Text(
                        "x${cartItem.quantity}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 4),
                      // RoundedIconBtn(
                      //   icon: Icons.remove,
                      //   showShadow: true,
                      //   press: () {
                      //     onTapMinus(cartItem.productId);
                      //   },
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
