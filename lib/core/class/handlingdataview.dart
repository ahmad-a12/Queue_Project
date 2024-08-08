import 'package:flutter/material.dart';
import 'package:queue_project/core/class/statusrequest.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(child: CircularProgressIndicator())
        : statusRequest == StatusRequest.serverFailure
            ? Center(child: Text('Server Failure'))
            : statusRequest == StatusRequest.offlineFailure
                ? Center(child: Text('offlineFailure'))
                : statusRequest == StatusRequest.failure
                    ? Center(child: Text('Status Failure'))
                    : widget;
  }
}

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataRequest(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(child: CircularProgressIndicator())
        : statusRequest == StatusRequest.serverFailure
            ? Center(child: Text('Server Failure'))
            : statusRequest == StatusRequest.offlineFailure
                ? Center(child: Text('offline Failure'))
                : widget;
  }
}
