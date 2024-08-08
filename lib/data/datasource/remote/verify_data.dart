import 'package:queue_project/core/class/crud.dart';
import 'package:queue_project/linkapi.dart';

class VerifyData {
  Crud crud;
  VerifyData(this.crud);

  sendEmail(email, token) async {
    var response = await crud
        .postData(AppLink.sendemailotp, {'email': email, 'token': token}, {});
    return response.fold((l) => l, (r) => r);
  }

  verifyEmail(email, otp) async {
    var response = await crud
        .postData(AppLink.verifyemailotp, {'email': email, 'otp': otp}, {});
    return response.fold((l) => l, (r) => r);
  }
}
