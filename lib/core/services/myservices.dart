import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:queue_project/controllers/inQueuecontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyServices> init() async {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDbs6sfVgKzV6A41lTuiQmcE26Vnd1Q2-A',
            appId: '1:695001446740:android:c7c505d42d4f38ec75f0c1',
            messagingSenderId: '695001446740',
            projectId: 'queue-faecd'));

    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

fcmConfig() {
  FirebaseMessaging.onMessage.listen((message) {
    FlutterRingtonePlayer().playNotification();
    Get.snackbar(message.notification!.title!, message.notification!.body!);
    if (message.notification!.body! == "Your Queue End") {
      MyServices myServices = Get.find();
      myServices.sharedPreferences.setString('end', 'yes');
      InQueueController controller = Get.put(InQueueController());
      controller.goToHomePage();
    }
    if (message.notification!.body! != "Your Queue End") {
      InQueueController controller = Get.put(InQueueController());
      controller.getSeat();
      controller.istimer = 2;
      controller.update();
    }
  });
}

initializeServices() async {
  await fcmConfig();

  await Get.putAsync(() => MyServices().init());
}
