import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:queue_project/core/class/crud.dart';
import 'package:queue_project/core/class/statusrequest.dart';
import 'package:queue_project/core/constant/color.dart';
import 'package:queue_project/core/functions/handlingdatacontroller.dart';
import 'package:queue_project/core/services/myservices.dart';
import 'package:queue_project/data/datasource/remote/home_data.dart';
import 'package:queue_project/data/datasource/remote/queue_data.dart';
import 'package:queue_project/data/model/services.dart';
import 'package:queue_project/linkapi.dart';
import 'package:queue_project/routes.dart';
import 'package:http/http.dart' as http;
import 'package:rating_dialog/rating_dialog.dart';

class HomePageController extends GetxController {
  TextEditingController? search;
  bool isSearch = false;
  late bool isFinished;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  HomeData homeData = HomeData(Get.put(Crud()));
  List<ServicesModel> services = [];
  List<ServicesModel> searchlist = [];
  List datalist = [];
  late var queueid;
  QueueData queueData = QueueData(Get.put(Crud()));
  GetServices() async {
    try {
      statusRequest = StatusRequest.loading;

      services.clear();
      update();
      var response = await homeData.getServices();
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        // print(response);
        datalist = response;
        print(response);
        services.addAll(datalist.map((e) => ServicesModel.fromJson(e)));
        searchlist = services;

        print(services);
      }
    } catch (e) {
      statusRequest = StatusRequest.none;
      update();
      Get.defaultDialog(
          title: "Error Fetching Data",
          middleText: "Error Code ${e}",
          onConfirm: () => GetServices,
          textConfirm: "Try Again");
    }
    update();
  }

  searchData(String val) {
    searchlist = services;
    final filtered = searchlist.where((element) {
      final servicename = element.name!.toLowerCase();
      final input = val.toLowerCase();
      return servicename.contains(input);
    }).toList();
    searchlist = filtered;
    if (val.isEmpty) {
      searchlist = services;
    }
    update();
  }

  showRatingDialog(context) {
    showDialog(
        context: context,
        routeSettings: RouteSettings(),
        barrierDismissible: false,
        builder: (context) => RatingDialog(
              initialRating: 3.0,
              title: const Text(
                'Rate your last experience with us!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              message: const Text(
                'Was Everything like Expected ? Please give us your opinion.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              submitButtonText: 'Submit',
              submitButtonTextStyle: const TextStyle(
                color: AppColor.darkprimary,
                fontWeight: FontWeight.bold,
              ),
              commentHint: 'Set your custom comment hint',
              onCancelled: () {
                isFinished = false;

                update();
              },
              onSubmitted: (response) {
                print(
                    'rating: ${response.rating}, comment: ${response.comment}');
                rateService(response.rating.toInt(), response.comment);
                isFinished = false;
              },
            ));
    update();
  }

  rateService(rate, comment) async {
    print(queueid);

    print("${AppLink.API_URL}rate/${queueid}");
    String url = "${AppLink.API_URL}rate/${queueid.toString()}";
    var response = await http.post(Uri.parse(url),
        body: {'rating': rate.toString(), 'comment': comment.toString()});
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar('Success', "Rate Successfully");
    }
  }

  ChooseService(serviceid, serviceName) async {
    try {
      final headers = {
        'Authorization':
            'Bearer ${myServices.sharedPreferences.getString('token')}',
      };
      var response = await queueData.queue(
          myServices.sharedPreferences.getString('id'), serviceid, headers);
      if (response['banned'] != null) {
        Get.offAllNamed(AppRoute.register);
        return Get.snackbar("BANNED !", "YOU HAVE BEEN BANNED");
      } else if (response["user_id"] != null) {
        final utcTimestamp = response['expires_at'];
        final utcDateTime = DateTime.parse(utcTimestamp);
        final now = DateTime.now();
        final secondsSinceNow = utcDateTime.difference(now).inSeconds;
        statusRequest = handlingData(response);
        update();
        Get.offAllNamed(AppRoute.Inqueue, arguments: {
          'seconds': secondsSinceNow,
          'name': serviceName,
          'queueid': response['id']
        });
        FlutterRingtonePlayer().playNotification();

        Get.snackbar(
            'Waiting ', "You will receive a notification when it's your turn ");
      } else if (response['message'] != "") {
        update();
        Get.offAllNamed(AppRoute.Inqueue,
            arguments: {'seconds': 60, 'name': serviceName});
        FlutterRingtonePlayer().playNotification();

        Get.snackbar(
            'Alert', 'Already IN QUEUE please wait for the notification');
      }
    } catch (e) {
      Get.offAllNamed(AppRoute.login);
      Get.snackbar("ERROR", "Session Expired please Login Again");
      myServices.sharedPreferences.clear();
      Logout();
    }
  }

  Logout() async {
    final headers = {
      'Authorization':
          'Bearer ${myServices.sharedPreferences.getString('token')}',
    };
    await http.post(Uri.parse('${AppLink.API_URL}logout'), headers: headers);
    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.login);
    update();
  }

  @override
  void onInit() {
    if (myServices.sharedPreferences.getString('end') != null) {
      isFinished = true;
      myServices.sharedPreferences.setString('end', 'no');
    } else
      isFinished = false;
    search = TextEditingController();
    queueid = myServices.sharedPreferences.getInt('qid') ?? 0;
    GetServices();
    super.onInit();
  }
}
