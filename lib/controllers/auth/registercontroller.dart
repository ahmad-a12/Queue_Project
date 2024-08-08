import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_project/core/class/crud.dart';
import 'package:queue_project/core/class/statusrequest.dart';
import 'package:queue_project/core/functions/handlingdatacontroller.dart';
import 'package:queue_project/core/services/myservices.dart';
import 'package:queue_project/data/datasource/remote/reg_data.dart';
import 'package:queue_project/data/datasource/remote/verify_data.dart';
import 'package:queue_project/data/model/register.dart';
import 'package:queue_project/linkapi.dart';
import 'package:queue_project/routes.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController name;
  late TextEditingController password;
  late String token;
  List<regModel> regmodel = [];
  VerifyData verifyData = VerifyData(Get.put(Crud()));
  RegisterData registerData = RegisterData(Get.put(Crud()));
  MyServices myServices = Get.find();
  bool isemail = false;

  StatusRequest statusRequest = StatusRequest.none;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isshowpass = true;
  IconData Iconpass = Icons.remove_red_eye_outlined;
  showPassword() {
    isshowpass = isshowpass == true ? false : true;
    update();
  }

  changePassIcon() {
    Iconpass = isshowpass ? Icons.lock_outline : Icons.remove_red_eye_outlined;
    update();
  }

  changereg() {
    formstate.currentState!.reset();
    password.clear();
    isemail = !isemail;
    update();
  }

  RegisterEmail() async {
    myServices.sharedPreferences.clear();
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        var response = await registerData.regEmail(
            name.text, email.text, phone.text, password.text);

        statusRequest = handlingData(response);
        if (response['email'] != null) {
          Get.snackbar('Error', 'Email is Exist');
        } else if (response['verified'] != null) {
          sentotp();
          Get.toNamed(AppRoute.verifysignup, arguments: {
            "email": email.text,
          });
        } else if (response['user'] != null) {
          List datalist = response["user"];
          regmodel = [];
          regmodel.addAll(datalist.map((e) => regModel.fromJson(e)));
          token = response['token'];
          myServices.sharedPreferences.setString('otp', response['token']);
          myServices.sharedPreferences.setString('id', "${regmodel[0].id}");
          // print(myServices.sharedPreferences.getString('token'));
          goToVerify();
        } else {
          return Get.snackbar('Error', '${response}');
        }
      } catch (e) {
        Get.snackbar('Error', "Something Went wrong , try again later ");
      }
      update();
    } else
      print('notValid');
  }

  sentotp() async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${myServices.sharedPreferences.getString('otp')}',
    };
    var response = await http.post(
        Uri.parse(
            '${AppLink.API_URL}send/email/otp/${myServices.sharedPreferences.getString("id")}'),
        headers: headers);
    if (response.statusCode == 200)
      Get.snackbar('Check you mailbox', 'Code has been sent !');
  }

  goToVerify() {
    sentotp();
    Get.toNamed(AppRoute.verifysignup, arguments: {
      "email": email.text,
    });
  }

  goToLogin() {
    Get.offAllNamed(AppRoute.login);
  }

  @override
  void onInit() {
    name = TextEditingController();
    password = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    super.onInit();
  }
}
