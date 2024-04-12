import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/ShippingAddressAPI.dart';
import 'package:shop_app/models/ShippingAddress.dart';
import 'package:shop_app/screens/add_shipping_address/add_shipping_address_screen.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/screens/shipping_address/components/shipping_address_card.dart';
import 'package:shop_app/variables.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  List<ShippingAddress> listShippingAddress = [];

  @override
  void initState() {
    super.initState();
    initScreen();
  }

  void initScreen() {
    setState(() {
      isLoading = true;
    });
    ShippingAddressAPI.getListShippingAddress().then((shippingAddresses) {
      listShippingAddress = shippingAddresses;
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Future<bool> confirmDismiss(String shippingAddressId) async {
    setState(() {
      isLoading = true;
    });
    ShippingAddressAPI.deleteShippingAddress(shippingAddressId).then((result) {
      if (result) {
        initScreen();
        return true;
      }
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xfff6f6f6),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "Address List",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    listShippingAddress.length,
                    (index) => Dismissible(
                      key: Key(listShippingAddress[index].addressId.toString()),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) => confirmDismiss(
                          listShippingAddress[index].addressId ?? ""),
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            SvgPicture.asset("assets/icons/Trash.svg"),
                          ],
                        ),
                      ),
                      child: ShippingAddressCard(
                        shippingAddress: listShippingAddress[index],
                        isDefault: index == 0,
                        onTap: () {
                          Navigator.pop(context, listShippingAddress[index]);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => EditShippingAddressScreen(
                          //             shippingAddress: listShippingAddress[index],
                          //           )),
                          // );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 90,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xfff6f6f6)),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddShippingAddressScreen()),
                ).then((value) {
                  initScreen();
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(10, 8, 16, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: kPrimaryColor,
                ),
                child: const Text(
                  "Add Shipping Address",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
        isLoading ? const LoadingScreen() : Container(),
      ],
    );
  }
}
