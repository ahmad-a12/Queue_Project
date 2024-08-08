import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_project/core/services/myservices.dart';
import 'package:queue_project/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServices();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  MyServices myServices = Get.find();
  myServices.sharedPreferences.setString('fcm', "$fcmToken");
  print('+++++++++++++$fcmToken');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Queue App',
      debugShowCheckedModeBanner: false,
      getPages: routes,
    );
  }
}
