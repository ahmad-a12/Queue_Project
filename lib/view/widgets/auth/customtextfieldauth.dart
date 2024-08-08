import 'package:flutter/material.dart';
import 'package:queue_project/core/constant/color.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hinttext;

  final String labeltext;
  final IconData iconData;
  final TextEditingController mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  const CustomTextFormAuth({
    super.key,
    this.onTapIcon,
    this.obscureText,
    required this.hinttext,
    required this.labeltext,
    required this.iconData,
    required this.mycontroller,
    required this.valid,
    required this.isNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: TextFormField(
        obscureText: obscureText == null || obscureText == false ? false : true,
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        controller: mycontroller,
        validator: valid,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: AppColor.primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: AppColor.primaryColor),
            ),
            hintStyle: TextStyle(fontSize: 14, color: AppColor.primaryColor),
            hintText: hinttext,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Container(
              margin: const EdgeInsets.symmetric(horizontal: 9),
              child: Text(
                labeltext,
                style: TextStyle(color: AppColor.text),
              ),
            ),
            suffixIcon: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onTapIcon,
                child: Icon(
                  iconData,
                  color: AppColor.primaryColor,
                )),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            )),
      ),
    );
  }
}
