import 'package:get/get.dart';
import 'package:queue_project/core/services/myservices.dart';
import 'package:queue_project/routes.dart';

class OnBoardingController extends GetxController {
  MyServices myServices = Get.find();
  goToLogin() {
    myServices.sharedPreferences.setString('step', '1');

    Get.offAllNamed(AppRoute.login);
  }

  goToRegister() {
    myServices.sharedPreferences.setString('step', '1');

    Get.offAllNamed(AppRoute.register);
  }
}
