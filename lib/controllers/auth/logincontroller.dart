import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_project/core/class/crud.dart';
import 'package:queue_project/core/class/statusrequest.dart';
import 'package:queue_project/core/functions/handlingdatacontroller.dart';
import 'package:queue_project/core/services/myservices.dart';
import 'package:queue_project/data/datasource/remote/login_data.dart';
import 'package:queue_project/data/model/login.dart';
import 'package:queue_project/routes.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  bool isemail = false;
  late String fcm;
  List<loginModel> logmodel = [];

  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  LoginData loginData = LoginData(Get.put(Crud()));
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  IconData Iconpass = Icons.remove_red_eye_outlined;

  loginEmail() async {
    logmodel = [];
    var formdata = formstate.currentState;
    final fcmToken = await FirebaseMessaging.instance.getToken();
    MyServices myServices = Get.find();
    myServices.sharedPreferences.setString('fcm', "$fcmToken");
    fcm = myServices.sharedPreferences.getString('fcm')!;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        var response = await loginData.logEmail(email.text,
            myServices.sharedPreferences.getString('fcm'), password.text);
        statusRequest = handlingData(response);
        if (response['banned'] != null) {
          statusRequest = StatusRequest.none;
          update();
          Get.offAllNamed(AppRoute.register);
          Get.snackbar("BANNED !", "YOU HAVE BEEN BANNED");
        } else if (response['email'] != null) {
          Get.snackbar('Error', 'Email Not Exist');
        } else if (response['password'] != null) {
          Get.snackbar('Error', 'Password Not Correct');
        } else if (response['verified'] != null) {
          Get.toNamed(AppRoute.verifysignup, arguments: {
            "email": email.text,
          });
        } else if (response['user'] != null) {
          List datalist = response['user'];
          logmodel.addAll(datalist.map((e) => loginModel.fromJson(e)));
          myServices.sharedPreferences.setString('token', response['token']);
          myServices.sharedPreferences.setString('id', "${logmodel[0].id}");
          Get.offAllNamed(AppRoute.homePage);
        } else {
          statusRequest = StatusRequest.none;
          update();
          Get.snackbar(
            'Error',
            '${response}',
          );
        }
        update();
      } catch (e) {
        statusRequest = StatusRequest.none;
        update();
        Get.snackbar('error', "Email or Password Not Correct");
      }
    } else
      print('notValid');
  }

  bool isshowpass = true;

  changePassIcon() {
    Iconpass = isshowpass ? Icons.lock_outline : Icons.remove_red_eye_outlined;
    update();
  }

  changereg() {
    email.clear();
    phone.clear();
    password.clear();
    formstate.currentState!.reset();
    isemail = !isemail;
    update();
  }

  showPassword() {
    isshowpass = isshowpass == true ? false : true;
    update();
  }

  goToRegister() {
    Get.offAllNamed(AppRoute.register);
  }

  @override
  void onInit() {
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }
}
