import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_project/controllers/homepagecontroller.dart';
import 'package:queue_project/core/class/handlingdataview.dart';
import 'package:queue_project/core/constant/color.dart';
import 'package:queue_project/core/functions/exitalert.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.put(HomePageController());
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColor.black,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        backgroundColor: AppColor.appbar,
        centerTitle: true,
        title: Text(
          'Welcome to Queue App',
          style: TextStyle(fontSize: 20),
        ),
        leading: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.home,
              size: 30,
            )),
        actions: [
          IconButton(
              onPressed: () {
                homePageController.GetServices();
              },
              icon: Icon(
                Icons.refresh_outlined,
                size: Get.width / 18,
                color: AppColor.white,
              )),
          IconButton(
              onPressed: () {
                homePageController.Logout();
              },
              icon: Icon(
                Icons.logout_outlined,
                size: Get.width / 18,
                color: AppColor.white,
              )),
        ],
      ),
      bottomNavigationBar: GetBuilder<HomePageController>(
          builder: (controller) => homePageController.isFinished
              ? Container(
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: AppColor.appbar,
                      borderRadius: BorderRadius.circular(20)),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Rate Your Last experience with us !"),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        color: Colors.red,
                        height: 20,
                        onPressed: () {
                          controller.showRatingDialog(context);
                          controller.isFinished = false;
                        },
                        child: Text('Rate Now!'),
                      )
                    ],
                  ),
                )
              : SizedBox()),
      body: GetBuilder<HomePageController>(
        builder: (controller) => PopScope(
          canPop: false,
          onPopInvoked: (dip) => alertExitApp(),
          child: Container(
            child: Center(
              child: Container(
                width: Get.width / 1.1,
                height: controller.isFinished
                    ? Get.height / 1.25
                    : Get.height / 1.15,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.search,
                              onChanged: (val) => controller.searchData(val),
                              style: const TextStyle(
                                color: AppColor.black,
                              ),
                              decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                      onPressed: () {
                                        controller.searchData(
                                            controller.search!.text);
                                      },
                                      icon: const Icon(
                                        Icons.search,
                                        color: AppColor.grey2,
                                      )),
                                  hintText: "Search Service",
                                  hintStyle: const TextStyle(
                                      fontSize: 18, color: AppColor.grey2),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(30)),
                                  filled: true,
                                  fillColor: AppColor.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    HandlingDataRequest(
                        statusRequest: controller.statusRequest,
                        widget: Expanded(
                          child: Container(
                            height: Get.height / 1.28,
                            child: GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 1.1),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              children: [
                                ...List.generate(
                                    controller.searchlist.length,
                                    (index) => Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          child: Card(
                                            color: AppColor.white,
                                            child: InkWell(
                                              onTap: () {
                                                Get.defaultDialog(
                                                  titlePadding:
                                                      EdgeInsets.all(20),
                                                  middleText:
                                                      "Confirm this Service '${controller.searchlist[index].name}' ?",
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 40),
                                                  middleTextStyle:
                                                      TextStyle(fontSize: 18),
                                                  cancel: InkWell(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 30,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  confirm: InkWell(
                                                    onTap: () {
                                                      controller.ChooseService(
                                                          controller
                                                              .searchlist[index]
                                                              .id,
                                                          controller
                                                              .searchlist[index]
                                                              .name);
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      alignment:
                                                          Alignment.center,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Text(
                                                        "Confirms",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  controller
                                                      .searchlist[index].name!,
                                                  style: TextStyle(
                                                      fontSize: Get.width / 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                subtitle: Text(
                                                  controller.searchlist[index]
                                                          .description ??
                                                      "No Description",
                                                  style: TextStyle(
                                                      fontSize: Get.width / 30,
                                                      color: AppColor.grey2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
