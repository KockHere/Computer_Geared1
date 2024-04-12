import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/change_password/change_password_screen.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/my_account/my_account_screen.dart';
import 'package:shop_app/screens/my_order/my_order_screen.dart';
import 'package:shop_app/screens/notification/notification_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/vnpay/vnpay_screen.dart';
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
  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _showDialogLogout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Signing Out'),
          content: const Text('Are you really want to Sign Out ?'),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Text('No',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                user = User(userId: "");
                listUserCart = [];
                prefs.then((dataPrefs) {
                  dataPrefs.remove("USER");
                  dataPrefs.remove("USER_CART");
                });
                Navigator.pushNamed(context, InitScreen.routeName);
              },
              child: const Text('Yes',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.w600)),
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
          "Personal",
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
              text: "Profile",
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
              text: "Notification",
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
              text: "My Order",
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
              text: "Change Password",
              icon: "assets/icons/Lock.svg",
              press: () {
                if (user.userId == "") {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                } else {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const ChangePasswordScreen()),
                  // );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VnPayScreen(url: "")),
                  );
                }
              },
            ),
            ProfileMenu(
              text: user.userId == "" ? "Sign In" : "Sign Out",
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
