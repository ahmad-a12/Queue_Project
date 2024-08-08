import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (type == 'username') {
    if (!GetUtils.isUsername(val)) {
      return 'Username Not Valid';
    }
  }

  if (type == 'email') {
    if (!GetUtils.isEmail(val)) {
      return 'Email Not Valid';
    }
  }

  if (type == 'phone') {
    if (!GetUtils.isPhoneNumber(val)) {
      return 'Phone Not Valid';
    }
  }

  if (val.isEmpty) {
    return "Can't Be Empty";
  }

  if (val.length < min) {
    return "Can't Be Less than $min";
  }
  if (val.length > max) {
    return "Can't Be more than $max";
  }
}
