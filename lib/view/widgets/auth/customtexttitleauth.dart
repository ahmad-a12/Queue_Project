import 'package:flutter/material.dart';
import 'package:queue_project/core/constant/color.dart';

class CustomTextTitleAuth extends StatelessWidget {
  final String text;
  const CustomTextTitleAuth({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 45, color: AppColor.darkprimary),
    );
  }
}
