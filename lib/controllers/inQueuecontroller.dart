import 'dart:convert';

import 'package:get/get.dart';
import 'package:queue_project/core/class/crud.dart';
import 'package:queue_project/core/class/statusrequest.dart';
import 'package:queue_project/core/services/myservices.dart';
import 'package:queue_project/data/datasource/remote/queue_data.dart';

import 'package:http/http.dart' as http;
import 'package:queue_project/linkapi.dart';
import 'package:queue_project/routes.dart';

class InQueueController extends GetxController {
  QueueData queueData = QueueData(Get.put(Crud()));
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  late int seconds;
  late String name;
  late int queueid;
  int istimer = 0;
  String seatNumber = "";
  getSeat() async {
    var response =
        await http.get(Uri.parse("${AppLink.API_URL}number/$queueid.t"));
    Map responsebody = jsonDecode(response.body);
    print(responsebody['seat_number']);
    seatNumber = responsebody['seat_number'];
    update();
  }

  goToHomePage() {
    myServices.sharedPreferences.setInt("qid", queueid);
    Get.offAllNamed(AppRoute.homePage);
  }

  @override
  void onInit() {
    seconds = Get.arguments['seconds'];
    name = Get.arguments['name'];
    queueid = Get.arguments['queueid'];
    print(Get.currentRoute);
    super.onInit();
  }
}
