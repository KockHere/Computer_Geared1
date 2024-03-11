import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      ),
    );
  }
}