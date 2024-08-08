import 'package:get/get.dart';
import 'package:queue_project/core/class/crud.dart';
import 'package:queue_project/core/class/statusrequest.dart';
import 'package:queue_project/core/services/myservices.dart';
import 'package:queue_project/data/datasource/remote/verify_data.dart';
import 'package:queue_project/linkapi.dart';
import 'package:queue_project/routes.dart';
import 'package:http/http.dart' as http;

class VerifyController extends GetxController {
  late String email = 'kanela';
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  VerifyData verifyData = VerifyData(Get.put(Crud()));

  verify(String otp) async {
    final headers = {
      'Authorization':
          'Bearer ${myServices.sharedPreferences.getString('token')}',
    };
    var response = await http.post(
        Uri.parse(
            '${AppLink.API_URL}verify/email/otp/${myServices.sharedPreferences.getString("id")}'),
        body: {'otp': "$otp"},
        headers: headers);
    if (response.statusCode == 200) {
      statusRequest = StatusRequest.success;
      Get.offAllNamed(AppRoute.login);
      Get.snackbar('Account Verified Successfully !',
          ' You can now login to your account.');
    } else {
      return Get.snackbar('ERROR !', 'Please Try again later .');
    }
    statusRequest = StatusRequest.none;
    update();
  }

  resend() async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${myServices.sharedPreferences.getString('token')}', // Replace with your actual token
    };
    var response = await http.post(
        Uri.parse(
            '${AppLink.API_URL}send/email/otp/${myServices.sharedPreferences.getString("id")}'),
        headers: headers);

    if (response.statusCode == 200)
      Get.snackbar('Check you mailbox', 'Code has been sent !');
    else {
      Get.snackbar("Error", '${response.body}');
    }
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }
}
