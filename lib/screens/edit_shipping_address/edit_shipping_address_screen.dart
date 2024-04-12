import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/ShippingAddress.dart';

// ignore: must_be_immutable
class EditShippingAddressScreen extends StatelessWidget {
  EditShippingAddressScreen({
    super.key,
    required this.shippingAddress,
  });

  ShippingAddress shippingAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Edit Shipping Address",
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
                  labelText: "Recipient's Name",
                  hintText: "Enter Recipient's Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                initialValue: shippingAddress.recipientPhone ?? "",
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Enter Recipient's Phone Number",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                initialValue: shippingAddress.city ?? "",
                decoration: const InputDecoration(
                  labelText: "Province/City",
                  hintText: "Select Province/City",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                initialValue: shippingAddress.district ?? "",
                decoration: const InputDecoration(
                  labelText: "District",
                  hintText: "Select District",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                initialValue: shippingAddress.ward ?? "",
                decoration: const InputDecoration(
                  labelText: "Ward",
                  hintText: "Select Ward",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                initialValue: shippingAddress.streetAddress ?? "",
                decoration: const InputDecoration(
                  labelText: "Street Address",
                  hintText: "Enter Street Address",
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
              "Update",
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
