import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/ShippingAddress.dart';

// ignore: must_be_immutable
class EditShippingAddressScreen extends StatelessWidget {
  EditShippingAddressScreen({
    Key? key,
    required this.shippingAddress,
  }) : super(key: key);

  ShippingAddress shippingAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Chỉnh sửa địa chỉ",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(vertical: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onChanged: (value) {},
                initialValue: shippingAddress.recipientName ?? "",
                decoration: const InputDecoration(
                  labelText: "Tên người nhận",
                  hintText: "Nhập tên người nhận",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                initialValue: shippingAddress.phone ?? "",
                decoration: const InputDecoration(
                  labelText: "Số điện thoại",
                  hintText: "Nhập số điện thoại người nhận",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                initialValue: shippingAddress.city ?? "",
                decoration: const InputDecoration(
                  labelText: "Tỉnh/Thành phố",
                  hintText: "Nhập tỉnh/thành phố",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                initialValue: shippingAddress.district ?? "",
                decoration: const InputDecoration(
                  labelText: "Quận/Huyện",
                  hintText: "Nhập quận/huyện",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                initialValue: shippingAddress.ward ?? "",
                decoration: const InputDecoration(
                  labelText: "Phường/Xã",
                  hintText: "Nhập phường/xã",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                initialValue: shippingAddress.streetAddress ?? "",
                decoration: const InputDecoration(
                  labelText: "Địa chỉ",
                  hintText: "Nhập địa chỉ",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
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
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 8, 16, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: kPrimaryColor,
            ),
            child: const Text(
              "Cập nhật",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
