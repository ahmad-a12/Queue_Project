import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:queue_project/controllers/auth/verifycontroller.dart';
import 'package:queue_project/core/class/handlingdataview.dart';
import 'package:queue_project/core/constant/color.dart';
import 'package:queue_project/core/constant/imageasset.dart';

class VerifySignup extends StatelessWidget {
  const VerifySignup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyController());

    return Scaffold(
        appBar: AppBar(),
        body: GetBuilder<VerifyController>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: ListView(
                        children: [
                          Image.asset(
                            AppImageAsset.verifyemail,
                            width: 5,
                          ),
                          Center(
                            child: Text(
                              'Enter Code',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              "Please Check Inbox For The email : ${controller.email}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w200),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          OtpTextField(
                            numberOfFields: 5,
                            fieldWidth: 60,
                            textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: "Cairo"),
                            borderRadius: BorderRadius.circular(20),
                            borderColor: AppColor.primaryColor,
                            //set to true to show as box or false to show as dash
                            showFieldAsBox: true,

                            //runs when a code is typed in
                            onCodeChanged: (String code) {
                              //handle validation or checks here
                            },
                            //runs when every textfield is filled
                            onSubmit: (String verificationCode) {
                              controller.verify(verificationCode);
                              // controller.goToSuccessSignup(verificationCode);
                            }, // end onSubmit
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                              child: OtpTimerButton(
                                  text: const Text('Resend'),
                                  onPressed: () {
                                    controller.resend();
                                  },
                                  duration: 30,
                                  textColor: AppColor.white,
                                  backgroundColor: AppColor.primaryColor))
                        ],
                      )),
                )));
  }
}
