// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PCBuildImage extends StatelessWidget {
  PCBuildImage({super.key, required this.image});

  List<String>? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(right: 5),
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: CircleAvatar(
        backgroundImage: NetworkImage(
            image != null && image!.isNotEmpty ? image![0] : "https://lh3.googleusercontent.com/icxPo1Rqyjc1XkfEpTq6NJx3p1mFclraPE3mp3uxCUDBoHXuhbq8WMGMiwE3L4czehocmdRCuSyBF9QOU4DQhz30eIjekvNm=rw"),
      ),
    );
  }
}
