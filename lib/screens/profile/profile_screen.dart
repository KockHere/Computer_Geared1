import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/change_password/change_password_screen.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/my_account/my_account_screen.dart';
import 'package:shop_app/screens/my_order/my_order_screen.dart';
import 'package:shop_app/screens/notification/notification_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/variables.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _showDialogLogout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Đăng xuất?'),
          content: const Text('Bạn chắc chắn muốn đăng xuất?'),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Không'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                user = User(userId: "");
                userCart = Cart(cartId: "");
                Navigator.pushNamed(context, InitScreen.routeName);
              },
              child: const Text('Có'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Container(),
        title: Text(
          "Cá nhân",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "Tài khoản",
              icon: "assets/icons/User Icon.svg",
              press: () {
                if (user.userId == "") {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyAccountScreen()),
                  );
                }
              },
            ),
            ProfileMenu(
              text: "Thông báo",
              icon: "assets/icons/Bell.svg",
              press: () {
                if (user.userId == "") {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()),
                  );
                }
              },
            ),
            ProfileMenu(
              text: "Đơn hàng",
              icon: "assets/icons/Cart Icon.svg",
              press: () {
                if (user.userId == "") {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyOrderScreen()),
                  );
                }
              },
            ),
            ProfileMenu(
              text: "Đổi mật khẩu",
              icon: "assets/icons/Lock.svg",
              press: () {
                if (user.userId == "") {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen()),
                  );
                }
              },
            ),
            ProfileMenu(
              text: user.userId == "" ? "Đăng nhập" : "Đăng xuất",
              icon: "assets/icons/Log out.svg",
              press: () {
                if (user.userId != "") {
                  _showDialogLogout();
                } else {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
