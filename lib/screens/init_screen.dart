import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/category/category_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/list_build_pc/list_build_pc_screen.dart';
import 'package:shop_app/screens/my_order/my_order_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/variables.dart';
import 'package:url_launcher/url_launcher.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key, this.initIndex});
  final int? initIndex;

  static String routeName = "/init";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;
  void updateCurrentIndex(int index) async {
    currentSelectedIndex = index;
    if (currentSelectedIndex == 3) {
      String facebookIdHere = "230886160111786";
      String uri = "";
      if (Platform.isAndroid) {
        uri = 'fb-messenger://user/$facebookIdHere';
      } else if (Platform.isIOS) {
        uri = 'https://m.me/$facebookIdHere';
      }
      await launchUrl(Uri.parse(uri));
    } else {
      setState(() {});
    }
  }

  final pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const ListBuildPcScreen(),
    // const BuildPCScreen(),
    const Center(
      child: Text("Chat"),
    ),
    const ProfileScreen()
  ];

  @override
  void initState() {
    prefs.then((dataPrefs) {
      String userPrefs = dataPrefs.getString("USER") ?? "";
      if (userPrefs.isNotEmpty) {
        user = User.fromJson(jsonDecode(userPrefs) as Map<String, dynamic>);
      }
      // String userCartPrefs = dataPrefs.getString("USER_CART") ?? "";
      // if (userCartPrefs.isNotEmpty) {
      //   userCart =
      //       Cart.fromJson(jsonDecode(userCartPrefs) as Map<String, dynamic>);
      // }
      if (widget.initIndex == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyOrderScreen()),
        );
      }
    });
    if (widget.initIndex != null) {
      currentSelectedIndex = widget.initIndex!;
      if (mounted) {
        setState(() {});
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentIndex,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Menu Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Menu Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Fav",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/BuildPC.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/BuildPC.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Fav",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Chat bubble Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Chat bubble Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Fav",
          ),
        ],
      ),
    );
  }
}
