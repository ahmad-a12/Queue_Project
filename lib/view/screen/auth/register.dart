import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_project/controllers/auth/registercontroller.dart';
import 'package:queue_project/core/class/handlingdataview.dart';
import 'package:queue_project/core/constant/color.dart';
import 'package:queue_project/view/widgets/auth/custombuttonauth.dart';
import 'package:queue_project/view/widgets/auth/logoauth.dart';
import 'package:queue_project/view/widgets/auth/regform.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController());
    return Scaffold(
      body: GetBuilder<RegisterController>(
          builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Container(
                  child: Container(
                    margin: EdgeInsets.only(top: 35),
                    child: Form(
                      key: controller.formstate,
                      child: ListView(
                        children: [
                          SizedBox(height: 10),
                          LogoAuth(),
                          Center(
                              child: Text(
                            'Welcome to Our App !',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColor.darkprimary,
                                fontWeight: FontWeight.bold),
                          )),
                          Center(
                              child: Text(
                            'Enter Your Credintials to Register',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColor.darkprimary,
                                fontWeight: FontWeight.bold),
                          )),
                          SizedBox(height: 30),
                          RegForm(),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 35),
                            child: CustomButtonAuth(
                              text: 'Register',
                              onpressed: () {
                                controller.RegisterEmail();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already Have an Account ? ",
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 152, 218, 1)),
                              ),
                              TextButton(
                                  onPressed: () {
                                    controller.goToLogin();
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(color: AppColor.white),
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
    );
  }
}
