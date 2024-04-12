import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/edit_profile/edit_profile_screen.dart';
import 'package:shop_app/screens/profile/components/profile_pic.dart';
import 'package:shop_app/variables.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Tài khoản",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "${user.firstName} ${user.lastName}",
                style: const TextStyle(
                  color: inActiveIconColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "User's Profile",
                    style: TextStyle(
                      color: inActiveIconColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfileScreen()),
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      color: inActiveIconColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              color: Colors.white,
              child: Column(
                children: [
                  RawInfor(title: "First Name:", data: user.firstName ?? ""),
                  RawInfor(title: "Last Name:", data: user.lastName ?? ""),
                  RawInfor(title: "Email:", data: user.email ?? ""),
                  RawInfor(
                      title: "Phone Number:", data: user.phoneNumber ?? ""),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RawInfor extends StatelessWidget {
  const RawInfor({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          data,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
