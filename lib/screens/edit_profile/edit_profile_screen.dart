// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/controllers/UserAPI.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/screens/profile/components/profile_pic.dart';
import 'package:shop_app/show_dialog.dart';
import 'package:shop_app/variables.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String firstName = user.firstName ?? "";
  String lastName = user.lastName ?? "";
  String phoneNumber = user.phoneNumber ?? "";

  File? _image;

  void showOptionImage() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
              height: 120,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.camera);
                    },
                    leading: const Icon(Icons.photo_camera),
                    title: const Text("Take a picture")),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.gallery);
                    },
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Pick image from device"))
              ]));
        });
  }

  Future pickImage(ImageSource source) async {
    try {
      final pImage = await ImagePicker().pickImage(source: source);
      if (pImage == null) return;

      setState(() {
        _image = File(pImage.path);
      });
    } on PlatformException {
      throw Exception("Pick image fail!");
    }
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
              "Edit User's Profile",
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
                children: [
                  ProfilePic(
                      isUpdate: true, onTap: showOptionImage, image: _image),
                  const SizedBox(height: 40),
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
                    onChanged: (value) {
                      firstName = value;
                    },
                    initialValue: user.firstName ?? "",
                    decoration: const InputDecoration(
                      labelText: "First Name",
                      hintText: "Enter Your First Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      lastName = value;
                    },
                    initialValue: user.lastName ?? "",
                    decoration: const InputDecoration(
                      labelText: "Last Name",
                      hintText: "Enter Your Last Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    initialValue: user.phoneNumber ?? "",
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      hintText: "Enter Phone Number",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    keyboardType: TextInputType.phone,
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
              onTap: () async {
                if (firstName.isNotEmpty && lastName.isNotEmpty ||
                    phoneNumber.isNotEmpty) {
                  setState(() {
                    isLoading = true;
                  });
                  if (_image != null) {
                    await UserAPI.updateAvatar(_image);
                  }
                  await UserAPI.update(User(
                      firstName: firstName,
                      lastName: lastName,
                      phoneNumber: phoneNumber));
                  setState(() {
                    isLoading = false;
                  });
                  showDialogUpdateUserSuccess(context)
                      .then((value) => Navigator.pop(context));
                } else {
                  showDialogFillfullField(context);
                }
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
        ),
        isLoading ? const LoadingScreen() : Container(),
      ],
    );
  }
}
