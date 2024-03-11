import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/variables.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Sửa thông tin cá nhân",
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
                initialValue: user.email ?? "",
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                initialValue: user.firstName ?? "",
                decoration: const InputDecoration(
                  labelText: "Họ",
                  hintText: "Nhập họ của bạn",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                initialValue: user.lastName ?? "",
                decoration: const InputDecoration(
                  labelText: "Tên",
                  hintText: "Nhập tên của bạn",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {},
                initialValue: user.phoneNumber ?? "",
                decoration: const InputDecoration(
                  labelText: "Số điện thoại",
                  hintText: "Nhập số điện thoại",
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
