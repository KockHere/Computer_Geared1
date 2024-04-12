import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/CartAPI.dart';
import 'package:shop_app/models/CartItem.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/show_dialog.dart';
import 'package:shop_app/variables.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTapAddToCart,
  });

  final Product product;
  final Function() onTapAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: {"product": product},
        ).then((value) {
          onTapAddToCart();
        }),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                product.imageLinks!.isNotEmpty
                    ? product.imageLinks![0]
                    : "https://lh3.googleusercontent.com/icxPo1Rqyjc1XkfEpTq6NJx3p1mFclraPE3mp3uxCUDBoHXuhbq8WMGMiwE3L4czehocmdRCuSyBF9QOU4DQhz30eIjekvNm=rw",
                errorBuilder: (context, error, stackTrace) => Image.network(
                    "https://lh3.googleusercontent.com/icxPo1Rqyjc1XkfEpTq6NJx3p1mFclraPE3mp3uxCUDBoHXuhbq8WMGMiwE3L4czehocmdRCuSyBF9QOU4DQhz30eIjekvNm=rw"),
              ),
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
                isLoading = true;
                onTapAddToCart();
                if (user.userId == "") {
                  isLoading = false;
                  onTapAddToCart();
                  Navigator.pushNamed(context, SignInScreen.routeName);
                  // bool isDup = false;
                  // for (CartItem element in userCart.productList!) {
                  //   if (element.productId == product.productId) {
                  //     isDup = true;
                  //     element.quantity = element.quantity! + 1;
                  //     break;
                  //   }
                  // }
                  // if (!isDup) {
                  //   userCart.productList!.add(
                  //     CartItem(
                  //       quantity: 1,
                  //       productId: product.productId,
                  //       unitPrice: product.unitPrice!,
                  //       images: product.imageLinks ?? [],
                  //       productName: product.name ?? "",
                  //     ),
                  //   );
                  // }

                  // userCart.productTotal =
                  //     (int.parse(userCart.productTotal!) + 1).toString();
                  // prefs.then((dataPrefs) {
                  //   dataPrefs.setString(
                  //       "USER_CART", jsonEncode(userCart.toJson()));
                  // });
                  // isLoading = false;
                  // onTapAddToCart();
                  // showDialogAddToCartSuccess(context);
                } else {
                  CartAPI.addCartItem([
                    CartItem(
                      quantity: 1,
                      productId: product.productId,
                      unitPrice: product.unitPrice!,
                    ),
                  ]).then((value) {
                    CartAPI.getUserCart().then(
                      (value) {
                        isLoading = false;
                        onTapAddToCart();
                        showDialogAddToCartSuccess(context);
                      },
                    );
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xff1435c3)),
                ),
                child: const Text(
                  "Add To Cart",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1435c3),
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
