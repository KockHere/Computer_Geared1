import 'package:flutter/material.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/variables.dart';

import '../../components/no_account_text.dart';
import 'components/sign_form.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Sign In"),
          ),
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 21),
                      const Text(
                        "Computer Geared",
                        style: TextStyle(
                          color: Color.fromARGB(255, 92, 26, 235),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SignForm(
                        isObscure: isObscure,
                        onTapIcon: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        onSetState: () {
                          if (mounted) {
                            setState(() {});
                          }
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
                      const SizedBox(height: 20),
                      const NoAccountText(),
                    ],
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
