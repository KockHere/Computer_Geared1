import 'package:flutter/material.dart';
import 'package:shop_app/screens/loading/loading_screen.dart';
import 'package:shop_app/variables.dart';

import '../../constants.dart';
import 'components/complete_profile_form.dart';

class CompleteProfileScreen extends StatefulWidget {
  static String routeName = "/complete_profile";

  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    email = data["email"];
    password = data["password"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      const Text("Complete Profile", style: headingStyle),
                      const Text(
                        "Complete Your Profile",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      CompleteProfileForm(
                        email: email,
                        password: password,
                        onSetState: () {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 30),
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
          isLoading ? const LoadingScreen() : Container(),
        ],
      ),
    );
  }
}
