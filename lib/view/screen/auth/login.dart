import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_project/controllers/auth/logincontroller.dart';
import 'package:queue_project/core/class/handlingdataview.dart';
import 'package:queue_project/core/constant/color.dart';
import 'package:queue_project/view/widgets/auth/custombuttonauth.dart';
import 'package:queue_project/view/widgets/auth/loginform.dart';
import 'package:queue_project/view/widgets/auth/logoauth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: GetBuilder<LoginController>(
          builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Container(
                  child: Container(
                    margin: EdgeInsets.only(top: 35),
                    child: Form(
                      key: controller.formstate,
                      child: ListView(
                        children: [
                          SizedBox(height: 20),
                          LogoAuth(),
                          Center(
                              child: Text(
                            'Welcome back !',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColor.darkprimary,
                                fontWeight: FontWeight.bold),
                          )),
                          Center(
                              child: Text(
                            'Enter Your Credintials to Login',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColor.darkprimary,
                                fontWeight: FontWeight.bold),
                          )),
                          SizedBox(height: 30),
                          LoginForm(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 35),
                            child: CustomButtonAuth(
                              text: 'Login',
                              onpressed: () {
                                controller.loginEmail();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't Have an Account ? ",
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 152, 218, 1)),
                              ),
                              TextButton(
                                  onPressed: () {
                                    controller.goToRegister();
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'Register',
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
