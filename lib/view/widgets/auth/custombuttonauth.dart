import 'package:flutter/material.dart';
import 'package:queue_project/core/constant/color.dart';

class CustomButtonAuth extends StatelessWidget {
  final void Function()? onpressed;
  final String text;
  const CustomButtonAuth({super.key, required this.text, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: onpressed,
        color: AppColor.darkprimary,
        textColor: AppColor.white,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Text(text),
      ),
    );
  }
}
