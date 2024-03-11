// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shop_app/controllers/UserAPI.dart';
import 'package:shop_app/helper/keyboard.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/show_dialog.dart';
import 'package:shop_app/variables.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';

// ignore: must_be_immutable
class CompleteProfileForm extends StatefulWidget {
  CompleteProfileForm({
    Key? key,
    required this.email,
    required this.password,
    required this.onSetState,
  }) : super(key: key);

  String email;
  String password;
  Function() onSetState;

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: firstNameController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kNamelNullError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kNamelNullError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Họ",
              hintText: "Nhập họ của bạn",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: lastNameController,
            decoration: const InputDecoration(
              labelText: "Tên",
              hintText: "Nhập tên của bạn",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: phoneNumberController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPhoneNumberNullError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPhoneNumberNullError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Số điện thoại",
              hintText: "Nhập số điện thoại",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
            ),
          ),
          FormError(errors: errors),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                KeyboardUtil.hideKeyboard(context);
                User user = User(
                  email: widget.email,
                  password: widget.password,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  phoneNumber: phoneNumberController.text,
                );
                isLoading = true;
                widget.onSetState();
                if (await UserAPI.register(user)) {
                  removeError(error: "Email đã tồn tại");
                  isLoading = true;
                  widget.onSetState();
                  showDialogRegisterSuccess(context);
                } else {
                  addError(error: "Email đã tồn tại");
                }
              }
            },
            child: const Text("Đăng ký"),
          ),
        ],
      ),
    );
  }
}
