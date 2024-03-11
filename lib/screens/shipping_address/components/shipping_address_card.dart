import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/ShippingAddress.dart';

class ShippingAddressCard extends StatelessWidget {
  const ShippingAddressCard({
    Key? key,
    required this.shippingAddress,
    required this.isDefault,
    required this.onTap,
  }) : super(key: key);

  final ShippingAddress shippingAddress;
  final bool isDefault;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: kPrimaryColor,
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  shippingAddress.recipientName ?? "",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isDefault) ...[
                  const SizedBox(width: 10),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Text(
                      "Mặc định",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 6),
            Text(
              shippingAddress.phone ?? "",
              style: const TextStyle(
                color: inActiveIconColor,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "${shippingAddress.streetAddress}, ${shippingAddress.ward}, ${shippingAddress.district}, ${shippingAddress.city}",
              style: const TextStyle(
                color: inActiveIconColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
