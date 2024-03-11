import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/Product.dart';
import 'package:expandable_text/expandable_text.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            product.name ?? "",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        product.brandName == "" ? Container() : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              const Text(
                "Thương hiệu: ",
                style: TextStyle(
                  fontSize: 16,
                  color: kPrimaryColor,
                ),
              ),
              Text(
                "${product.brandName}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "${product.unitPrice}đ",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: ExpandableText(
            product.description ?? "",
            maxLines: 3,
            expandText: "Xem thêm",
            expandOnTextTap: true,
            collapseOnTextTap: true,
            collapseText: "Xem ít",
            linkColor: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}
