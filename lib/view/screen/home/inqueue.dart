import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:queue_project/controllers/inQueuecontroller.dart';
import 'package:queue_project/core/constant/color.dart';
import 'package:queue_project/core/constant/imageasset.dart';

class InQueue extends StatelessWidget {
  const InQueue({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InQueueController());
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          backgroundColor: AppColor.appbar,
          title: Text(
            "In Queue",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<InQueueController>(
          builder: (controller) => Container(
            child: ListView(
              children: [
                Container(
                  height: Get.height / 2.5,
                  child: Image.asset(
                    AppImageAsset.waiting,
                  ),
                ),
                Center(
                  child: Text(
                    "You Can Close the App now , You'll receive a Notification once it's your turn",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Service Name : ${controller.name}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (controller.istimer == 0)
                  Text(
                    "Estimated time :",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                SizedBox(
                  height: 10,
                ),
                if (controller.istimer == 0)
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: AppColor.appbar,
                          borderRadius: BorderRadius.circular(20)),
                      child: TimerCountdown(
                        timeTextStyle: TextStyle(
                          fontSize: 28,
                          color: AppColor.black,
                        ),
                        colonsTextStyle:
                            TextStyle(fontSize: 28, color: AppColor.black),
                        descriptionTextStyle:
                            TextStyle(fontSize: 18, color: AppColor.black),
                        format: CountDownTimerFormat.hoursMinutesSeconds,
                        endTime: DateTime.now().add(
                          Duration(
                            hours: 0,
                            minutes: 0,
                            seconds: controller.seconds,
                          ),
                        ),
                        onEnd: () {
                          controller.istimer = 1;
                          controller.update();
                        },
                      ),
                    ),
                  ),
                if (controller.istimer == 1)
                  Container(
                    padding: EdgeInsets.all(18),
                    child: Text(
                      "This took more than Expected , We appreciate Your waiting :)",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                if (controller.istimer == 2)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your Seat is : ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${controller.seatNumber}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.authbuttons,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
  }
}
