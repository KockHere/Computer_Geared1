import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isObscurePassword = true;
  bool isObscureNewPassword = true;
  bool isObscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Đổi mật khẩu",
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
                obscureText: isObscurePassword,
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: "Mật khẩu hiện tại",
                  hintText: "Nhập mật khẩu hiện tại",
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      isObscurePassword = !isObscurePassword;
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 14),
                      child: Icon(isObscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: isObscureNewPassword,
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: "Mật khẩu mới",
                  hintText: "Nhập mật khẩu mới",
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      isObscureNewPassword = !isObscureNewPassword;
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 14),
                      child: Icon(isObscureNewPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: isObscureConfirmPassword,
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: "Xác nhận mật khẩu mới",
                  hintText: "Nhập lại mật khẩu mới",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      isObscureConfirmPassword = !isObscureConfirmPassword;
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 14),
                      child: Icon(isObscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                    ),
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
              "Đổi mật khẩu",
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
