import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_project/controllers/auth/registercontroller.dart';
import 'package:queue_project/core/functions/validinput.dart';
import 'package:queue_project/view/widgets/auth/customtextfieldauth.dart';

class RegForm extends GetView<RegisterController> {
  const RegForm({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController());
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 35),
          child: CustomTextFormAuth(
              hinttext: 'Enter Your Name',
              labeltext: "Name",
              iconData: Icons.person_2_outlined,
              mycontroller: controller.name,
              valid: (String? val) {
                return validInput(val!, 4, 15, 'username');
              },
              isNumber: false),
        ),
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
              hinttext: 'Enter Phone Number',
              labeltext: "Phone Number",
              iconData: Icons.phone_android_outlined,
              mycontroller: controller.phone,
              valid: (String? val) {
                return validInput(val!, 10, 10, 'phone');
              },
              isNumber: true),
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
    // : ListView(
    //     shrinkWrap: true,
    //     physics: NeverScrollableScrollPhysics(),
    //     children: [
    //       Container(
    //         margin: EdgeInsets.symmetric(horizontal: 35),
    //         child: CustomTextFormAuth(
    //             hinttext: 'Enter Your Name',
    //             labeltext: "Name",
    //             iconData: Icons.person_2_outlined,
    //             mycontroller: controller.name,
    //             valid: (String? val) {
    //               return validInput(val!, 4, 15, 'username');
    //             },
    //             isNumber: false),
    //       ),
    //       Container(
    //         margin: EdgeInsets.symmetric(horizontal: 35),
    //         child: CustomTextFormAuth(
    //             hinttext: 'Enter Phone Number',
    //             labeltext: "Phone Number",
    //             iconData: Icons.phone_android_outlined,
    //             mycontroller: controller.phone,
    //             valid: (String? val) {
    //               return validInput(val!, 10, 10, 'phone');
    //             },
    //             isNumber: true),
    //       ),
    //       Container(
    //         margin: EdgeInsets.symmetric(horizontal: 35),
    //         child: CustomTextFormAuth(
    //           obscureText: controller.isshowpass,
    //           onTapIcon: () {
    //             controller.changePassIcon();
    //             controller.showPassword();
    //           },
    //           isNumber: false,
    //           hinttext: 'Enter A Password',
    //           iconData: controller.Iconpass,
    //           labeltext: "Password",
    //           mycontroller: controller.password,
    //           valid: (String? val) {
    //             return validInput(val!, 8, 20, 'password');
    //           },
    //         ),
    //       ),
    //     ],
    //   );
  }
}
