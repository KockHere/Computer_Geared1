import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';

import '../details/details_screen.dart';

class ChooseDeviceScreen extends StatelessWidget {
  const ChooseDeviceScreen({
    Key? key,
    required this.title,
    required this.products,
  }) : super(key: key);

  final String title;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn $title"),
      ),
      body: SafeArea(
        child: products.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(20),
                color: const Color(0xfff6f6f6),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.46,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) => ChooseDeviceCard(
                    product: products[index],
                    onPress: () => Navigator.pushNamed(
                      context,
                      DetailsScreen.routeName,
                      arguments:
                          ProductDetailsArguments(product: products[index]),
                    ),
                  ),
                ),
              )
            : const Center(child: Text("Không có sản phẩm nào")),
      ),
    );
  }
}

class ChooseDeviceCard extends StatelessWidget {
  const ChooseDeviceCard({
    Key? key,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final Product product;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(product.imageLinks!.isNotEmpty
                  ? product.imageLinks![0]
                  : "https://lh3.googleusercontent.com/icxPo1Rqyjc1XkfEpTq6NJx3p1mFclraPE3mp3uxCUDBoHXuhbq8WMGMiwE3L4czehocmdRCuSyBF9QOU4DQhz30eIjekvNm=rw"),
            ),
            SizedBox(
              height: 40,
              child: Text(
                product.name ?? "",
                style: const TextStyle(fontWeight: FontWeight.w600),
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 60,
              child: Text(
                product.description ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${product.unitPrice}đ",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.pop(context, product.productId);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: kPrimaryColor,
                ),
                child: const Text(
                  "Choose product",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
