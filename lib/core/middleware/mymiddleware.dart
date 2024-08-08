import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_project/core/services/myservices.dart';
import 'package:queue_project/routes.dart';

class MyMiddleWare extends GetMiddleware {
  MyServices myServices = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString('token') != null) {
      return RouteSettings(name: AppRoute.homePage);
    }
    if (myServices.sharedPreferences.getString('step') == '1') {
      return RouteSettings(name: AppRoute.login);
    } else {
      return null;
    }
  }
}
