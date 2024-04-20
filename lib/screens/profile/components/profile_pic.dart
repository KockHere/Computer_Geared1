// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/variables.dart';

class ProfilePic extends StatelessWidget {
  ProfilePic({
    super.key,
    this.isUpdate,
    this.onTap,
    this.image,
  });

  bool? isUpdate = false;
  Function()? onTap;
  File? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            if (image != null) ...[
              CircleAvatar(
                backgroundImage: FileImage(image!),
              ),
            ] else if (user.avatar != "" && user.avatar != null) ...[
              CircleAvatar(
                backgroundImage: NetworkImage(user.avatar!),
              ),
            ] else ...[
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/Profile Image.png"),
              ),
            ],
            isUpdate == true
                ? Positioned(
                    right: -16,
                    bottom: 0,
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(color: Colors.white),
                          ),
                          backgroundColor: const Color(0xFFF5F6F9),
                        ),
                        onPressed: () {},
                        child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
