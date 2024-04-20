import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/sign_up";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text("Sign Up", style: headingStyle),
                  // const Text(
                  //   "Sign Up by Email and Password",
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(height: 20),
                  SignUpForm(
                    isObscurePassword: isObscurePassword,
                    onTapIconPassword: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    },
                    isObscureConfirmPassword: isObscureConfirmPassword,
                    onTapIconConfirmPassword: () {
                      setState(() {
                        isObscureConfirmPassword = !isObscureConfirmPassword;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  // const Text(
                  //   "Or",
                  //   textAlign: TextAlign.center,
                  // ),
                  // const SizedBox(height: 16),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 14, horizontal: 20),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.8),
                  //         spreadRadius: 5,
                  //         blurRadius: 5,
                  //         offset: const Offset(0, 3),
                  //       ),
                  //     ],
                  //     borderRadius: BorderRadius.circular(14),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       SvgPicture.asset("assets/icons/google-icon.svg"),
                  //       const SizedBox(width: 8),
                  //       const Text("Sign In With Google"),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                  // Text(
                  //   'Continue by agreeing \nwith our Term',
                  //   textAlign: TextAlign.center,
                  //   style: Theme.of(context).textTheme.bodySmall,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
