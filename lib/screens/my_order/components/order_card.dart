import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Orders.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.orders,
    required this.onTap,
  });

  final Orders orders;
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
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orders.recipientName ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${orders.streetAddress ?? ""}, ${orders.city}",
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  "Product Quantity: ",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  "${orders.totalItems}",
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  "Payment Method: ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  "${orders.paymentMethod}",
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${orders.totalPrice ?? 0}đ",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: orders.statusDetail == "Delivered"
                        ? Colors.green.withOpacity(0.3)
                        : orders.statusDetail == "Canceled"
                            ? Colors.red.withOpacity(0.3)
                            : Colors.blue.withOpacity(0.3),
                  ),
                  child: Text(
                    orders.statusDetail ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: orders.statusDetail == "Delivered"
                          ? Colors.green
                          : orders.statusDetail == "Canceled"
                              ? Colors.red
                              : Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
