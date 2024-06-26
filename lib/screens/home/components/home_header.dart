// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/variables.dart';

import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({
    super.key,
    required this.numberOfProduct,
    required this.onSetState,
    required this.onChange,
  });

  int numberOfProduct;
  Function() onSetState;
  Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: SearchField(onChange: onChange)),
          const SizedBox(width: 16),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            numOfitem: numberOfProduct,
            press: () {
              if (user.userId == "") {
                Navigator.pushNamed(context, SignInScreen.routeName);
              } else {
                Navigator.pushNamed(context, CartScreen.routeName)
                    .then((value) {
                  onSetState();
                });
              }
            },
          ),
          // const SizedBox(width: 8),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Bell.svg",
          //   numOfitem: user.userId == "" ? 0 : 9,
          //   press: () {
          //     if (user.userId == "") {
          //       Navigator.pushNamed(context, SignInScreen.routeName);
          //     } else {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => const NotificationScreen()),
          //       );
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
