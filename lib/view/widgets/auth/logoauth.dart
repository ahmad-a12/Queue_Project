import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_project/core/constant/imageasset.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 45),
      width: Get.width,
      height: 200,
      child: Image.asset(
        AppImageAsset.logopng,
      ),
    );
  }
}
