import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:queue_project/core/class/statusrequest.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(
      String linkurl, Map data, Map<String, String> headers) async {
    try {
      if (true) {
        var response =
            await http.post(Uri.parse(linkurl), body: data, headers: headers);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 403) {
          Map responsebody = await jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> getMapData(String linkurl) async {
    try {
      var response = await http.get(Uri.parse(linkurl));

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 403) {
        Map responsebody = await jsonDecode(response.body);
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, List>> getData(String linkurl) async {
    try {
      var response = await http.get(Uri.parse(linkurl));
      print(response.statusCode);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 403) {
        List responsebody = await jsonDecode(response.body);
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }
}
