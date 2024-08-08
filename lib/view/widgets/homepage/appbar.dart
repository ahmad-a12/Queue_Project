import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_project/core/constant/color.dart';
import 'package:queue_project/core/constant/imageasset.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  get homePageController => null;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: AppColor.black,
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      backgroundColor: AppColor.appbar,
      centerTitle: true,
      title: Text(
        'Welcome to Queue App',
        style: TextStyle(fontSize: 24),
      ),
      leading: Container(
          padding: EdgeInsets.all(10),
          child: Image.asset(
            '${AppImageAsset.logopng}',
            width: Get.width / 20,
          )),
      actions: [
        IconButton(
            onPressed: () {
              homePageController.Logout();
            },
            icon: Icon(
              Icons.logout_outlined,
              size: Get.width / 18,
              color: AppColor.white,
            ))
      ],
    );
  }
}
