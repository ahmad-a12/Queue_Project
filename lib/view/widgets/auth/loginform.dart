import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_project/controllers/auth/logincontroller.dart';
import 'package:queue_project/core/functions/validinput.dart';
import 'package:queue_project/view/widgets/auth/customtextfieldauth.dart';

class LoginForm extends GetView<LoginController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 35),
          child: CustomTextFormAuth(
              hinttext: 'Enter Your Email',
              labeltext: "Email",
              iconData: Icons.email_outlined,
              mycontroller: controller.email,
              valid: (String? val) {
                return validInput(val!, 8, 30, 'email');
              },
              isNumber: false),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 35),
          child: CustomTextFormAuth(
            obscureText: controller.isshowpass,
            onTapIcon: () {
              controller.changePassIcon();
              controller.showPassword();
            },
            isNumber: false,
            hinttext: 'Enter Your Password',
            iconData: controller.Iconpass,
            labeltext: "Password",
            mycontroller: controller.password,
            valid: (String? val) {
              return validInput(val!, 8, 20, 'password');
            },
          ),
        ),
      ],
    );
  }
}
